//
//  RSSRepository.swift
//  Pulse
//
//  Created by Andi on 29.02.24.
//

import Foundation
import XMLCoder

struct RSSRepository{
    
    static func getRSSFeed(rss: String) async throws -> [Item]?{
        
        guard let url = URL(string: rss) else {
            throw HTTPError.invalidURL
        }
        
        let (data, _ ) = try await URLSession.shared.data(from: url)
        
        var itemList : [Item]? = []
        
        
            print(rss)
        itemList = try XMLDecoder().decode(RSS.self, from: data).channel?.item
        
        
        if itemList != nil{
            itemList?.indices.forEach{
                let date = itemList?[$0].pubDate
                itemList?[$0].updatePubDate(date: formatDate(date: date ?? "") )
            }
        }
        
        guard itemList != nil else {
            itemList = try XMLDecoder().decode(RedditFeed.self, from: data).entry?.map{
                $0.toItem()
            }
            return itemList
        }
        return itemList
    }
}
