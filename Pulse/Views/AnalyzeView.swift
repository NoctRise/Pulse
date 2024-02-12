//
//  AnalyzeView.swift
//  Pulse
//
//  Created by Andi on 07.02.24.
//

import SwiftUI

struct AnalyzeView: View {
    @State var searchTerm = ""
    @State var activeScan = false
    @EnvironmentObject var pulseViewModel : PulseViewModel
    
    
    var body: some View {
        
        NavigationStack{
            
            VStack{
                
                TextField("google.com", text: $searchTerm)
                    .textFieldStyle(.roundedBorder)
                Toggle("Active scan", isOn: $activeScan)
                
                Button{
                    pulseViewModel.queueScan(ioc: searchTerm, activeScan: activeScan)
                }
            label: {
                Text("Scan")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
                Button("Retrieve Result"){
                    pulseViewModel.retrieveScanResult()
                }
                .buttonStyle(.borderedProminent)
                
                
                    if(!pulseViewModel.pendingScans.isEmpty){
                        Text("Pending Scans")
                            .font(.headline)
                        List(pulseViewModel.pendingScans, id: \.qid){ scan in
                            Text("Queue id: \(String(scan.qid))")
                            
                        }
                    }

                Text("Finished Scans")
                    .font(.headline)
                List(pulseViewModel.finishedScans, id: \.qid){ scan in
                    NavigationLink("\(scan.data?.indicator ?? "\(scan.qid)")"){
                        ScanResultDetailView(scanResult: scan)
                    }
                }
            }
            .padding()
            .disableAutocorrection(true)
            .textInputAutocapitalization(.never)
            .navigationTitle("Analyze")
        }
    }
}

#Preview {
    AnalyzeView()
        .environmentObject(PulseViewModel())
}
