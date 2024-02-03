//
//  CardLegendView.swift
//  yu-gi-oh-cardex
//
//  Created by Juraj Đurčević on 29.01.2024..
//

import SwiftUI

struct CardLegendView: View {
    
    @EnvironmentObject var theme : Theme
    
    var body: some View {
        VStack{
            Image("cardBackground")
                .resizable()
                .frame(width: 80,height: 120)
                .padding()
            
            RoundedRectangle(cornerRadius: 25)
                .fill(.gray)
                .stroke(.black, lineWidth: 2)
                .frame(width: 350, height: 60)
                .overlay(
                    HStack{
                        Image(systemName: "person.2.slash")
                            .resizable()
                            .frame(width:40,height: 40)
                        Spacer()
                        Text(" Attack strength")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        Spacer()
                    }.padding()
                )
            
            RoundedRectangle(cornerRadius: 25)
                .fill(.gray)
                .stroke(.black, lineWidth: 2)
                .frame(width: 350, height: 60)
                .overlay(
                    HStack{
                        Image(systemName: "shield.lefthalf.filled")
                            .resizable()
                            .frame(width:40,height: 40)
                        Spacer()
                        Text("Defense strength")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        Spacer()
                    }.padding()
                )
            RoundedRectangle(cornerRadius: 25)
                .fill(.gray)
                .stroke(.black, lineWidth: 2)
                .frame(width: 300, height: 60)
                .overlay(
                    HStack{
                        Image(systemName: "square.3.layers.3d.top.filled")
                            .resizable()
                            .frame(width: 40, height: 40)
                        Spacer()
                        Text("Category")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        Spacer()
                    }.padding()
                )
            
            RoundedRectangle(cornerRadius: 25)
                .fill(.gray)
                .stroke(.black, lineWidth: 2)
                .frame(width: 280, height: 60)
                .overlay(
                    HStack{
                        Image(systemName: "point.3.connected.trianglepath.dotted")
                            .resizable()
                            .frame(width:40,height: 40)
                        Spacer()
                        Text("Archetype")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        Spacer()
                    }.padding()
                )
            
            RoundedRectangle(cornerRadius: 25)
                .fill(.gray)
                .stroke(.black, lineWidth: 2)
                .frame(width: 260, height: 60)
                .overlay(
                    HStack{
                        Image(systemName: "circle.hexagongrid")
                            .resizable()
                            .frame(width:40,height: 40)
                        Spacer()
                        Text("Attribute")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        Spacer()
                    }.padding()
                )
            
            RoundedRectangle(cornerRadius: 25)
                .fill(.gray)
                .stroke(.black, lineWidth: 2)
                .frame(width: 250, height: 60)
                .overlay(
                    HStack{
                        Image(systemName: "star.circle")
                            .resizable()
                            .frame(width:40,height: 40)
                        Spacer()
                        Text("Rank/Level")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        Spacer()
                    }.padding()
                )
            
            RoundedRectangle(cornerRadius: 25)
                .fill(.gray)
                .stroke(.black, lineWidth: 2)
                .frame(width: 200, height: 60)
                .overlay(
                    HStack{
                        Image(systemName: "theatermasks")
                            .resizable()
                            .frame(width:40,height: 40)
                        Spacer()
                        Text("Type")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        Spacer()
                    }.padding()
                )
            
            RoundedRectangle(cornerRadius: 25)
                .fill(.gray)
                .stroke(.black, lineWidth: 2)
                .frame(width: 200, height: 60)
                .overlay(
                    HStack{
                        Image(systemName: "link")
                            .resizable()
                            .frame(width:40,height: 40)
                        Spacer()
                        Text("Link")
                            .font(.title)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        Spacer()
                    }.padding()
                )
            Spacer()
        }
    }
}

#Preview {
    CardLegendView()
        .environmentObject(Theme())
}

