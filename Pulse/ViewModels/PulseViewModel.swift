//
//  PulseViewModel.swift
//  Pulse
//
//  Created by Andi on 07.02.24.
//

import Foundation

@MainActor
class PulseViewModel : ObservableObject{
    
    @Published var pendingScans : [ScanResult] = []
    @Published var finishedScans: [ScanResult] = []
    private var qid = 0
    @Published var threat : Threat?
    
    @Published var showLoadingIndicator = false
    
    
    func queueScan(ioc : String, activeScan : Bool){
        Task {
            do {
                let queueResult = try await PulseRepository.queueScan(ioc: ioc, activeScan: activeScan)
                pendingScans.append(queueResult)
                qid = queueResult.qid
            }
            catch{
                print("Failed queueing the scan: \(error)")
            }
        }
    }
    
    
    func retrieveScanResult(){
        Task {
            do {
                let scanResult = try await PulseRepository.retrieveScanResult(qid: qid)
                
                if scanResult.status == "done"{
                    guard let index = pendingScans.firstIndex(where: {$0.qid == scanResult.qid}) else {
                        return
                    }
                    pendingScans.remove(at: index)
                    finishedScans.append(scanResult)
                }
                
            }
            catch{
                print("Failed retrieving scan results: \(error)")
            }
        }
    }
    
    func getThreatDetails(threatName : String){
        Task {
            do {
                showLoadingIndicator = true
             threat = try await PulseRepository.getThreatDetails(threatName: threatName)
            }
            catch {
                print("Failed getting threat details: \(error)")
            }
            showLoadingIndicator = false
        }
    }
    
}
