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
                
                DispatchQueue.main.async{
                    self.pendingScans.append(queueResult)
                }
                qid = queueResult.qid ?? -1
            }
            catch{
                print("Failed queueing the scan: \(error)")
            }
        }}
    
    
    func retrieveScanResult(){
    
            print("Retrieve Scanresult")
            Task {
                while true {
                do {
                    let scanResult = try await PulseRepository.retrieveScanResult(qid: self.qid)
                    
                    if scanResult.status == "done"{
                        guard let index =  self.pendingScans.firstIndex(where: {$0.qid == scanResult.qid}) else {
                            return
                        }
                        DispatchQueue.main.async {
                            self.pendingScans.remove(at: index)
                            self.finishedScans.append(scanResult)
                        }
                        
                        print("timer terminated")
                        break
                    }
                }
                catch{
                    print("Failed retrieving scan results: \(error)")
                }
                    try await Task.sleep(for: .seconds(10))
            }
        }
    }
    
    func getThreatDetails(threatName : String){
        self.showLoadingIndicator = true
        Task {
            do {
                threat = try await PulseRepository.getThreatDetails(threatName: threatName)
                showLoadingIndicator = false
            }
            catch {
                print("Failed getting threat details: \(error)")
            }
            
        }
    }
}
