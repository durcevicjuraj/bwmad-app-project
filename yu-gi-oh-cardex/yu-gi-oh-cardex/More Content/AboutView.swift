//
//  AboutView.swift
//  yu-gi-oh-cardex
//
//  Created by Juraj Đurčević on 01.02.2024..
//

import SwiftUI

struct AboutView: View {
    
    @EnvironmentObject var theme : Theme
    
    @Binding var selectedCategory : String
    
    var body: some View {
        ZStack{
            theme.isDark ? Image("darkBackground").resizable().ignoresSafeArea() : Image("whiteBackground").resizable().ignoresSafeArea()
            
            VStack{
                
                HStack{
                    Button(action: {
                        selectedCategory = ""
                    }){
                        RoundedRectangle(cornerRadius: 25)
                            .fill(theme.darkColor)
                            .stroke(theme.isDark ? .white : .black)
                            .frame(width:40,height: 40)
                            .overlay(
                                Image(systemName: "arrowshape.turn.up.backward")
                                    .foregroundColor(theme.isDark ? theme.whiteColor : theme.whiteColor)
                                    .fontWeight(.bold)
                            )
                    }.padding(.leading,300)
                }
                
                Spacer()
                
                RoundedRectangle(cornerRadius: 25)
                    .fill(theme.isDark ? theme.darkColor.opacity(0.5) : theme.whiteColor.opacity(0.5))
                    .stroke(theme.isDark ? .white : .black)
                    .frame(width: 350,height: 375)
                    .overlay(
                        VStack{
                            Text("YGO CardEX")
                                .font(.title)
                                .underline()
                                .fontWeight(.bold)
                                .foregroundStyle(theme.isDark ? .white : .black)
                                .padding(.bottom,10)
                            
                            Text("The Yu-Gi-Oh! CardEX is a simple yet powerful app designed for fans of the Yu-Gi-Oh! trading card game. Easily organize and explore your card collection with intuitive search and filtering features. Browse through detailed card information, including names, attributes, and abilities, all presented in a user-friendly interface. Whether you're a seasoned player or just starting out, this app makes managing your Yu-Gi-Oh! cards a breeze.")
                                .multilineTextAlignment(.center)
                                .foregroundStyle(theme.isDark ? .white : .black)
                        }.padding(.horizontal)
                    )
                Spacer()
            }
        }
    }
}

#Preview {
    AboutView(selectedCategory: Binding.constant("About"))
        .environmentObject(Theme())
}
