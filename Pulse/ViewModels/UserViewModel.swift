//
//  UserViewModel.swift
//  Pulse
//
//  Created by Andi on 19.02.24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class UserViewModel : ObservableObject{
    
    private let firebaseManager = FirebaseManager.shared
    @Published var user : FireUser?
    
    var userIsLoggedIn : Bool{
        user != nil
    }
    
    @Published var loginState = true
    @Published var email = ""
    @Published var password = ""
    
    var disableButton : Bool {
        email.isEmpty || password.isEmpty
    }
    
    
    private var listener : ListenerRegistration?
    
    init() {
        checkAuth()
        print(user ?? "No user found")
    }
        
    private func checkAuth(){
        guard let currentUser = firebaseManager.auth.currentUser else {
            print("Not logged in")
            return
        }
        self.fetchUser(id: currentUser.uid)
    }
    
    func createUser(id : String,email : String){
        let user = FireUser(id: id, email: email, registeredAt: Date(), favorites: [], feeds: ["https://www.bleepingcomputer.com/feed/", "https://www.darkreading.com/rss.xml", "https://www.reddit.com/r/netsec/new/.rss", "https://www.reddit.com/r/blueteamsec/.rss"])
        
        do {
            try firebaseManager.database.collection("users").document(id).setData(from:user)
        }
        catch {
            print("Fehler beim Speichern des Users: \(error)")
        }
    }
    
    private func fetchUser(id: String){
          let userRef = firebaseManager.database.collection("users").document(id)
          listener = userRef.addSnapshotListener { documentSnapshot, error in
            guard let document = documentSnapshot else {
              print("Error fetching document: \(error!)")
              return
            }
            guard let user = try? document.data(as: FireUser.self) else {
              print("Document does not exist")
              return
            }
            self.user = user
          }
        }
    
    func login (){
        firebaseManager.auth.signIn(withEmail: email, password: password){ authResult, error in
            if let error{
                print("Login failed: ", error.localizedDescription)
                return
            }
            
            guard let authResult, let email = authResult.user.email else {return}
            print("User with email \(email) is logged in with id \(authResult.user.uid).")
            
            self.fetchUser(id: authResult.user.uid)
            
        }
    }
    
    func register(){
        firebaseManager.auth.createUser(withEmail: email, password: password){ authResult, error in
            if let error{
                print("Registration failed: ", error.localizedDescription)
                return
            }
            
            guard let authResult, let email = authResult.user.email else {return}
            print("User with email \(email) is registered in with id \(authResult.user.uid).")
            
            self.createUser(id: authResult.user.uid, email: email)
            self.login()
        }
    }
    
    
    func logout(){
        do{
            try firebaseManager.auth.signOut()
            self.user = nil
            print("User logged out.")
        }
        catch{
            print("Error signing out: ", error.localizedDescription)
        }
    }
}
