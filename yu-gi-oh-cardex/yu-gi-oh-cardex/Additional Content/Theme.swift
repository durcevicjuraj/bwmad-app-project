//
//  Theme.swift
//  yu-gi-oh-cardex
//
//  Created by Juraj Đurčević on 29.01.2024..
//

import Foundation
import SwiftUI

class Theme: ObservableObject {
    @Published var isDark: Bool = true
    let darkColor = Color(red: 45/255, green: 45/255, blue: 45/255)
    let whiteColor = Color.white//Color(red: 249/255, green: 241/255, blue: 241/255)
    let LogButtonColor = LinearGradient(gradient: Gradient(colors: [Color.blue, Color.teal]), startPoint: .topLeading, endPoint: .bottomTrailing)
    let DarkRegButtonColor = LinearGradient(gradient: Gradient(colors: [Color.gray, Color(red: 45/255, green: 45/255, blue: 45/255)]), startPoint: .topLeading, endPoint: .bottomTrailing)
    let LightRegButtonColor = LinearGradient(gradient: Gradient(colors: [Color.gray, Color(red: 249/255, green: 241/255, blue: 241/255), Color.gray]), startPoint: .topLeading, endPoint: .bottomTrailing)
}
