//
//  ScanResultDetailView.swift
//  Pulse
//
//  Created by Andi on 08.02.24.
//

import SwiftUI

struct ScanResultDetailView: View {
    var scanResult : ScanResult
    var body: some View {
        
        VStack(alignment: .leading){
            Text("Name: \(scanResult.data?.indicator ?? "")" )
                .font(.headline)
            Text("Risklevel: \(scanResult.data?.risk ?? "no value found")")
            
            if let riskFactors = scanResult.data?.riskfactors{
                ForEach(riskFactors, id: \.rfid){ riskFactor in
                    HStack{
                        Text(riskFactor.description)
                        Text(riskFactor.risk)
                            .font(.subheadline)
                    }
                }
            }
            if let ports = scanResult.data?.attributes.port{
                HStack{
                    ForEach(ports, id: \.self){ port in
                     Text("\(port) ")
                    }
                }
            }
            
            if let protocols = scanResult.data?.attributes.usedProtocol{
                HStack{
                    ForEach(protocols, id: \.self){ proto in
                     Text("\(proto) ")
                    }
                }
            }
            
        }
        
    }
}

#Preview {
    ScanResultDetailView(scanResult: ScanResult(data: nil, success: "success", status: "finished", qid: 213123123))
}
