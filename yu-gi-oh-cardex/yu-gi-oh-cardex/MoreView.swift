//
//  DeckView.swift
//  yu-gi-oh-cardex
//
//  Created by Juraj Đurčević on 23.01.2024..
//

import SwiftUI

struct MoreView: View {
    
    @EnvironmentObject var cardData : CardData
    @EnvironmentObject var theme : Theme
    
    let categories : [String] = ["Pack Simulator", "Decks", "About", "Settings"]
    
    @State var selectedCategory : String = ""
    
    var body: some View {
        if(selectedCategory.isEmpty){
            ZStack{
                
                theme.isDark ? Image("darkBackground").resizable().ignoresSafeArea() : Image("whiteBackground").resizable().ignoresSafeArea()
                
                VStack{
                    ForEach(categories, id: \.self){ category in
                        ZStack{
                            Button(action: {
                                selectedCategory = category
                            }){
                                RoundedRectangle(cornerRadius: 25)
                                    .fill(theme.isDark ? theme.darkColor.opacity(0.5) : theme.whiteColor.opacity(0.5))
                                    .stroke(theme.isDark ? .white : .black)
                                    .frame(width: 175,height: 50)
                                    .overlay(
                                        Text(category)
                                            .fontWeight(.bold)
                                            .foregroundStyle(theme.isDark ? .white : .black)
                                    )
                            }.padding(.horizontal)
                        }
                    }
                }
            }
        }
        else if(selectedCategory == "Pack Simulator"){
            PackSimulatorView(selectedCategory: $selectedCategory)
        }
        else if(selectedCategory == "Decks"){
            DecksView(selectedCategory: $selectedCategory)
        }
        else if(selectedCategory == "About"){
            AboutView(selectedCategory: $selectedCategory)
        }
        else if(selectedCategory == "Settings"){
            SettingsView(selectedCategory: $selectedCategory)
        }
    }
}



#Preview {
    MoreView()
        .environmentObject(Theme())
        .environmentObject(CardData())
}
