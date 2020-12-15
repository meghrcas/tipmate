//
//  Check.swift
//  tipmate
//
//  Created by Meghan Castro on 12/7/20.
//

// import files
import Foundation
import SwiftUI

/// this class is used to calculate and monitor the Check variables (subtotal, tip percentage, tip, total)
public class Check: ObservableObject {
    
    // declare variables
    @Published var percent: Double
    @Published var inputStr : String
    
    var subtotal: Double
    var tip:      Double
    var total:    Double
    var formatter: NumberFormatter
  
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
    
    /**
     This function sets the subtotal value using the input string
     */

    func setSubtotal() {
        let subtotal: Double? = atof(self.inputStr)
        self.subtotal = subtotal!
    }
    
    /**
     This function converts the subtotal value (double) to a currency string (0.00 -> "$0.00")
     - returns: subtotal as a formatted string ("$0.00")
     */
    func getSubtotal() -> String {
        let num: NSNumber? = NSNumber(value: self.subtotal)
        return self.formatter.string(from: num!)!
    }
    
    /**
     This function converts the percent value (double) to a formatted string (0.00 -> "0%")
     - returns: percent as a formatted string ("0%")
     */
    func getPercent() -> String {
        return String(format: "%.0f", self.percent) + "%"
    }
    
    /**
     this function calculates and converts the tip value (double) to a currency string (0.00 -> "0.00")
     - returns: tip as a formatted string ("$0.00")
     */
    func getTip() -> String {
        self.tip = self.subtotal * (self.percent / 100)
        let num: NSNumber? = NSNumber(value: self.tip)
        return self.formatter.string(from: num!)!
    }
    
    /**
     This function calculates and converts the total value (double) to a currency string (0.00 -> "0.00")
     - returns: total as a formatted string ("$0.00")
     */
    func getTotal() -> String {
        self.total = self.subtotal + self.tip
        let num: NSNumber? = NSNumber(value: self.total)
        return self.formatter.string(from: num!)!
    }
}
