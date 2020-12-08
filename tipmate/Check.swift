//
//  Check.swift
//  tipmate
//
//  Created by Meghan Castro on 12/7/20.
//

// import files
import Foundation
import SwiftUI

class Check: ObservableObject {
    
    // initialize variables as default values
    @Published var percent: Double = 15
    var subtotal: Double = 0
    var tip:      Double = 0
    var total:    Double = 0
    
    // allow no currency symbol, extra digits, etc
    var currencyFormatter: NumberFormatter = {
         let f = NumberFormatter()
         f.isLenient = true
         f.numberStyle = .currency
         return f
     }()
    
    // setSubtotal function - updates the subtotal variable using the provided input string
    func setSubtotal(str: String) {
        subtotal = atof(str)
    }
    
    // getSubtotal function - returns the subtotal value as a formatted string (0.00 -> "$0.00")
    func getSubtotal() -> String {
        return currencyFormatter.string(from: NSNumber(value: subtotal)) ?? "--"
    }
    
    // getPercent function - returns the percent value as a formatted string (0.00 -> "0%")
    func getPercent() -> String {
        return String(format: "%.0f", percent) + "%"
    }
    
    // getTip function - calculates and returns the tip value as a formatted string (0.00 -> "$0.00")
    func getTip() -> String {
        tip = subtotal * (percent / 100)
        return currencyFormatter.string(from: NSNumber(value: tip)) ?? "--"
    }
    
    // getTotal function - calculates and returns the total value as a formatted string (0.00 -> "0.00")
    func getTotal() -> String {
        total = subtotal + tip
        return currencyFormatter.string(from: NSNumber(value: total)) ?? "--"
    }
}
