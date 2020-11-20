//
//  CustomTheme.swift
//  tipmate
//
//  Created by Meghan Castro on 10/13/20.
//

import Foundation
import SwiftUI

//struct style {
//    //var text   : String
//    var font   : Font
//    var weight : Font.Weight
//    var color  : Color
//}

//var title              = textView(text: "tipmate", font: .largeTitle, weight: .bold, color: .orange)
//var subtitle           = textView(text: "tip calculator", font: .headline, weight: .bold, color: Color(UIColor.placeholderText))
//var tipLabel           = textView(text: "tip: ", font: .title, weight: .bold, color: .green)
//var totalLabel         = textView(text: "total: ", font: .title, weight: .bold, color: .green)
//var subtotalFieldLabel = textView(text: "enter the subtotal amount in USD", font: .headline, weight: .bold, color: Color(UIColor.placeholderText))
//var percentLabel       = textView(text: "select the desired tip percentage", font: .headline, weight: .bold, color: Color(UIColor.placeholderText))
//var title              = style(font: .largeTitle, weight: .bold, color: .orange)
//var subtitle           = style(font: .headline,   weight: .bold, color: Color(UIColor.placeholderText))
//var tipLabel           = style(font: .title,      weight: .bold, color: .green)
//var totalLabel         = style(font: .title,      weight: .bold, color: .green)
//var subtotalFieldLabel = style(font: .headline,   weight: .bold, color: Color(UIColor.placeholderText))
//var percentLabel       = style(font: .headline,   weight: .bold, color: Color(UIColor.placeholderText))

// insert a formatted Text view
//func text(str: String, style: style) {
//    Text(str)
//        .font(style.font)
//        .fontWeight(style.weight)
//        .foregroundColor(style.color)
//        .frame(alignment: .center)
//}

//func text(view: style) -> some View {
//    Text(view.text)
//        .font(view.font)
//        .fontWeight(view.weight)
//        .foregroundColor(view.color)
//        .frame(alignment: .center)
//}

// insert a formmatted Divider view
//func formatDivider(color: Color) -> some View {
//    Divider()
//        .background(color)
//        .frame(alignment: .center)
//}


//// insert a formatted header
//func formatHeader() -> some View {
//    Group {
//        VStack (alignment: .center) {
//            text(view: title)
//            text(view: subtitle)
//        }
//        .padding(10)
//    }
//}

// insert the formatted tip and total results
//func formatResults(tipTextview: style, totalTextview: style) -> some View {
//    Group {    // RESULTS
//        formatDivider(color : .green)
//
//        HStack (alignment: .center) {
//            text(view: tipStyle)
//            text(view: tipTextview)
//        }
//        .padding(.top, 200)
//    
//        HStack (alignment: .center) {
//            text(view: totalLabel)
//            text(view: totalTextview)
//        }
//        .padding(.bottom, 200)
//        
//        formatDivider(color: .green)
//    }
//}

// insert the formatted textfield input
//func formatSubtotalViews(label: textView, input: textView) {
//    HStack (alignment: .center) {
//        formatTextView(view: label)
//        formatTextView(view: input)
//    }
//}


// insert the formatted slider input
//func formatSliderView(input: Binding<Double>, output: String) -> some View {
//    Group {
//        text(view: inputStyle)
//            .frame(width: 350, alignment: .leading)
//            .padding()
//        
//        HStack (alignment: .center) {
//            Image(systemName: "minus")
//                .padding(.leading)
//            Slider(value: input, in: 0...100, step: 1)
//                .accentColor(.green)
//            Image(systemName: "plus")
//                .padding(.trailing)
//        }
//        .foregroundColor(.green)
//        
//        text(str: output, style: percentStyle)
//            .padding(.bottom, 10)
//    }
//}
