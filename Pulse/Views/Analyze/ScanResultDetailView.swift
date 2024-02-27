//
//  ScanResultDetailView.swift
//  Pulse
//
//  Created by Andi on 08.02.24.
//

import SwiftUI

struct ScanResultDetailView: View {
    var scanResult : ScanResult
    
    var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    
    
    var body: some View {
        
        VStack(alignment: .leading){
            
            
            ZStack{
                RoundedRectangle(cornerRadius: 25)
                    .fill(.white)
                    .shadow(color: .gray , radius: 3)
                    .frame(maxHeight: 100)
                VStack{
                    Text(scanResult.data?.indicator ?? "")
                        .font(.title)
                    
                    HStack{
                        Text("Risklevel: ")
                        Text("\(scanResult.data?.risk ?? "no value found")")
                            .foregroundStyle(getRiskColor(risk: scanResult.data?.risk ?? ""))
                    }
                }
            }.padding(.bottom)
            
            
            List{
                if let riskFactors = scanResult.data?.riskfactors{
                    Section("Risk factors") {
                        ForEach(riskFactors, id: \.rfid){ riskFactor in
                            HStack{
                                Text(riskFactor.description)
                                Text(riskFactor.risk)
                                    .font(.subheadline)
                                    .foregroundStyle(getRiskColor(risk: riskFactor.risk))
                            }
                        }
                    }
                }
                
                if let ports = scanResult.data?.attributes?.port{
                    Section("Ports") {
                        HStack{
                            ForEach(ports, id: \.self){ port in
                                Text("\(port) ")
                            }
                        }
                    }
                }
                
                if let protocols = scanResult.data?.attributes?.usedProtocol{
                    Section("Protocols") {
                        HStack{
                            ForEach(protocols, id: \.self){ proto in
                                Text("\(proto) ")
                                    .padding(.horizontal, 2)
                            }
                        }
                    }
                }
                
                if let technology = scanResult.data?.attributes?.technology{
                    Section("Technology") {
    
                        LazyVGrid(columns: gridItemLayout){
                            ForEach(technology, id: \.self){ tech in
                                Text("\(tech) ")
                            }
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
            .scrollContentBackground(.hidden)
            .listStyle(.grouped)
            
            Spacer()
        }
        .padding(.horizontal)
    }
}

#Preview {
    ScanResultDetailView(scanResult: ScanResult.dummy)
}
