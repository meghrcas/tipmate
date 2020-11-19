//
//  CustomTheme.swift
//  tipmate
//
//  Created by Meghan Castro on 10/13/20.
//

import Foundation
import SwiftUI

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
