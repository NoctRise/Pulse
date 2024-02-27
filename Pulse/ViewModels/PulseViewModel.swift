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
                qid = queueResult.qid ?? -1
            }
            catch{
                print("Failed queueing the scan: \(error)")
            }
        }}
    
    
    func retrieveScanResult(){
        
        
        Timer.scheduledTimer(withTimeInterval: 10, repeats: true, block: { timer in
            print("Retrieve Scanresult")
            Task {
                do {
                    let scanResult = try await PulseRepository.retrieveScanResult(qid: self.qid)
                    
                    if scanResult.status == "done"{
                        guard let index = await self.pendingScans.firstIndex(where: {$0.qid == scanResult.qid}) else {
                            return
                        }
                        self.pendingScans.remove(at: index)
                        self.finishedScans.append(scanResult)
                        timer.invalidate()
                        print("timer terminated")
                    }
                    
                }
                catch{
                    print("Failed retrieving scan results: \(error)")
                }
            }
            })
        
        
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
