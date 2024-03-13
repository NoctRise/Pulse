//
//  ExploreView.swift
//  Pulse
//
//  Created by Andi on 07.02.24.
//

import SwiftUI

struct ExploreView: View {
    

    @EnvironmentObject var viewModel : ThreatViewModel
    
    var body: some View {
        
        NavigationStack{
            VStack{
                TextField("Threatname", text: $viewModel.threatSearchString)
                    .textFieldStyle(.roundedBorder)
                Button{
                        viewModel.getThreatDetails()
                }
            label: {
                Text("Search")
                    .frame(maxWidth: .infinity)
            }
            .disabled(viewModel.disableButton)
            .buttonStyle(.borderedProminent)
            .navigationTitle("Explore Threats")
                
                if let threat = viewModel.threat{
                    ThreatListItemView(threat: threat)
                }
                else {
                    if viewModel.searched && viewModel.threat == nil && !viewModel.showLoadingIndicator {
                        Text("No result")
                    }
                    else if viewModel.showLoadingIndicator {
                        ProgressView("Searching...")
                    }
                    
                }
                
                Spacer()
            }
            
            .onDisappear {
                viewModel.searched = false
            }            
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
            .padding()
        }
    }
}


#Preview {
    ExploreView()
        .environmentObject(ThreatViewModel())
}

