//
//  ContentView.swift
//  tipmate
//
//  Created by Meghan Castro on 10/9/20.
//  Edited by Meghan Castro on 10/13/20.
//

// TO DO: add a startup view (orange with white logo)
// TO DO: research app store/distribution

import SwiftUI

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
/// ContentView
struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    @State var inputStr: String = ""
    @State var btnVisible : Bool = false
    var btnColor: Color {
        return self.btnVisible ? .blue : .white
    }
    
    @ObservedObject var check = Check()
    
    var subtotalVisible: Bool {
        return (self.check.subtotal > 0 ? true : false)
    }

    var backgroundColor: Color {
        return (self.colorScheme == .dark) ? Color.blue.opacity(0.10) : .white
    }
    
    var body: some View {
            VStack (alignment: .center) {
            header()
            
            results(tip: check.getTip(), total: check.getTotal())
            
            Group {
                HStack {
                    TextField("enter the subtotal amount in USD", text: $check.inputStr, onEditingChanged: { _ in
                        inputStrEdited()
                    })
                    .font(defaultStyle.font)
                    .frame(alignment: .leading)
                    .accentColor(defaultStyle.color)
                    .keyboardType(.decimalPad)
                    
                    Button("enter") {
                        enterBtnTapped()
                    }
                    .font(.headline)
                    .frame(alignment: .center)
                    .foregroundColor(self.btnColor)
                    .disabled(!btnVisible)
                }
                .padding()

                input(subtotal: check.getSubtotal(), visible: self.subtotalVisible)
                
                divider()
            }
            
            slider(percent: $check.percent, str: check.getPercent())
        }
        //.environment(\.colorScheme, .dark)
        .padding()
        .frame(width: 392, height: 820)
        .background(backgroundColor)
        .overlay(RoundedRectangle(cornerRadius: 15.0)
                        .stroke(lineWidth: 2.0)
                        .foregroundColor(.green))

    }
    
    func inputStrEdited() {
        btnVisible = true
        self.check.setSubtotal()
    }
    
    func enterBtnTapped() {
        self.hideKeyboard()
        btnVisible  = false
        self.check.inputStr = ""
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

