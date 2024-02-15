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
    
    
    static func getThreatDetails(threatName : String) async throws -> Threat?{
        
        guard let url = URL(string:"https://pulsedive.com/api/info.php?threat=\(threatName)") else {
            throw HTTPError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            return nil
        }
        
        return try JSONDecoder().decode(Threat.self, from: data)
    }
    
}
