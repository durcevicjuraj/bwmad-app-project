//
//  DeckView.swift
//  yu-gi-oh-cardex
//
//  Created by Juraj Đurčević on 03.02.2024..
//

import SwiftUI


private let adaptiveColumns = [
    GridItem(.adaptive(minimum: 100))
]

struct DeckView: View {
    
    @EnvironmentObject var cardData : CardData
    @EnvironmentObject var theme : Theme
    
    @Binding var selectedDeck : String
    
    var mainDeck : [Card] {
        
        var tempCards : [Card] = []
        
        if(selectedDeck == "yugiMuto"){
            tempCards = cardData.cards.filter { card in
                cardData.yugiMutoDeck.contains(card.id) && (card.category != "XYZ" && card.category != "Synchro" && card.category != "Fusion" && card.category != "Link")
            }
        }
        else{
            tempCards = cardData.cards.filter { card in
                cardData.setoKaibaDeck.contains(card.id) && (card.category != "XYZ" && card.category != "Synchro" && card.category != "Fusion" && card.category != "Link")
                    }
        }
        
        return tempCards.sorted { $0.category < $1.category }
    }
    
    var extraDeck : [Card] {
        
        var tempCards : [Card] = []
        
        if(selectedDeck == "yugiMuto"){
            tempCards = cardData.cards.filter { card in
                cardData.yugiMutoDeck.contains(card.id) && (card.category == "XYZ" || card.category == "Synchro" || card.category == "Fusion" || card.category == "Link")
            }
        }
        else{
            tempCards = cardData.cards.filter { card in
                cardData.setoKaibaDeck.contains(card.id) && (card.category == "XYZ" || card.category == "Synchro" || card.category == "Fusion" || card.category == "Link")
                    }
        }
        
        return tempCards
    }
    
    @State var isPresented : Bool = false
    
    
    var body: some View {
        ZStack{
            
            theme.isDark ? Image("darkBackground").resizable().ignoresSafeArea() : Image("whiteBackground").resizable().ignoresSafeArea()
            
            ScrollView{
                
                RoundedRectangle(cornerRadius: 25)
                    .fill(theme.isDark ? theme.darkColor.opacity(0.5) : theme.whiteColor.opacity(0.5))
                    .stroke(theme.isDark ? .white : .black, lineWidth: 1)
                    .frame(width: 115,height: 30)
                    .overlay(
                        Text("Main Deck")
                            .foregroundStyle(theme.isDark ? .white : .black)
                    ).padding(.vertical)
                
                LazyVGrid(columns: adaptiveColumns, spacing: 20){
                    ForEach(mainDeck){ card in
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
                
                RoundedRectangle(cornerRadius: 25)
                    .fill(theme.isDark ? theme.darkColor.opacity(0.5) : theme.whiteColor.opacity(0.5))
                    .stroke(theme.isDark ? .white : .black, lineWidth: 1)
                    .frame(width: 115,height: 30)
                    .overlay(
                        Text("Extra Deck")
                            .foregroundStyle(theme.isDark ? .white : .black)
                    ).padding(.vertical)
                
                LazyVGrid(columns: adaptiveColumns, spacing: 20){
                    ForEach(extraDeck){ card in
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
            }
        }.sheet(isPresented: $isPresented) {
            CardView(card: $cardData.presentedCard)
        }
    }
}

#Preview {
    DeckView(selectedDeck: Binding.constant("yugiMuto"))
        .environmentObject(Theme())
        .environmentObject(CardData())
}
