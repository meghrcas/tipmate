//
//  ContentView.swift
//  tipmate
//
//  Created by Meghan Castro on 10/9/20.
//  Edited by Meghan Castro on 10/13/20.
//

// TO DO: add a startup view (orange with white logo)
// TO DO: add an app icon
// TO DO: research custom fonts
// TO DO: research app store/distribution
// TO DO: clean up and comment existing code

// TO DO: refactor names throughout app

// import packages
import SwiftUI

// import the hideKeyboard function from the UIKit packages
#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

// define ContentView structure
struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    @State var percentValue  : Double   = 15
    @State var billValue     : Double?  = nil
    @State var billInputStr  : String   = ""
    @State var btnVisible    : Bool     = false
    
    private var darkModeEnabled: Bool {
        return (colorScheme == .dark) ? true : false
    }
    
    private var tipResultValue: textview {
        let t = textview(text: currencyFormatter.string(from: NSNumber(value: tipValue)) ?? "--", font: .title, weight: .regular, color: .green)
        return t
    }

    private var totalResultValue: textview {
        let t = textview(text: currencyFormatter.string(from: NSNumber(value: totalValue)) ?? "--", font: .title, weight: .regular, color: .green)
        return t
    }

    private var billResultLabel: textview {
        let t = textview(text: "bill amount in USD:", font: .headline, weight: .bold, color: Color.green.opacity(billResultOpacity))
        return t
    }
    
    private var billResultValue: textview {
        let bill = billValue ?? 0.00
        let t = textview(text: "$" + String(format: "%.2f", bill), font: .headline, weight: .regular, color: Color.green.opacity(billResultOpacity))
        return t
    }

    private var percentResultValue: textview {
        let t = textview(text: String(format: "%.0f", percentValue) + "%", font: .headline, weight: .regular, color: .green)
        return t
    }

    private var tipValue: Double {
        let bill = billValue ?? 0
        return bill * (percentValue/100)
    }

    private var totalValue: Double {
        (billValue ?? 0) + tipValue
    }
        
    private var billResultOpacity: Double {
        let bill = billValue ?? 0.00
        return (bill != 0.00) ? 100 : 0
    }

    private var buttonOpacity: Double {
        return btnVisible ? 100 : 0
    }

   private var currencyFormatter: NumberFormatter = {
        let f = NumberFormatter()
        f.isLenient = true              // allow no currency symbol, extra digits, etc
        f.numberStyle = .currency
        return f
    }()
    
    var body: some View {
        VStack (alignment: .center) {
            formatHeader()
            formatResults(tipTextview: tipResultValue, totalTextview: totalResultValue)
            Group {
                HStack {
                    TextField(billInfoLabel.text, text: $billInputStr, onEditingChanged: { _ in
                        self.billValue = atof(self.billInputStr)
                        self.btnVisible     = true
                    })
                    .font(billInfoLabel.font)
                    .frame(alignment: .leading)
                    .accentColor(billInfoLabel.color)
                    .keyboardType(.decimalPad)
                    
                    Button("enter") {
                        self.hideKeyboard()
                        self.billInputStr = ""
                        self.btnVisible   = false
                    }
                    .font(.headline)
                    .frame(alignment: .center)
                    .foregroundColor(Color.blue.opacity(buttonOpacity))
                    //.onTapGesture {
                        //self.hideKeyboard()
                        //self.billInputStr = ""
                        //self.btnVisible = false
                    //}
                    .disabled(!btnVisible)
                }
                .padding()
                
                HStack (alignment: .center) {
                    formatTextView(textview: billResultLabel)
                    formatTextView(textview: billResultValue)
                }
            
                formatDivider(color: .green)
            }
            formatSliderInput(percentValue: $percentValue, percentTextview: percentResultValue)
        }
        .padding()
        .frame(width: 392, height: 820)
        .background(darkModeEnabled ? Color.blue.opacity(0.10) : .white)
        .overlay(RoundedRectangle (cornerRadius: 15.0)
            .stroke(lineWidth: 2.0)
                    .foregroundColor(.green))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}








