//
//  RedditReponse.swift
//  Pulse
//
//  Created by Andi on 15.02.24.
//

import Foundation

struct RedditReponse : Codable{
    let data : RedditData
}


struct RedditData : Codable{
    let children : [RedditPost]?
}
