//
//  ScanData.swift
//  Pulse
//
//  Created by Andi on 07.02.24.
//

import Foundation

struct ScanData : Codable{
    let indicator : String
    let risk : String?
    let riskfactors : [RiskFactor]
    let attributes : Attribute?
    let threats : [String]
    
    static let dummy = ScanData(indicator: "Dummy Indicator", risk: "very high", riskfactors: [RiskFactor.dummy, RiskFactor.dummy], attributes: Attribute.dummy, threats: ["Dummy Threat", "Dummy Threat 2" ])
}

