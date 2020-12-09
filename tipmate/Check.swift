//
//  Check.swift
//  tipmate
//
//  Created by Meghan Castro on 12/7/20.
//

// import files
import Foundation
import SwiftUI

public class Check: ObservableObject {
    
    // declare variables
    @Published var percent: Double
    @Published var inputStr : String
    
    var subtotal: Double
    var tip:      Double
    var total:    Double
    var formatter: NumberFormatter
  
    // initialize variables using default values
    init(formatter: @escaping () -> NumberFormatter = { () -> NumberFormatter in
        let nf = NumberFormatter()
        nf.isLenient = true
        nf.numberStyle = .currency
        return nf
    }){
        self.inputStr = ""
        self.percent = 15
        self.subtotal = 0
        self.tip = 0
        self.total = 0
        self.formatter = formatter()
    }
    
    // setSubtotal function - updates the subtotal value using the input string (0.00 -> "0.00")
    func setSubtotal() {
        let subtotal: Double? = atof(self.inputStr)
        self.subtotal = subtotal!
    }
    
    // getSubtotal function - returns the subtotal value as a formatted string (0.00 -> "$0.00")
    func getSubtotal() -> String {
        let num: NSNumber? = NSNumber(value: self.subtotal)
        return self.formatter.string(from: num!)!
    }
    
    // getPercent function - returns the percent value as a formatted string (0.00 -> "0%")
    func getPercent() -> String {
        return String(format: "%.0f", self.percent) + "%"
    }
    
    // getTip function - calculates and returns the tip value as a formatted string (0.00 -> "$0.00")
    func getTip() -> String {
        self.tip = self.subtotal * (self.percent / 100)
        let num: NSNumber? = NSNumber(value: self.tip)
        return self.formatter.string(from: num!)!
    }
    
    // getTotal function - calculates and returns the total value as a formatted string (0.00 -> "0.00")
    func getTotal() -> String {
        self.total = self.subtotal + self.tip
        let num: NSNumber? = NSNumber(value: self.total)
        return self.formatter.string(from: num!)!
    }
}
