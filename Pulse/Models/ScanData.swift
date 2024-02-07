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

    let attributes : Attribute
}
