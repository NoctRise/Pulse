//
//  ThreatListView.swift
//  Pulse
//
//  Created by Andi on 12.02.24.
//

import SwiftUI

struct ThreatListItemView: View {
    
    let threat : Threat
    
    
    var body: some View {
    
        List {
            NavigationLink(destination: ThreatDetailView(threat: threat)){
                HStack{
                    if let risk = threat.risk{
                        Text("Risk: \(risk)")
                    }
                    
                    VStack(alignment: .leading){
                        
                        if let threat = threat.threat{
                            Text(threat)
                        }
                        
                        if let othernames = threat.othernames{
                            Text(othernames.joined(separator: " | ")).lineLimit(1)
                        }
                        
                        if let category = threat.category{
                            Text(category)
                        }
                        
                    }
                    
                }
                
            }.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
        }
        .listStyle(.plain)
    }
}

#Preview {
    ThreatListItemView(threat: Threat.dummy )
}
