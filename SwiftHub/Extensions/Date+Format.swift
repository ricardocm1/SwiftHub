//
//  Date+Format.swift
//  SwiftHub
//
//  Created by Ricardo Carra Marsilio on 29/10/20.
//

import Foundation

extension Date {
    
    var formatted: String {
        let formatter = DateFormatter()
//        formatter.dateFormat = "dd/MM/yyyy"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        formatter.setLocalizedDateFormatFromTemplate("dd/MM/yyyy")
        
        return formatter.string(from: self)
    }
}
