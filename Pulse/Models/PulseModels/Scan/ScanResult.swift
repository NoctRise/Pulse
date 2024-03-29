//
//  QueueResult.swift
//  Pulse
//
//  Created by Andi on 07.02.24.
//

import Foundation

struct ScanResult : Codable{
    let data : ScanData?
    let success, status : String?
    let qid : Int?
    
    static let dummy = ScanResult(data: ScanData.dummy, success: "Success", status: "done", qid: 37373737373737)
}
