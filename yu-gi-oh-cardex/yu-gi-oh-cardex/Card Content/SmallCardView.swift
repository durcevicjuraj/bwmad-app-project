//
//  SmallCardView.swift
//  yu-gi-oh-cardex
//
//  Created by Juraj Đurčević on 28.01.2024..
//

import SwiftUI

struct SmallCardView: View {
    
    @Binding var card: Card
    
    @State var image: UIImage? = nil
    
    var body: some View {
        VStack{
            
            if let newimage = image {
                Image(uiImage: newimage)
                    .resizable()
                    .frame(width: 100, height: 162)
            }
            else {
                Image("cardBackground")
                    .resizable()
                    .frame(width:100, height: 162)
                    .foregroundColor(.gray)
            }
            
        }
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

#Preview {
    SmallCardView(card: Binding.constant(Card(
        name: "Blue Eyes White Dragon",
        category: "Monster",
        description: "This legendary dragon is a powerful engine of destruction. Virtually invincible, very few have faced this awesome creature and lived to tell the tale.",
        imageUrl: URL(string: "https://images.ygoprodeck.com/images/cards/89631139.jpg")!,
        type: "Dragon",
        archetype: "Blue-Eyes",
        attribute: "Light",
        rank: "8",
        attack: "3000",
        defense: "2500"
        ))
    )
}
