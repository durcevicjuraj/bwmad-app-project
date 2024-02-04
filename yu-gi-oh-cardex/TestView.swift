//
//  TestView.swift
//  yu-gi-oh-cardex
//
//  Created by Juraj Đurčević on 04.02.2024..
//

import SwiftUI

struct TestView: View {
    
    @EnvironmentObject var cardData : CardData
    @EnvironmentObject var theme : Theme
    @EnvironmentObject var userData : UserData
    
    var body: some View {
        Text("")
    }
}

#Preview {
    TestView()
        .environmentObject(Theme())
        .environmentObject(UserData())
        .environmentObject(CardData())
}
