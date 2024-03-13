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
    
    @Published var searchTerm = ""
    @Published var activeScan = false
    @Published var showAlert = false
    var disableButton : Bool {
        searchTerm.isEmpty
    }
    
    func queueScan(){
        Task {
            do {
                let queueResult = try await PulseRepository.queueScan(ioc: searchTerm, activeScan: activeScan)
                
                DispatchQueue.main.async{
                    self.pendingScans.append(queueResult)
                }
                qid = queueResult.qid ?? -1
                retrieveScanResult()
                
                searchTerm = ""
            }
            catch{
                print("Failed queueing the scan: \(error)")
            }
        }}
    
    
    private func retrieveScanResult(){
    
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
}
