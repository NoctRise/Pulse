//
//  Author.swift
//  Pulse
//
//  Created by Andi on 29.02.24.
//

import Foundation

struct Author : Codable {
    let name: String?
    let uri: String?
    
    static let dummy = Author(name: "Dummy Author", uri: "dummy uri")
}
