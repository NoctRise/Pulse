//
//  RSSViewModel.swift
//  Pulse
//
//  Created by Andi on 29.02.24.
//

import Foundation
import FirebaseFirestore

@MainActor
class RSSViewModel : ObservableObject {
    
    private let firebaseManager = FirebaseManager.shared
    
    
    private var rss = ["https://www.bleepingcomputer.com/feed/", "https://www.darkreading.com/rss.xml", "https://www.reddit.com/r/netsec/new/.rss", "https://www.reddit.com/r/blueteamsec/.rss"]
    
    @Published var feed : [Item]?
    
    @Published var showWebView = false
    @Published var url = ""
    @Published var showSettings = false
    
    @Published var favorites : [Item] = []
    
    private var listener : ListenerRegistration?
    
    init(){
        getRSSFeed()
        fetchFavoriteList()
    }
    
    func getRSSFeed(){
        
        var newFeed : [Item] = []
        Task {
            for rssName in rss{
                do {
                    guard let feed = try await RSSRepository.getRSSFeed(rss: rssName) else {
                        print("error getting Rss feed")
                        return
                    }
                    
                    newFeed.append(contentsOf: feed)
                }
                catch{
                    print("Failed getting getting rss feed: \(error)")
                }
            }
            feed = newFeed.sorted(by: {
                $0.pubDate ?? "1" > $1.pubDate ?? "2"
            })
            
            
            
        }
    }
    
    func showWebView(url : String){
        self.url = url
        showWebView.toggle()
    }
    
    func favoriteArticle(article : Item){
        
        if !favorites.contains(where: {$0.title == article.title})
        {
            favorites.append(article)
            
            updateArticle()
        }
    }
    
    private func updateArticle(){
        
        guard let userID = FirebaseManager.shared.userID else {return}
        
        do  {
            try FirebaseManager.shared.database.collection("users").document(userID).setData(from: ["favorites" : favorites], merge : true)
        }
        catch{
            print("Error adding items to favorites. \(error)")
        }
    }
    
    
    func unfavoriteArticle(article: Item){
        
        guard let index = favorites.firstIndex(where: {$0.title == article.title}) else {return}
        
        favorites.remove(at: index)
        updateArticle()
    }
   
    
    func fetchFavoriteList(){
        
        guard let userID = FirebaseManager.shared.userID else {return}
        
        self.listener = FirebaseManager.shared.database.collection("users").document(userID).addSnapshotListener { querySnapShot, error in
            
          if let error {
            print (error.localizedDescription)
            return
          }
            
          guard let documents = querySnapShot else {
            print("Error fetching user")
            return
          }
            
          do {
            self.favorites = try documents.data(as: FireUser.self).favorites
          } 
            catch{
            print("Error converting to fireuser. \(error)")
          }
        }
      }
    
}

