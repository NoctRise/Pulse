//
//  ThreatViewModel.swift
//  Pulse
//
//  Created by Andi on 13.03.24.
//

import Foundation

@MainActor
class ThreatViewModel : ObservableObject{
 
    @Published var threat : Threat?
    @Published var showLoadingIndicator = false
    
    @Published var threatSearchString = ""
    @Published var searched = false
    
    
    var disableButton : Bool {
        threatSearchString.isEmpty
    }
 
    func getThreatDetails(){
        self.showLoadingIndicator = true
        Task {
            do {
                threat = try await PulseRepository.getThreatDetails(threatName: threatSearchString)
                showLoadingIndicator = false
                threatSearchString = ""
                searched = true
            }
            catch {
                print("Failed getting threat details: \(error)")
                showLoadingIndicator = false
                searched = true
            }
            
        }
    }
}
