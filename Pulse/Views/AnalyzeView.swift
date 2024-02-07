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
    @StateObject var pulseViewModel = PulseViewModel()
    
    
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
            
                Text("\(pulseViewModel.scanResult?.qid ?? -1)")
            Spacer()
            
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
}
