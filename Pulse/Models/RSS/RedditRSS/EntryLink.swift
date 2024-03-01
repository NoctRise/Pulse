//
//  EntryLink.swift
//  Pulse
//
//  Created by Andi on 29.02.24.
//

import Foundation

struct EntryLink : Codable{
    let href: String
    
    static let dummy = EntryLink(href: "https://dummy.com")
}
