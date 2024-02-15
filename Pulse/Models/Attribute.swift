//
//  Attribute.swift
//  Pulse
//
//  Created by Andi on 07.02.24.
//

import Foundation

struct Attribute : Codable{
    let port, usedProtocol, technology : [String]?
    
    
    enum CodingKeys: String, CodingKey {
        case port
        case usedProtocol = "protocol"
        case technology
        
  }
   
    static let dummy = Attribute(port: [], usedProtocol: [], technology: [])
}
