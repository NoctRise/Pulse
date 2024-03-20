//
//  ThreatDetailView.swift
//  Pulse
//
//  Created by Andi on 13.02.24.
//

import SwiftUI

struct ThreatDetailView: View {
    
    var threat : Threat
    var attributeStrings = ["technology","industry","tactic", "technique"]
    
    var body: some View {
        Form{
            
            if let risk = threat.risk{
                Section("Risk"){
                        Text(risk)
                        .foregroundStyle(getRiskColor(risk: risk))
                }
            }
            
            if let category = threat.category{
                Section("Category"){
                    Text(category)
                }
            }
            
            if let othernames = threat.othernames, !othernames.isEmpty{
                
                Section("Other names"){
                    Text((othernames.joined(separator: " | ")))
                }
            }

            if let description = threat.description, !description.isEmpty {
                Section("Description"){
                    let regex = #"\((.*?)\)"#
                    let descriptionWithoutLinks = description .replacingOccurrences(of: regex, with: "", options: .regularExpression, range: nil)
                    Text(descriptionWithoutLinks)
                }
            }
            else if let summary = threat.wikisummary {
                Section("Wikisummary"){
                    Text(summary)
                }
            }
            
            ForEach(attributeStrings, id: \.self){attributeString in
                if let attributeList = threat.attributes?[attributeString]{
                    Section(attributeString){
                        ForEach(attributeList, id: \.self){ attribute in
                            Text(attribute)
                        }
                    }
                }
            }
        }
        .navigationTitle(threat.threat!)
    }
}

#Preview {
    ThreatDetailView(threat: Threat.dummy )
}
