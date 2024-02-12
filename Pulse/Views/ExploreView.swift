//
//  ExploreView.swift
//  Pulse
//
//  Created by Andi on 07.02.24.
//

import SwiftUI

struct ExploreView: View {
    
    @State var threatName = ""
    @EnvironmentObject var viewModel : PulseViewModel
    
    var body: some View {
        
        NavigationStack{
            VStack{
                TextField("Threatname", text: $threatName)
                    .textFieldStyle(.roundedBorder)
                Button{
                    viewModel.getThreatDetails(threatName: threatName)
                }
            label: {
                Text("Scan")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .navigationTitle("Explore Threats")
                
                if let threat = viewModel.threat{
                    HStack(){
                        Text(threat.risk)
                        Text(threat.threat)
                    }
                    
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.brown)
                }
                else {
                    Text("No result")
                }
             
                Spacer()
            }
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
            .padding()
        }
    }
}

#Preview {
    ExploreView()
        .environmentObject(PulseViewModel())
}
