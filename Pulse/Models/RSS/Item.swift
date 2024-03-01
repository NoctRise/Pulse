//
//  Item.swift
//  Pulse
//
//  Created by Andi on 29.02.24.
//

import Foundation

struct Item : Codable{
    let title: String?
    let link: String?
    var pubDate: String?
    let author: String?
    let creator: String?
    
    static let dummy = Item(title: "Dummy Title", link: "Dummy link", pubDate: "Pub date 1234", author: "Dummy Author", creator: "d")
    
    
    enum CodingKeys: String, CodingKey {
        case title
        case link
        case pubDate
        case author
        case creator = "dc:creator"
        
    }
    
    mutating func updatePubDate(date : String ){
        pubDate = date
    }
}

