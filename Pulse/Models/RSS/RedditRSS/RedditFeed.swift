//
//  RSSResponse.swift
//  Pulse
//
//  Created by Andi on 29.02.24.
//

import Foundation


struct RedditFeed : Codable{
    let icon: String?
    let id: String?
    let subtitle, title: String?
    let entry: [Entry]?
}
