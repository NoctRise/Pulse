//
//  QueueResult.swift
//  Pulse
//
//  Created by Andi on 07.02.24.
//

import Foundation

struct ScanResult : Codable{
    let data : ScanData?
    let success : String
    let qid : Int
    let status : String?
}
