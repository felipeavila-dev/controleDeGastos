//
//  Helpers.swift
//  controle_financeiro_swift
//
//  Created by Felipe Avila on 19/01/24.
//

import Foundation

class Helpers {
    func formatDateToString(date: String) -> String {
        var formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd"
        
        let newDate = formatter.date(from: date)
        
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: newDate!)
    }
    
    func formatStringToDate(date: String) -> Date {
        var formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd"
        
        let newDate = formatter.date(from: date)
    
        return newDate!
    }
}
