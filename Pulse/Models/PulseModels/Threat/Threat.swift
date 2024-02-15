//
//  Threat.swift
//  Pulse
//
//  Created by Andi on 12.02.24.
//

import Foundation

struct Threat : Codable{
    let tid : Int?
    let threat, category, risk, description : String?
    let othernames : [String]?
    let attributes : [String : [String]]?
    
    static let dummy = Threat(tid: 1, threat: "Dummy Threat", category: "Dummy Cat",risk: "Very high", description: "description ---", othernames: [], attributes: [:], error: nil )
    
    let error : String?
}
