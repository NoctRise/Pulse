//
//  RedditViewModel.swift
//  Pulse
//
//  Created by Andi on 15.02.24.
//

import Foundation

@MainActor
class RedditViewModel : ObservableObject{
    
    private var subReddit = ["InfoSecNews","blueteamsec","netsec"]
    
    @Published var posts : [RedditPost]?
    
    func getRedditPosts(){
        
        var newPosts : [RedditPost] = []
        Task {
            for subRedditName in subReddit{
                do {
                    let post = try await RedditRepository.getRedditPosts(subReddit: subRedditName).data.children
                    newPosts.append(contentsOf: post!)
                }
                catch{
                    print("Failed getting subreddit information: \(error)")
                }
            }
            posts = newPosts.sorted(by: {$0.data?.created ?? 0.0 > $1.data?.created ?? 0.0})
        }
    }
}
