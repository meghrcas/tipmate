//
//  ContentView.swift
//  tipmate
//
//  Created by Meghan Castro on 10/9/20.
//  Edited by Meghan Castro on 10/13/20.
//

// TO DO: add a startup view (orange with white logo)
// TO DO: research app store/distribution

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

class Check: ObservableObject {
    @Published var subtotal : Double = 0
    @Published var percent  : Double = 15
    
    func getSubtotal(usrSubtotal: String) {
        subtotal = atof(usrSubtotal)
    }
    
    func getTip() -> Double {
        return subtotal * (percent / 100)
    }
    
    func getTotal() -> Double {
        return subtotal + getTip()
    }
    
}

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var check = Check()
    @State var usrSubtotal: String = ""
    @State var isVisible: Bool = false
    @State var btnVisible : Bool = false
    
    var visible: Bool {
        return (check.subtotal > 0 ? true : false)
    }

    
    private var darkModeEnabled: Bool {
        return (colorScheme == .dark) ? true : false
    }
    
    private var tip: String {
        let str = currencyFormatter.string(from: NSNumber(value: check.getTip())) ?? "--"
        return str
    }
    
    private var total: String {
        let str = currencyFormatter.string(from: NSNumber(value: check.getTotal())) ?? "--"
        return str
    }
    
    private var subtotal: String {
        let str = "$" + String(format: "%.2f", check.subtotal)
        return str
    }

    private var percent: String {
        let str = String(format: "%.0f", check.percent) + "%"
        return str
    }

   private var currencyFormatter: NumberFormatter = {
        let f = NumberFormatter()
        f.isLenient = true              // allow no currency symbol, extra digits, etc
        f.numberStyle = .currency
        return f
    }()
    
    var body: some View {
        VStack (alignment: .center) {
            header()
            results(tip: tip, total: total)
            Group {
                HStack {
                    TextField("enter the subtotal amount in USD", text: $usrSubtotal, onEditingChanged: { _ in
                        check.getSubtotal(usrSubtotal: usrSubtotal)
                        self.btnVisible     = true
                        subtotalValueStyle.setColor(visible: visible)
                        subtotalLabelStyle.setColor(visible: visible)
                    })
                    .font(defaultStyle.font)
                    .frame(alignment: .leading)
                    .accentColor(defaultStyle.color)
                    .keyboardType(.decimalPad)
                    
                    Button("enter") {
                        self.hideKeyboard()
                        self.usrSubtotal = ""
                        self.btnVisible  = false
                        
                        
                    }
                    .font(.headline)
                    .frame(alignment: .center)
                    .foregroundColor(Color.blue.opacity(btnVisible ? 100 : 0))
                    .disabled(!btnVisible)
                }
                .padding()
                
                HStack (alignment: .center) {
                    text(str: "subtotal: ", style: subtotalLabelStyle)
                    text(str: subtotal, style: subtotalValueStyle)
                }
                
                divider()
                
            }
            slider(percent: $check.percent, str: percent)
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








