//
//  helpers.swift
//  tipmate
//
//  Created by Meghan Castro on 11/20/20.
//
//  

import Foundation
import SwiftUI


/// Style struct is used to define text styles
struct Style {
    var font:   Font
    var weight: Font.Weight
    var color:  Color
    
    /// setColor function sets the color variable
    /// - Parameter visible: boolean value representing text visibility
    mutating func setColor(visible: Bool) {
        color = visible ? .green : .white
    }
}

/// define styles to be used throughout the application
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


/// formats the application header
/// - Returns: view containing the header text views
func header() -> some View {
    Group {
        VStack (alignment: .center) {
            text(str: "tipmate",        style: titleStyle)
            text(str: "tip calculator", style: subtitleStyle)
        }
        .padding(10)
    }
}

/// formats a horizontal divider
/// - Returns: formatted horizontal divider
func divider() -> some View {
    Divider()
        .background(Color.green)
        .frame(alignment: .center)
}

/// formats a text view using the provided text and style
/// - Parameters:
///   - str: text to be displayed
///   - style: text style
/// - Returns: formatted text view
func text(str: String, style: Style) -> some View {
    Text(str)
        .font(style.font)
        .fontWeight(style.weight)
        .foregroundColor(style.color)
        .frame(alignment: .center)
}

/// formats the subtotal input text views
/// - Parameters:
///   - subtotal: string to be displayed
///   - visible: boolean value, determines text color
/// - Returns: formatted subtotal text views as a group
func input(subtotal: String, visible: Bool) -> some View {
    subtotalValueStyle.setColor(visible: visible)
    subtotalLabelStyle.setColor(visible: visible)
    
    return Group {
        HStack (alignment: .center) {
            text(str: "subtotal: ", style: subtotalLabelStyle)
            text(str: subtotal, style: subtotalValueStyle)
        }
    }
}

/// formats the tip and total text views
/// - Parameters:
///   - tip: string to be displayed
///   - total: string to be displayed
/// - Returns: formatted tip and total text views as a group
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

/// formats the tip percentage text views and slider
/// - Parameters:
///   - percent: tip percentage slider input
///   - str: string to be displayed
/// - Returns: tip percentage text views and slider view as a group
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


