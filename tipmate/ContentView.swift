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

struct ContentView: View {
    
    // declare variables
    @Environment(\.colorScheme) var colorScheme     // monitors device appearance mode
    @State var inputStr: String = ""                // empty string to store TextField input
    @State var btnVisible : Bool = false            // monitors button visibility
    @ObservedObject var check = Check()             // new instance of Check class
    var subtotalVisible: Bool {                     // handles subtotal text visibility (true for nonzero subtotal amounts)
        return (self.check.subtotal > 0 ? true : false)
    }

    var darkModeEnabled: Bool {                     // handles application appearance mode
        return (self.colorScheme == .dark) ? true : false
    }
    
    var body: some View {
            VStack (alignment: .center) {
            // insert the formatted title and subtitle text views
            header()
            
            // insert the formatted tip and total views
            results(tip: check.getTip(), total: check.getTotal())
            
            // format and insert the subtotal views (textfield, button, text) as a group
            Group {
                HStack {
                    TextField("enter the subtotal amount in USD", text: $check.inputStr, onEditingChanged: { _ in
                        // display the enter button on editing changes
                        self.btnVisible = true
                        // call the setSubtotal function to store the user input on editing changes
                        self.check.setSubtotal()
                    })
                    .font(defaultStyle.font)
                    .frame(alignment: .leading)
                    .accentColor(defaultStyle.color)
                    .keyboardType(.decimalPad)
                    
                    Button("enter") {
                        // hide the keyboard and button, and clear the input string on each button press
                        self.hideKeyboard()
                        self.btnVisible  = false
                        self.check.inputStr = ""
                    }
                    .font(.headline)
                    .frame(alignment: .center)
                    // modify button functionality and visibility using btnVisible
                    .foregroundColor(btnVisible ? .blue : .white)
                    .disabled(!btnVisible)
                }
                .padding()

                // insert the formatted subtotal text views
                input(subtotal: check.getSubtotal(), visible: self.subtotalVisible)
                
                // insert a formatted divider
                divider()
            }
            
            // insert the formatted tip percentage views (text and slider)
            slider(percent: $check.percent, str: check.getPercent())
        }
        //.environment(\.colorScheme, .dark)
        .padding()
        .frame(width: 392, height: 820)
        // modify the background color using darkModeEnabled
        .background(darkModeEnabled ? Color.blue.opacity(0.10) : .white)
        .overlay(RoundedRectangle(cornerRadius: 15.0)
                        .stroke(lineWidth: 2.0)
                        .foregroundColor(.green))

    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//    
//    var lightModePreview: some View {
//        return ContentView().environment(\.colorScheme, .light)
//    }
//    
//    var darkModePreview: some View {
//        return ContentView().environment(\.colorScheme, .dark)
//    }
//}

