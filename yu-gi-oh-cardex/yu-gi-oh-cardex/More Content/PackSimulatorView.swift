//
//  PackOpenerView.swift
//  yu-gi-oh-cardex
//
//  Created by Juraj Đurčević on 01.02.2024..
//

import SwiftUI



struct PackSimulatorView: View {
    
    @EnvironmentObject var cardData : CardData
    @EnvironmentObject var theme : Theme
    
    @Binding var selectedCategory : String
    
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    let rainbowColors: [Color] = [.red, .orange, .yellow, .green, .blue, .purple]
    @State private var currentColorIndex = 0
    @State var isRainbow : Bool = true
    
    @State var cardsFound : [Card] = []
    
    @State var isPresented: Bool = false
    
    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 100))
    ]
    
    var body: some View {
        ZStack{
            
            theme.isDark ? Image("darkBackground").resizable().ignoresSafeArea() : Image("whiteBackground").resizable().ignoresSafeArea()
            
            VStack{
                
                RoundedRectangle(cornerRadius: 25)
                    .fill(theme.isDark ? theme.darkColor.opacity(0.5) : .gray.opacity(0.5))
                    .stroke(theme.isDark ? .white : .black)
                    .frame(width:375,height: 72)
                    .overlay(
                        VStack{
                            HStack{
                                Button(action: {
                                    isRainbow = !isRainbow
                                }){
                                    RoundedRectangle(cornerRadius: 25)
                                        .fill(theme.isDark ? theme.darkColor : theme.whiteColor)
                                        .stroke(theme.isDark ? .white : .black)
                                        .frame(width:40,height: 40)
                                        .overlay(
                                            Image(systemName: "cloud.rainbow.half")
                                                .foregroundColor(theme.isDark ? theme.whiteColor : theme.darkColor)
                                                .fontWeight(.bold)
                                        )
                                }.padding(.leading)
                                
                                Spacer()
                                
                                Button(action: {
                                    findRandomCards()
                                }){
                                    RoundedRectangle(cornerRadius: 25)
                                        .fill(theme.isDark ? .black : theme.whiteColor)
                                        .stroke(theme.isDark ? .white : .black)
                                        .frame(width:120,height: 40)
                                        .overlay(
                                            Text("OPEN PACK")
                                                .foregroundColor(isRainbow ? rainbowColors[currentColorIndex] : .red)
                                                .fontWeight(.bold)
                                                .onReceive(timer) { _ in
                                                    currentColorIndex = (currentColorIndex + 1) % rainbowColors.count
                                                }
                                        )
                                }.padding(.horizontal)
                                
                                Spacer()
                                
                                Button(action: {
                                    selectedCategory = ""
                                }){
                                    RoundedRectangle(cornerRadius: 25)
                                        .fill(theme.isDark ? theme.darkColor : theme.whiteColor)
                                        .stroke(theme.isDark ? .white : .black)
                                        .frame(width:40,height: 40)
                                        .overlay(
                                            Image(systemName: "arrowshape.turn.up.backward")
                                                .foregroundColor(theme.isDark ? theme.whiteColor : theme.darkColor)
                                                .fontWeight(.bold)
                                        )
                                }.padding(.trailing)
                                
                            }.padding(.top)
                            
                            Spacer()
                        }
                    )
                
                Spacer()
                
                ScrollView{
                    LazyVGrid(columns: adaptiveColumns, spacing: 20){
                        ForEach(cardsFound){ card in
                            ZStack{
                                Button(action: {
                                    isPresented = !isPresented
                                    cardData.presentedCard = card
                                }){
                                    SmallCardView(card: Binding.constant(card))
                                }
                                
                            }
                        }
                    }
                }.padding(.top,50)
            }
        }
        .sheet(isPresented: $isPresented) {
            CardView(card: $cardData.presentedCard)
        }
    }
    
    func findRandomCards() {
            var selectedIndices: Set<Int> = []
            var selectedCards: [Card] = []
            
            while selectedIndices.count < 9 {
                let randomIndex = Int.random(in: 0..<cardData.cards.count)
                if !selectedIndices.contains(randomIndex) {
                    selectedIndices.insert(randomIndex)
                    selectedCards.append(cardData.cards[randomIndex])
                }
            }
            
            cardsFound = selectedCards
        }
}


#Preview {
    PackSimulatorView(selectedCategory: Binding.constant("Pack Simulator"))
            .environmentObject(Theme())
            .environmentObject(CardData())
    }
