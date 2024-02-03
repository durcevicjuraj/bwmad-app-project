//
//  GlowBorder.swift
//  yu-gi-oh-cardex
//
//  Created by Juraj Đurčević on 31.01.2024..
//
import SwiftUI

struct GlowBorder: ViewModifier {
    var lineWidth: Int
    var color: Color
    func body(content: Content) -> some View {
        var newContent = AnyView(content)
        for _ in 0..<lineWidth {
            newContent = AnyView(newContent.shadow(color: color, radius: 1))
        }
        return newContent
    }
}

extension View {
    func glowBorder(color: Color, lineWidth: Int) -> some View {
        self.modifier(GlowBorder(lineWidth: lineWidth, color: color))
    }
}
