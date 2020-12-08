//
//  helpers.swift
//  tipmate
//
//  Created by Meghan Castro on 11/20/20.
//
//  

// import files
import Foundation
import SwiftUI

// declare Style struct - used to format text components
struct Style {
    var font:   Font
    var weight: Font.Weight
    var color:  Color
    
    // setColor function - updates the color using visible
    mutating func setColor(visible: Bool) {
        color = visible ? .green : .white
    }
}

// define Style variables for all text components
var titleStyle          = Style(font: .largeTitle, weight: .bold,    color: .orange)
var subtitleStyle       = Style(font: .headline,   weight: .bold,    color: Color(UIColor.placeholderText))
var tipValueStyle       = Style(font: .title,      weight: .regular, color: .green)
var tipLabelStyle       = Style(font: .title,      weight: .bold,    color: .green)
var totalValueStyle     = Style(font: .title,      weight: .regular, color: .green)
var totalLabelStyle     = Style(font: .title,      weight: .bold,    color: .green)
var subtotalValueStyle  = Style(font: .headline,   weight: .regular, color: .white)
var subtotalLabelStyle  = Style(font: .headline,   weight: .bold,    color: .white)
var percentValueStyle   = Style(font: .headline,   weight: .regular, color: .green)
var defaultStyle        = Style(font: .headline,   weight: .bold,    color: Color(UIColor.placeholderText))


// header function - formats and returns the application header
func header() -> some View {
    Group {
        VStack (alignment: .center) {
            text(str: "tipmate",        style: titleStyle)
            text(str: "tip calculator", style: subtitleStyle)
        }
        .padding(10)
    }
}

// divider function - formats and returns a horizontal divider
func divider() -> some View {
    Divider()
        .background(Color.green)
        .frame(alignment: .center)
}

// text function - formats and returns a text view using the provided string and style
func text(str: String, style: Style) -> some View {
    Text(str)
        .font(style.font)
        .fontWeight(style.weight)
        .foregroundColor(style.color)
        .frame(alignment: .center)
}

// input function - formats and returns the subtotal text views as a group
func input(subtotal: String, visible: Bool) -> some View {
    // update the subtotal styles
    subtotalValueStyle.setColor(visible: visible)
    subtotalLabelStyle.setColor(visible: visible)
    
    return Group {
        HStack (alignment: .center) {
            text(str: "subtotal: ", style: subtotalLabelStyle)
            text(str: subtotal, style: subtotalValueStyle)
        }
    }
}

// results function - formats and returns the tip and total text views as a group
func results(tip: String, total: String) -> some View {
    Group {    
        divider()

        HStack (alignment: .center) {
            text(str: "tip: ", style: tipLabelStyle)
            text(str: tip, style: tipValueStyle)
        }
        .padding(.top, 200)
    
        HStack (alignment: .center) {

            text(str: "total: ", style: totalLabelStyle)
            text(str: total, style: totalValueStyle)
        }
        .padding(.bottom, 200)
        
        divider()
    }
}

// slider function - formats and returns the tip percentage text and slider as a group
func slider(percent: Binding<Double>, str: String) -> some View {
    Group {
        text(str: "select the desired tip percentage", style: defaultStyle)
            .frame(width: 350, alignment: .leading)
            .padding()
        
        HStack (alignment: .center) {
            Image(systemName: "minus")
                .padding(.leading)
            Slider(value: percent, in: 0...100, step: 1)
                .accentColor(.green)
            Image(systemName: "plus")
                .padding(.trailing)
        }
        .foregroundColor(.green)
        
        text(str: str, style: percentValueStyle)
            .padding(.bottom, 10)
    }
}
