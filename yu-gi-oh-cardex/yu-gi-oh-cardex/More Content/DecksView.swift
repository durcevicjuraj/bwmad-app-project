//
//  DeckView.swift
//  yu-gi-oh-cardex
//
//  Created by Juraj Đurčević on 01.02.2024..
//

import SwiftUI

struct DecksView: View {
    
    @EnvironmentObject var theme : Theme
    
    @Binding var selectedCategory : String
    
    @State var isPresented : Bool = false
    
    @State var selectedDeck : String = ""
    
    var body: some View {
        ZStack{
            theme.isDark ? Image("darkBackground").resizable().ignoresSafeArea() : Image("whiteBackground").resizable().ignoresSafeArea()
            
            Image("YugiKaiba")
                .resizable()
                .offset(x:0,y:150)
            
            VStack{
                
                Spacer()
                
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
                
                HStack{
                    Spacer()
                    Button(action:{
                        selectedDeck = "yugiMuto"
                        isPresented = !isPresented
                    }){
                        Image("yugiSD")
                            .resizable()
                            .frame(width: 80,height: 140)
                            .glowBorder(color: .white, lineWidth: 3)
                    }
                    
                    RoundedRectangle(cornerRadius: 25)
                        .fill(theme.isDark ? theme.darkColor.opacity(0.75) : theme.whiteColor.opacity(0.75))
                        .stroke(theme.isDark ? .white : .black)
                        .frame(width: 250,height: 250)
                        .padding()
                        .overlay(
                            VStack{
                                Text("Yugi Muto Structure Deck")
                                    .font(.title3)
                                    .underline()
                                    .foregroundStyle(theme.isDark ? .white : .black)
                                    .padding(.bottom,5)
                                
                                Text("In the anime, Yugi Muto is the protagonist known for his Heart of the Cards and his use of the powerful ''Dark Magician'' cards to protect his friends and uphold justice.")
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal,28)
                                    .foregroundStyle(theme.isDark ? .white : .black)
                            }
                        )
                    Spacer()
                }.padding(.leading,15)
                
                HStack{
                    Spacer()
                    
                    Button(action:{
                        selectedDeck = "setoKaiba"
                        isPresented = !isPresented
                    }){
                        Image("kaibaSDresized")
                            .resizable()
                            .frame(width: 80,height: 140)
                            .glowBorder(color: .white, lineWidth: 3)
                            .padding(.horizontal)
                    }
                    
                    RoundedRectangle(cornerRadius: 25)
                        .fill(theme.isDark ? theme.darkColor.opacity(0.75) : theme.whiteColor.opacity(0.75))
                        .stroke(theme.isDark ? .white : .black)
                        .frame(width: 250,height: 250)
                        .overlay(
                            VStack{
                                Text("Seto Kaiba Structure Deck")
                                    .font(.title3)
                                    .underline()
                                    .foregroundStyle(theme.isDark ? .white : .black)
                                    .padding(.bottom,5)
                                
                                Text("Seto Kaiba, a key character in Yu-Gi-Oh!, is known for his exceptional dueling skills and his reliance on the mighty ''Blue-Eyes White Dragon'' card in battles against rivals like Yugi Muto.")
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal,5)
                                    .foregroundStyle(theme.isDark ? .white : .black)
                            }
                        )
                    Spacer()
                }.padding(.trailing,15)
                
                Spacer()
                Spacer()
                Spacer()
            }
        }.sheet(isPresented: $isPresented){
            DeckView(selectedDeck: $selectedDeck)
        }
    }
}

#Preview {
    DecksView(selectedCategory: Binding.constant("Decks"))
        .environmentObject(Theme())
}
