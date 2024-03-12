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
        let user = FireUser(id: id, email: email, registeredAt: Date(), favorites: [])
        
        do {
            try firebaseManager.database.collection("users").document(id).setData(from:user)
        }
        catch {
            print("Fehler beim Speichern des Users: \(error)")
        }
    }
    
//    func fetchUser(id : String){
//        firebaseManager.database.collection("users").document(id).getDocument{ document, error in
//            if let error{
//                print("Fetching user failed: \(error.localizedDescription)")
//                return
//            }
//            
//            guard let document else {
//                print("No Document found.")
//                return
//            }
//            
//            do {
//                let user = try document.data(as: FireUser.self)
//                self.user = user
//            }
//            catch {
//                print("Document is not a user. \(error.localizedDescription)")
//            }
//        }
//    }
    
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










    
    
    
    func login (email : String, password: String){
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
    
    func register(email: String, password: String){
        firebaseManager.auth.createUser(withEmail: email, password: password){ authResult, error in
            if let error{
                print("Registration failed: ", error.localizedDescription)
                return
            }
            
            guard let authResult, let email = authResult.user.email else {return}
            print("User with email \(email) is registered in with id \(authResult.user.uid).")
            
            self.createUser(id: authResult.user.uid, email: email)
            self.login(email: email, password: password)
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
