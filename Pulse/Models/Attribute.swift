//
//  Attribute.swift
//  Pulse
//
//  Created by Andi on 07.02.24.
//

import Foundation

struct Attribute : Codable{
    let port : [String]
    let usedProtocol : [String]
    let technology :  [String]
    
    
    enum CodingKeys: String, CodingKey {
        case port
        case usedProtocol = "protocol"
        case technology
        
  }
   
}
