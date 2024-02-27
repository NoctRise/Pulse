//
//  RiskFactor.swift
//  Pulse
//
//  Created by Andi on 07.02.24.
//

import Foundation

struct RiskFactor : Codable{
    let rfid : Int?
    let description, risk : String
    
    static let dummy = RiskFactor(rfid: Int.random(in: 1...100), description: "Dummy Description", risk: ["none","low", "medium", "high"].randomElement() ?? "none")
}
