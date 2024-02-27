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
    @State var showAlert = false
    
    private var disableButton : Bool {
        searchTerm.isEmpty
    }
    
    var body: some View {
        
        NavigationStack{
            
            VStack{
                TextField("google.com", text: $searchTerm)
                    .textFieldStyle(.roundedBorder)
                
                Toggle(isOn: $activeScan, label: {
                    HStack{
                        Text("Active scan")
                        Button{
                            showAlert.toggle()
                        } label: {
                            Image(systemName: "questionmark.circle")
                        }
                    }
                    
                })
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Info"), message: Text("Passive scans fetch data without reaching out directly to the indicator, including performing WHOIS and DNS requests. Active scans are more noisy; we'll do a quick port scan and reach out to the indicator with a web browser."), dismissButton: .default(Text("OK")))
                }
                
                Button{
                    pulseViewModel.queueScan(ioc: searchTerm, activeScan: activeScan)
                    searchTerm = ""
                }
            label: {
                Text("Scan")
                    .frame(maxWidth: .infinity)
            }
            .disabled(disableButton)
            .buttonStyle(.borderedProminent)
                
                Button("Retrieve Result"){
                    pulseViewModel.retrieveScanResult()
                }
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
