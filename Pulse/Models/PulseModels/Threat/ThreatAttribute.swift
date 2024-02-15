//
//  ThreatAttribute.swift
//  Pulse
//
//  Created by Andi on 13.02.24.
//

import Foundation

struct ThreatAttribute : Codable{
    let tactic, technique, technology, industry : [String]
}
