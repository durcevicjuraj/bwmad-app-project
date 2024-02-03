//
//  SearchView.swift
//  yu-gi-oh-cardex
//
//  Created by Juraj Đurčević on 23.01.2024..
//

import SwiftUI

struct SearchView: View {
    
    @EnvironmentObject var cardData : CardData
    @EnvironmentObject var theme : Theme
    
    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 100))
    ]
        
    let monsterCategories = ["All","Normal","Effect","Ritual","Pendulum"]
    let extraCategories = ["All", "Fusion", "Synchro", "XYZ", "Link"]
    let trapCategories = ["All", "Normal", "Continuous", "Counter"]
    let spellCategories = ["All", "Normal", "Quick-Play", "Field", "Equip", "Ritual"]
    @State var isFiltered : Bool = false
    @State var categoryFilter = ""
    @State var monsterFilter = ""
    @State var trapFilter = ""
    @State var spellFilter = ""
    @State var query = ""
    
    @State var isPresented: Bool = false
    
    @State var isShuffled: Bool = false
    
    var cardsFound : [Card] {
        
        var tempCards : [Card]
        
            if(categoryFilter == ""){
                tempCards = cardData.cards
            }
            else if(categoryFilter == "Fusion" || categoryFilter == "Synchro" || categoryFilter == "XYZ" || categoryFilter == "Link" || categoryFilter == "Extra" ){
                
                if(categoryFilter == "Extra"){
                    tempCards = cardData.cards.filter {card in return card.category.contains("XYZ") || card.category.contains("Fusion") || card.category.contains("Synchro") || card.category.contains("Link")
                    }
                }
                else{
                    tempCards = cardData.cards.filter {card in
                        return card.category.contains(categoryFilter)
                    }
                }
                
            }
            else if(categoryFilter == "Monster"){
                
                if(monsterFilter.isEmpty){
                    tempCards = cardData.cards.filter {card in
                        return card.category.contains(categoryFilter)
                    }
                }
                else{
                    tempCards = cardData.cards.filter {card in
                        return card.category.contains(categoryFilter) && card.category.contains(monsterFilter)
                    }
                }
                
            }
            else if(categoryFilter == "Trap"){
                
                if(trapFilter.isEmpty){
                    tempCards = cardData.cards.filter {card in
                        return card.category.contains(categoryFilter)
                    }
                }
                else{
                    tempCards = cardData.cards.filter {card in
                        return card.category.contains(categoryFilter) && card.type.contains(trapFilter)
                    }
                }
                
            }
            else{ // categoryFilter == "Spell"
                
                if(spellFilter.isEmpty){
                    tempCards = cardData.cards.filter {card in
                        return card.category.contains(categoryFilter)
                    }
                }
                else{
                    tempCards = cardData.cards.filter {card in
                        return card.category.contains(categoryFilter) && card.type.contains(spellFilter)
                    }
                }
                
            }
        
        if(isShuffled){
            tempCards = ShuffleCards(cards: tempCards)
        }
        else{
            tempCards = OrderAlphabetCards(cards: tempCards)
        }
        
        
        if(query.isEmpty){
            return tempCards
        }
        else{
            return  tempCards.filter { card in
                return card.name.lowercased().replacingOccurrences(of: "-", with: " ").contains(query.lowercased().replacingOccurrences(of: "-", with: " ")) || card.description.lowercased().replacingOccurrences(of: "-", with: " ").contains(query.lowercased().replacingOccurrences(of: "-", with: " ")) || card.archetype.lowercased().replacingOccurrences(of: "-", with: " ").contains(query.lowercased().replacingOccurrences(of: "-", with: " "))
            }
        }
    }
    
    @State var scale = 0.5
    
    var body: some View {
        
        ZStack{
            
            theme.isDark ? Image("darkBackground").resizable().ignoresSafeArea() : Image("whiteBackground").resizable().ignoresSafeArea()
            
            VStack{
                RoundedRectangle(cornerRadius: 25)
                    .fill(theme.isDark ? theme.darkColor.opacity(0.5) : theme.whiteColor.opacity(0.5))
                    .stroke(theme.isDark ? .white : .black, lineWidth: 1)
                    .frame(width: 375,height: 90)
                    .overlay(
                        VStack{
                            HStack{
                                Button(action: {theme.isDark = !theme.isDark}){
                                    if(!theme.isDark){
                                        Image(systemName: "moon.circle")
                                            .resizable()
                                            .frame(width:25,height: 25)
                                            .foregroundStyle(.gray)
                                    }
                                    else{
                                        Image(systemName: "sun.max.circle")
                                            .resizable()
                                            .frame(width:25,height: 25)
                                            .foregroundStyle(.white)
                                    }
                                }
                                
                                RoundedRectangle(cornerRadius: 25)
                                    .fill(.gray)
                                    .stroke(theme.isDark ? .white : .black)
                                    .frame(width: 250,height: 25)
                                    .overlay(
                                        TextField("Search...", text: $query)
                                            .foregroundStyle(theme.isDark ? .black : .white)
                                            .autocapitalization(.none)
                                            .autocorrectionDisabled()
                                            .multilineTextAlignment(.center)
                                            .padding()
                                    )
                                    .padding()
                                if(!query.isEmpty){
                                    Button(action: {query = ""}){
                                        Image(systemName: "x.circle")
                                            .resizable()
                                            .frame(width:25,height: 25)
                                            .foregroundStyle(theme.isDark ? .white : .gray)
                                    }
                                }
                                else{
                                    Button(action: {
                                        isShuffled = !isShuffled
                                    }){
                                        if(!isShuffled){
                                            Image(systemName: "shuffle.circle")
                                                .resizable()
                                                .frame(width:25,height: 25)
                                                .foregroundStyle(theme.isDark ? .white : .gray)
                                        }
                                        else{
                                            Image(systemName: "shuffle.circle.fill")
                                                .resizable()
                                                .frame(width:25,height: 25)
                                                .foregroundStyle(theme.isDark ? .white : .gray)
                                        }
                                    }
                                }
                            }
                            
                            HStack{
                                
                                Spacer()
                                Button(action:{
                                    
                                    isPresented = !isPresented
                                    cardData.presentedCard = cardsFound.randomElement()!
                                }){
                                    RoundedRectangle(cornerRadius: 25)
                                        .fill(theme.isDark ? .black : .white )
                                        .stroke(theme.isDark ? .white : .black)
                                        .frame(width: 75,height: 30)
                                        .overlay{
                                            Text("RNG")
                                                .foregroundStyle(theme.isDark ? .white : .black)
                                            
                                        }
                                }.disabled(cardsFound.isEmpty)
                                    .padding(.trailing)
                            
                            Spacer()
                                
                                Menu {
                                    Button("All",action: {
                                        isFiltered = false
                                        categoryFilter = ""
                                        monsterFilter = ""
                                        trapFilter = ""
                                        spellFilter = ""
                                    })
                                    Menu("Monster"){
                                        ForEach(monsterCategories, id: \.self){str in
                                            Button(str, action: {
                                                isFiltered = true
                                                categoryFilter = "Monster"
                                                if(str == "All"){
                                                    monsterFilter = ""
                                                }
                                                else{
                                                    monsterFilter = str
                                                }
                                            })
                                        }
                                    }
                                    Menu("Extra"){
                                        ForEach(extraCategories, id: \.self){str in
                                            Button(str, action: {
                                                isFiltered = true
                                                if(str == "All"){
                                                    categoryFilter = "Extra"
                                                }
                                                else{
                                                    categoryFilter = str
                                                }
                                            })
                                        }
                                    }
                                    Menu("Trap"){
                                        ForEach(trapCategories, id: \.self){str in
                                            Button(str, action: {
                                                isFiltered = true
                                                categoryFilter = "Trap"
                                                if(str == "All"){
                                                    trapFilter = ""
                                                }
                                                else{
                                                    trapFilter = str
                                                }
                                            })
                                        }
                                    }
                                    Menu("Spell"){
                                        ForEach(spellCategories, id: \.self){str in
                                            Button(str, action: {
                                                isFiltered = true
                                                categoryFilter = "Spell"
                                                if(str == "All"){
                                                    spellFilter = ""
                                                }
                                                else{
                                                    spellFilter = str
                                                }
                                            })
                                        }
                                    }
                                } label: {
                                    RoundedRectangle(cornerRadius: 25)
                                        .fill(theme.isDark ? .black : .white )
                                        .stroke(theme.isDark ? .white : .black)
                                        .frame(width:125,height: 30)
                                        .overlay(
                                            HStack{
                                                Spacer()
                                                
                                                if(!categoryFilter.isEmpty){
                                                    Text(categoryFilter)
                                                        .foregroundStyle(theme.isDark ? .white : .black)
                                                }
                                                else{
                                                    Text("Category")
                                                        .foregroundStyle(theme.isDark ? .white : .black)
                                                }
                                                
                                                Spacer()
                                            }
                                        )
                                }
                                
                                    Spacer()
                                    Spacer()
                                    Button(action:{
                                        isFiltered = false
                                        categoryFilter = ""
                                    }){
                                        RoundedRectangle(cornerRadius: 25)
                                            .fill(theme.isDark ? .black : .white )
                                            .stroke(theme.isDark ? .white : .black)
                                            .frame(width: 75,height: 30)
                                            .overlay{
                                                Text("Reset")
                                                    .foregroundStyle(.red)
                                            }
                                    }
                                    .padding(.trailing)
                            }
                            .padding(.top,-12)
                            .padding(.bottom,18)
                        }
                    )
                
                ScrollView{
                    LazyVGrid(columns: adaptiveColumns, spacing: 20){
                        ForEach(cardsFound){ card in
                            ZStack{
                                Button(action: {
                                    isPresented = !isPresented
                                    cardData.presentedCard = card
                                }){
                                    SmallCardView(card: Binding.constant(card))
                                        .scaleEffect(scale)
                                        .onAppear {
                                            _ = Animation.easeInOut(duration: 1)
                                            withAnimation() {
                                                scale = 1.0
                                            }
                                        }
                                }
                            }
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $isPresented) {
            CardView(card: $cardData.presentedCard)
        }
    }
    
    func ShuffleCards(cards: [Card]) -> [Card]{
        return cards.shuffled()
    }
    
    func OrderAlphabetCards(cards: [Card]) -> [Card]{
        return cards.sorted { $0.name < $1.name }
    }
    
}



#Preview {
    SearchView()
        .environmentObject(CardData())
        .environmentObject(Theme())
}
