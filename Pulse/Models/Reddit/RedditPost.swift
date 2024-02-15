//
//  RedditPost.swift
//  Pulse
//
//  Created by Andi on 15.02.24.
//

import Foundation

struct RedditPost : Codable{
    let data : RedditPostData?
}

struct RedditPostData : Codable, Identifiable{
    var id : String? = UUID().uuidString
    let subreddit_name_prefixed, title, author, permalink : String
    let created : Double
    static var dummy = RedditPostData(subreddit_name_prefixed: "DummySubreddit", title: "Dummy Title: Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua", author: "Dummy Author", permalink: "Dummy Link", created: -1.0)
}
