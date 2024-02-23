//
//  Util.swift
//  Pulse
//
//  Created by Andi on 22.02.24.
//

import Foundation
import SwiftUI

func getRiskColor(risk : String) -> Color{
    switch risk.lowercased() {
    case "critical","very high","high"  : return Color.red
    case "medium" : return Color.orange
    case "low": return Color.yellow
    case "none": return  Color.green
    default: return Color.black
    }
}
