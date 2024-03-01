//
//  Entry.swift
//  Pulse
//
//  Created by Andi on 29.02.24.
//

import Foundation

struct Entry : Codable{
    let author: Author?
    let id: String?
    let title: String?
    let link: EntryLink
    let published : String
    
    static let dummy = Entry(author: Author.dummy, id: "737372372", title: "Dummy Title", link: EntryLink.dummy, published: "2022")
    
    
    func toItem() -> Item {
        return Item(title: self.title, link: self.link.href, pubDate: formatDate(date: self.published), author: self.author?.name, creator: nil)

    }
}
