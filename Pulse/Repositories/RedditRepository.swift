//
//  RedditRepository.swift
//  Pulse
//
//  Created by Andi on 15.02.24.
//

import Foundation

struct RedditRepository{
 
    
    static func getRedditPosts(subReddit: String) async throws -> RedditReponse{
        
        
        guard let url = URL(string:"https://www.reddit.com/r/\(subReddit)/.json") else {
            throw HTTPError.invalidURL
        }
        
        let (data, _ ) = try await URLSession.shared.data(from: url)
     
        return try JSONDecoder().decode(RedditReponse.self, from: data)
    }
}
