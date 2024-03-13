//
//  AnalyzeView.swift
//  Pulse
//
//  Created by Andi on 07.02.24.
//

import SwiftUI

struct AnalyzeView: View {
    
    @EnvironmentObject var pulseViewModel : PulseViewModel
    
    var body: some View {
        
        NavigationStack{
            
            VStack{
                TextField("google.com", text: $pulseViewModel.searchTerm)
                    .textFieldStyle(.roundedBorder)
                
                Toggle(isOn: $pulseViewModel.activeScan, label: {
                    HStack{
                        Text("Active scan")
                        Button{
                            pulseViewModel.showAlert.toggle()
                        } label: {
                            Image(systemName: "questionmark.circle")
                        }
                    }
                    
                })
                .alert(isPresented: $pulseViewModel.showAlert) {
                    Alert(title: Text("Info"), message: Text("Passive scans fetch data without reaching out directly to the indicator, including performing WHOIS and DNS requests. Active scans are more noisy; we'll do a quick port scan and reach out to the indicator with a web browser."), dismissButton: .default(Text("OK")))
                }
                
                Button{
                    pulseViewModel.queueScan()
                    
                }
            label: {
                Text("Scan")
                    .frame(maxWidth: .infinity)
            }
            .disabled(pulseViewModel.disableButton)
            .buttonStyle(.borderedProminent)
                
                
                if(!pulseViewModel.pendingScans.isEmpty){
                    Divider()
                    Text("Current Scans")
                        .font(.headline)
                
                        List(pulseViewModel.pendingScans, id: \.qid){ scan in
                            HStack{
                                Text("Queue id: \(String(scan.qid ?? -1))")
                                Spacer()
                                ProgressView()
                            }
                            
                        }
                }
                if(!pulseViewModel.finishedScans.isEmpty){
                    Divider()
                    Text("Finished Scans")
                        .font(.headline)
                    List(pulseViewModel.finishedScans, id: \.qid){ scan in
                        NavigationLink("\(scan.data?.indicator ?? "\(String(describing: scan.qid))")"){
                            ScanResultDetailView(scanResult: scan)
                        }
                    }
                }
            }
            .listStyle(.plain)
            .padding()
            .disableAutocorrection(true)
            .textInputAutocapitalization(.never)
            .navigationTitle("Analyze")
            Spacer()
        }
    }
}

#Preview {
    AnalyzeView()
        .environmentObject(PulseViewModel())
}
