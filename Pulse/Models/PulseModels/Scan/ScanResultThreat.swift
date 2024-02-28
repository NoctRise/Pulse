//
//  ScanResultThreat.swift
//  Pulse
//
//  Created by Andi on 28.02.24.
//

import Foundation

struct ScanResultThreat : Codable{
    
    let tid : Int?
    let name, category, risk : String?
    
    static let dummy = [ScanResultThreat(tid: 1, name: "Threat1", category: "Description1", risk: "none"),
                        ScanResultThreat(tid: 2, name: "Threat2", category: "Description2", risk: "high")]
}
