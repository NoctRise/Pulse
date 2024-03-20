//
//  SettingsViewModel.swift
//  Pulse
//
//  Created by Andi on 13.03.24.
//

import Foundation

class SettingsViewModel : ObservableObject{
    
    @Published var newPassword1 = ""
    @Published var newPassword2  = ""
    @Published var showAlert = false
    @Published var feedURL = ""
    @Published var deleteConfirmationAlert = false
    
    private var firebaseManager = FirebaseManager.shared
    
    @Published var feeds : [String] = []
    
    init(){
        fetchFeeds()
    }
    
    
    
    func fetchFeeds(){
        guard let userID = firebaseManager.userID else {return}
        firebaseManager.database.collection("users").document(userID).getDocument{ document, error in
            if let error{
                print("Fetching user failed: \(error.localizedDescription)")
                return
            }
            
            guard let document else {
                print("No Document found.")
                return
            }
            
            do {
                self.feeds = try document.data(as: FireUser.self).feeds
                
            }
            catch {
                print("Document is not a user. \(error.localizedDescription)")
            }
        }
    }
    
    func addFeed(){
        
        if !feeds.contains(where: {$0 == feedURL}) && !feedURL.isEmpty
        {
            feeds.append(feedURL)
            updateFeedList()
        }
        clearFeedURL()
    }
    
    func clearFeedURL(){
        feedURL = ""
    }
    
    func deleteFeed(feed : String){
        
        guard let index = feeds.firstIndex(where: {$0 == feed}) else {return}
        
        feeds.remove(at: index)
        updateFeedList()
    }
    
    func updateFeedList(){
        guard let userID = FirebaseManager.shared.userID else {return}
        
        do  {
            try FirebaseManager.shared.database.collection("users").document(userID).setData(from: ["feeds" : feeds], merge : true)
        }
        catch{
            print("Error adding items to feeds. \(error)")
        }
    }
    
    func deleteUserData(){
        
        Task{
        
            do {
                guard let userID = FirebaseManager.shared.userID else {return}
                try await firebaseManager.database.collection("users").document(userID).delete()
                print("Document successfully removed!")   
            }
            catch {
                print("Error removing document: \(error)")
            }
        }
    }
    
}

extension SettingsViewModel{
    static let shared = SettingsViewModel()
}
