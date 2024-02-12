//
//  Threat.swift
//  Pulse
//
//  Created by Andi on 12.02.24.
//

import Foundation

struct Threat : Codable{
    let tid : Int
    let threat : String
    let category : String
    let othernames : [String]
    let risk: String
}
