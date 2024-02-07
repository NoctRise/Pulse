//
//  PulseRepository.swift
//  Pulse
//
//  Created by Andi on 07.02.24.
//

import Foundation

class PulseRepository {
    
    static func queueScan(ioc : String, activeScan : Bool) async throws -> ScanResult{
        
        let scanType = activeScan ? 1 : 0
        
        guard let url = URL(string:"https://pulsedive.com/api/analyze.php?value=\(ioc)&probe=\(scanType)") else {
            throw HTTPError.invalidURL
        }
        
        let (data, _ ) = try await URLSession.shared.data(from: url)
        
        return try JSONDecoder().decode(ScanResult.self, from: data)
    }
    
    static func retrieveScanResult(qid : Int) async throws -> ScanResult{
        
        guard let url = URL(string:"https://pulsedive.com/api/analyze.php?qid=\(qid)") else {
            throw HTTPError.invalidURL
        }
        
        let (data, _ ) = try await URLSession.shared.data(from: url)
        
        return try JSONDecoder().decode(ScanResult.self, from: data)
    }
    
    
}
