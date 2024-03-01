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
    case "unknown" : return Color.gray
    default: return Color.black
    }
}


// ---------- ChatGPT ----------
func formatDate(date : String ) -> String {
    
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = TimeZone.current
    let outputFormat = "dd-MM HH:mm"
    
    let possibleDateFormats = [
        "yyyy-MM-dd'T'HH:mm:ssZ",
        "yyyy-MM-dd'T'HH:mm:ss.SSSZ",
        "yyyy-MM-dd'T'HH:mm:ss",
        "EEE, dd MMM yyyy HH:mm:ss ZZZZ",
        "EEE, dd MMM yyyy HH:mm:ss z",
        "yyyy-MM-dd HH:mm:ss",
        "yyyy-MM-dd HH:mm:ss.SSS",
        "yyyy-MM-dd",
        "yyyy/MM/dd",
        "dd/MM/yyyy",
        "MM/dd/yyyy",
        "dd-MM-yyyy",
        "MM-dd-yyyy"
    ]
    for format in possibleDateFormats {
        dateFormatter.dateFormat = format
        if let newDate = dateFormatter.date(from: date) {
            dateFormatter.dateFormat = outputFormat
            let formattedString = dateFormatter.string(from: newDate)
            return formattedString
        }
    }
    print(date)
    return ""
}
// ----------
