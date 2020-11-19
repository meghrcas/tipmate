//
//  CustomTheme.swift
//  tipmate
//
//  Created by Meghan Castro on 10/13/20.
//

import Foundation
import SwiftUI

// import the hideKeyboard function from the UIKit packages
//#if canImport(UIKit)
//extension View {
//    func hideKeyboard() {
//        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
//    }
//}
//#endif
struct textview {
    var text   : String
    var font   : Font
    var weight : Font.Weight
    var color  : Color
}

var title            = textview(text: "tipmate", font: .largeTitle, weight: .bold, color: .orange)
var subtitle         = textview(text: "tip calculator", font: .headline, weight: .bold, color: Color(UIColor.placeholderText))
var tipResultLabel   = textview(text: "tip: ", font: .title, weight: .bold, color: .green)
var totalResultLabel = textview(text: "total: ", font: .title, weight: .bold, color: .green)
var billInfoLabel    = textview(text: "enter bill amount in USD", font: .headline, weight: .bold, color: Color(UIColor.placeholderText))
var percentInfoLabel = textview(text: "select the desired tip percentage", font: .headline, weight: .bold, color: Color(UIColor.placeholderText))

// insert a formatted Text view
func formatTextView(textview: textview) -> some View {
    Text(textview.text)
        .font(textview.font)
        .fontWeight(textview.weight)
        .foregroundColor(textview.color)
        .frame(alignment: .center)
}

// insert a formmatted Divider view
func formatDivider(color: Color) -> some View {
    Divider()
        .background(color)
        .frame(alignment: .center)
}

// insert a formatted header
func formatHeader() -> some View {
    Group {
        VStack (alignment: .center) {
            formatTextView(textview: title)
            formatTextView(textview: subtitle)
        }
        .padding(10)
    }
}

// insert the formatted tip and total results
func formatResults(tipTextview: textview, totalTextview: textview) -> some View {
    Group {    // RESULTS
        formatDivider(color : .green)

        HStack (alignment: .center) {
            formatTextView(textview: tipResultLabel)
            formatTextView(textview: tipTextview)
        }
        .padding(.top, 200)
    
        HStack (alignment: .center) {
            formatTextView(textview: totalResultLabel)
            formatTextView(textview: totalTextview)
        }
        .padding(.bottom, 200)
        
        formatDivider(color: .green)
    }
}

// insert the formatted slider input
func formatSliderInput(percentValue: Binding<Double>, percentTextview: textview) -> some View {
    Group {
        formatTextView(textview: percentInfoLabel)
            .frame(width: 350, alignment: .leading)
            .padding()
        
        HStack (alignment: .center) {
            Image(systemName: "minus")
                .padding(.leading)
            Slider(value: percentValue, in: 0...100, step: 1)
                .accentColor(.green)
            Image(systemName: "plus")
                .padding(.trailing)
        }
        .foregroundColor(.green)
        
        formatTextView(textview: percentTextview)
            .padding(.bottom, 10)
    }
}

//func formatTextFieldInput(billInputValue: Binding<String>, billLabel: textview, billResult: textview) -> some View {
//    var billValue:  Double?
//    var btnVisible: Bool = false
//    var btnOpacity: Double = 0
//
//    Group {
//        HStack {
//            TextField(billInfoLabel.text, text: billInputValue, onEditingChanged: { _ in
//                let billValue = atof(billInputValue)
//                btnOpacity = 100
//            })
//            .font(billInfoLabel.font)
//            .frame(alignment: .leading)
//            .accentColor(billInfoLabel.color)
//            .keyboardType(.decimalPad)
//
//            Button("enter") {
//                View.hideKeyboard()
//                let billInputValue = ""
//                btnOpacity = 0
//            }
//            .font(.headline)
//            .frame(alignment: .center)
//            .foregroundColor(Color.blue.opacity(btnOpacity))
//            .onTapGesture {
//                hideKeyboard()
//            }
//            //.gesture(.hideKeyboard())
//            .disabled(!btnVisible)
//        }
//        .padding()
//
//        HStack (alignment: .center) {
//            formatTextView(textview: billLabel)
//            formatTextView(textview: billResult)
//        }
//    }
//}
