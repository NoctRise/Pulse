//
//  ExploreView.swift
//  Pulse
//
//  Created by Andi on 07.02.24.
//

import SwiftUI

struct ExploreView: View {
    
    @State var threatSearchString = ""
    @EnvironmentObject var viewModel : PulseViewModel
    @State var showAlert = false
    @State var searched = false
    
    var body: some View {
        
        NavigationStack{
            VStack{
                TextField("Threatname", text: $threatSearchString)
                    .textFieldStyle(.roundedBorder)
                Button{
                    if !threatSearchString.isEmpty{
                        viewModel.getThreatDetails(threatName: threatSearchString)
                        threatSearchString = ""
                        searched = true
                    }
                    else{
                        showAlert = true
                    }
                }
            label: {
                Text("Search")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .navigationTitle("Explore Threats")
                
                if let threat = viewModel.threat{
                    ThreatListItemView(threat: threat)
                }
                else {
                    if searched && viewModel.threat == nil && !viewModel.showLoadingIndicator {
                        Text("No result")
                    }
                    else if viewModel.showLoadingIndicator {
                        ProgressView()
                    }
                    
                }
                
                Spacer()
            }
            
            .onDisappear {
                searched = false
            }
            
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"), message: Text("Please enter some text!"), dismissButton: .default(Text("OK")))
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

