//
//  PulseViewModel.swift
//  Pulse
//
//  Created by Andi on 07.02.24.
//

import Foundation

class PulseViewModel : ObservableObject{
    
    @Published var pendingScans = []
    @Published var finishedScans = []
    @Published var scanResult : ScanResult?
    
    func queueScan(ioc : String, activeScan : Bool){
        Task {
            do {
                scanResult = try await PulseRepository.queueScan(ioc: ioc, activeScan: activeScan)
            }
            catch{
                print("Request failed with error: \(error)")
            }
        }
        
    }
    
    
}
