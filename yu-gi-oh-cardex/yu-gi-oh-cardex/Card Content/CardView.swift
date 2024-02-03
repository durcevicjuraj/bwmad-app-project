//
//  CardView.swift
//  yu-gi-oh-cardex
//
//  Created by Juraj Đurčević on 28.01.2024..
//

import SwiftUI

struct CardView: View {
    
    @Binding var card: Card
    
    @EnvironmentObject var theme : Theme
    @EnvironmentObject var userData : UserData
    @EnvironmentObject var cardData : CardData
    
    @State var isPresented: Bool = false
    
    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 100))
    ]
    
    var relatedCards : [Card] {
        
        return cardData.cards.filter {card in
            return ( card.archetype == self.card.archetype || card.description.contains(self.card.name) ) && card.id != self.card.id && card.archetype != "None"
        }
        
    }
        
    
    @State var image: UIImage? = nil
    
    @State var refreshToggle : Bool = false
    
    @State var isLegend : Bool = false
    
    func countLines() -> Int {
        let string = card.description
        let width: CGFloat = 300 // Width of the screen view
        let font = UIFont.systemFont(ofSize: 14) // Font used for the string
        
        let nsString = NSString(string: string)
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingRect = nsString.boundingRect(with: constraintRect,
                                                  options: .usesLineFragmentOrigin,
                                                  attributes: [NSAttributedString.Key.font: font],
                                                  context: nil)
        let numberOfLines = Int(ceil(boundingRect.height / font.lineHeight))
        return numberOfLines
    }
    
    func calculateHeight() -> CGFloat{
        let lines = countLines()
        if lines <= 1{
            return 120
        }
        else if lines <= 2{
            return 150
        }
        else if lines <= 4{
            return 180
        }
        else if lines <= 5{
            return 210
        }
        else{
            return 240
        }
            
    }
    
    func calculateWidth() -> CGFloat{
        let count = card.archetype.count
        if count <= 7{
            return 120
        }
        else if count <= 10{
            return 150
        }
        else if count <= 13{
            return 180
        }
        else{
            return 210
        }
            
    }
    
    func calculateWidthCategory() -> CGFloat{
        let count = card.category.count
        if count <= 7{
            return 120
        }
        else if count <= 10{
            return 150
        }
        else if count <= 13{
            return 180
        }
        else{
            return 210
        }
            
    }
    
    var body: some View {
        ZStack{
            
            theme.isDark ? Image("darkCardBG").resizable().ignoresSafeArea() : Image("lightCardBG").resizable().ignoresSafeArea()
            
            ScrollView{
                VStack{
                    Spacer()
                    HStack{
                        Spacer()
                        VStack{
                            Spacer()
                            Button(action: {isLegend = !isLegend}){
                                Image(systemName: "exclamationmark.circle")
                                    .resizable()
                                    .frame(width:18,height: 18)
                                    .foregroundStyle(theme.isDark ? .white : .gray)
                                    .padding(.leading,5)
                            }.popover(isPresented: $isLegend){
                                CardLegendView()
                            }
                        }
                        Spacer()
                        if let newimage = image {
                            Image(uiImage: newimage)
                                .resizable()
                                .frame(width: 200, height: 324)
                        }
                        else {
                            Image("cardBackground")
                                .resizable()
                                .frame(width:200, height: 324)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        VStack{
                            
                            Spacer()
                            Button(action: {
                                card.isFavorite.toggle()
                                if !userData.loggedInUser.likedCards.contains(card.id){
                                    userData.loggedInUser.likedCards.append(card.id)
                                }
                                else {
                                    if let ind = userData.loggedInUser.likedCards.firstIndex(of: card.id){
                                        userData.loggedInUser.likedCards.remove(at: ind)
                                    }
                                }
                                refreshToggle.toggle()
                            }) {
                                if(userData.isLoggedIn){
                                    if (userData.loggedInUser.likedCards.contains(card.id))
                                    {Image(systemName: "heart.fill")
                                            .resizable()
                                            .frame(width:18,height: 18)
                                            .foregroundStyle(.pink)
                                    } else {Image(systemName: "heart")
                                            .resizable()
                                            .frame(width:18,height: 18)
                                            .foregroundStyle(.pink)
                                    }
                                }
                                else{
                                    Image(systemName: "heart")
                                        .resizable()
                                        .frame(width:18,height: 18)
                                        .foregroundStyle(theme.isDark ? .white : .gray)
                                }
                            }.disabled(!userData.isLoggedIn)
                        }
                        Spacer()
                    }
                    
                    RoundedRectangle(cornerRadius: 25)
                        .fill(.gray.opacity(0.75))
                        .stroke(theme.isDark ? .white : .black, lineWidth: 1)
                        .frame(width: calculateWidthCategory(), height: 40)
                        .overlay(
                            HStack{
                                Image(systemName: "square.3.layers.3d.top.filled")
                                    .foregroundStyle(theme.isDark ? .white : .black)
                                
                                Text(card.category)
                                    .foregroundStyle(theme.isDark ? .white : .black)
                            }
                        ).padding(.top,8)
                    
                    RoundedRectangle(cornerRadius: 25)
                        .fill(.gray.opacity(0.75))
                        .stroke(theme.isDark ? .white : .black, lineWidth: 1)
                        .frame(width: 350 ,height: calculateHeight() )
                        .overlay(
                            ScrollView(showsIndicators: false){
                                VStack{
                                    Text("Name")
                                        .fontWeight(.bold)
                                        .underline()
                                        .foregroundStyle(theme.isDark ? .white : .black)
                                        .padding(.top,5)
                                        .padding(.bottom, 2)
                                    Text(card.name.uppercased())
                                        .foregroundStyle(theme.isDark ? .white : .black)
                                        .multilineTextAlignment(.center)
                                        .padding(.horizontal)
                                    Text("Description")
                                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                        .foregroundStyle(theme.isDark ? .white : .black)
                                        .underline()
                                        .padding(.bottom, 2)
                                    //                            ScrollView{
                                    Text(card.description)
                                        .foregroundStyle(theme.isDark ? .white : .black)
                                        .multilineTextAlignment(.center)
                                        .padding(.horizontal)
                                    //                            }
                                }.padding(.bottom,10)
                            }
                        )
                        .padding()
                    
                    if card.category != "Spell" && card.category != "Trap"{
                        HStack{
                            Spacer()
                            RoundedRectangle(cornerRadius: 25)
                                .fill(.gray.opacity(0.75))
                                .stroke(.red, lineWidth: 1)
                                .frame(width: 100, height: 40)
                                .overlay(
                                    HStack{
                                        Image(systemName: "person.2.slash")
                                            .foregroundStyle(theme.isDark ? .white : .black)
                                        Text(card.attack)
                                            .foregroundStyle(theme.isDark ? .white : .black)
                                    }
                                )
                            Spacer()
                            if card.category != "Link"{
                                RoundedRectangle(cornerRadius: 25)
                                    .fill(.gray.opacity(0.75))
                                    .stroke(theme.isDark ? .white : .black, lineWidth: 1)
                                    .frame(width: 80, height: 40)
                                    .overlay(
                                        HStack{
                                            Image(systemName: "star.circle")
                                                .foregroundStyle(theme.isDark ? .white : .black)
                                            Text(card.rank)
                                                .foregroundStyle(theme.isDark ? .white : .black)
                                        }
                                    )
                                Spacer()
                                RoundedRectangle(cornerRadius: 25)
                                    .fill(.gray.opacity(0.75))
                                    .stroke(theme.isDark ? .blue : .blue, lineWidth: 1)
                                    .frame(width: 100, height: 40)
                                    .overlay(
                                        HStack{
                                            Image(systemName: "shield.lefthalf.filled")
                                                .foregroundStyle(theme.isDark ? .white : .black)
                                            Text(card.defense)
                                                .foregroundStyle(theme.isDark ? .white : .black)
                                        }
                                    )
                            }
                            else{
                                RoundedRectangle(cornerRadius: 25)
                                    .fill(.gray.opacity(0.75))
                                    .stroke(theme.isDark ? .white : .black, lineWidth: 1)
                                    .frame(width: 80, height: 40)
                                    .overlay(
                                        HStack{
                                            Image(systemName: "link")
                                                .foregroundStyle(theme.isDark ? .white : .black)
                                            Text(card.rank)
                                                .foregroundStyle(theme.isDark ? .white : .black)
                                        }
                                    )
                            }
                            Spacer()
                        }
                    }
                    
                    
                    HStack{
                        Spacer()
                        RoundedRectangle(cornerRadius: 25)
                            .fill(.gray.opacity(0.75))
                            .stroke(theme.isDark ? .white : .black, lineWidth: 1)
                            .frame(width: card.type.count > 8 ? 180 : 120 , height: 40)
                            .overlay(
                                HStack{
                                    Image(systemName: "theatermasks")
                                        .foregroundStyle(theme.isDark ? .white : .black)
                                    Text(card.type)
                                        .foregroundStyle(theme.isDark ? .white : .black)
                                }
                            )
                        Spacer()
                        if(card.attribute != "Spell" && card.attribute != "Trap"){
                            RoundedRectangle(cornerRadius: 25)
                                .fill(.gray.opacity(0.75))
                                .stroke(theme.isDark ? .white : .black, lineWidth: 1)
                                .frame(width: 100, height: 40)
                                .overlay(
                                    HStack{
                                        Image(systemName: "circle.hexagongrid")
                                            .foregroundStyle(theme.isDark ? .white : .black)
                                        Text(card.attribute)
                                            .foregroundStyle(theme.isDark ? .white : .black)
                                    }
                                )
                            Spacer()
                        }
                    }.padding(.vertical,5)
                    
                    HStack{
                        if(card.archetype != "None"){
                            RoundedRectangle(cornerRadius: 25)
                                .fill(.gray.opacity(0.75))
                                .stroke(theme.isDark ? .white : .black, lineWidth: 1)
                                .frame(width: calculateWidth(), height: 40)
                                .overlay(
                                    HStack{
                                        Image(systemName: "point.3.connected.trianglepath.dotted")
                                            .foregroundStyle(theme.isDark ? .white : .black)
                                        Text(card.archetype)
                                            .foregroundStyle(theme.isDark ? .white : .black)
                                    }
                                )
                        }
                    }
                    
                    if(!relatedCards.isEmpty){
                        
                        Text("Related cards:")
                            .font(.title2)
                            .foregroundStyle(theme.isDark ? .white : .black)
                            .multilineTextAlignment(.center)
                            .padding(.vertical)
                        
                        ScrollView{
                            LazyVGrid(columns: adaptiveColumns, spacing: 20){
                                ForEach(relatedCards){ card in
                                    ZStack{
                                        Button(action: {
                                            isPresented = !isPresented
                                            cardData.presentedCard = card
                                            
                                            Task{
                                                do {
                                                    let (data, _) =  try await URLSession.shared.data(from: card.imageUrl)
                                                    image = UIImage(data: data)
                                                } catch let error {
                                                    print(error)
                                                }
                                            }
                                        }){
                                            SmallCardView(card: Binding.constant(card))
                                        }
                                    }
                                }
                            }
                        }
                    }
                }.padding()
                    .task {
                        do {
                            let (data, _) =  try await URLSession.shared.data(from: card.imageUrl)
                            image = UIImage(data: data)
                        } catch let error {
                            print(error)
                        }
                    }
            }
        }
//        .sheet(isPresented: $isPresented) {
//            CardView(card: $cardData.presentedCard)
//        }
    }
}

#Preview {
    CardView(card: Binding.constant(Card(
        name: "Blue Eyes White Dragon",
        category: "Monster",
        description: "This legendary dragon is a powerful engine of destruction. Virtuallfmiewfoiwefioieeifjeoijfijejiefieonfwoifneonfioenfofoeijoiefijefifjeijeijfejfeifjeijfefjioejf",
        imageUrl: URL(string: "https://images.ygoprodeck.com/images/cards/89631139.jpg")!,
        type: "Dragon",
        archetype: "Blue-Eyes",
        attribute: "Divine",
        rank: "8",
        attack: "3000",
        defense: "2500"
        ))//,isPresented: Binding.constant(true)
    )
    .environmentObject(Theme())
    .environmentObject(UserData())
    .environmentObject(CardData())
}
