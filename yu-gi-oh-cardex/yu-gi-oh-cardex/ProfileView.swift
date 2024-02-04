//
//  ProfileView.swift
//  yu-gi-oh-cardex
//
//  Created by Juraj Đurčević on 23.01.2024..
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var cardData : CardData
    @EnvironmentObject var theme : Theme
    @EnvironmentObject var userData : UserData
    
    @State var isRegistering: Bool = false
    @State var wasLogInProblem : Bool = false
    
    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 100))
    ]
    
    @State var usernameQuery = ""
    @State var passwordQuery = ""
    
    @State var isPresented: Bool = false
    
    @State var image: UIImage? = nil
    
    var body: some View {
        if(userData.isLoggedIn){
            ZStack{
                theme.isDark ? Image("darkBackground").resizable().ignoresSafeArea() : Image("whiteBackground").resizable().ignoresSafeArea()
                
                VStack{
                    VStack{
                        if let newimage = image {
                            Image(uiImage: newimage)
                                .resizable()
                                .clipShape(Circle())
                                .frame(width: 130, height: 130)
                                .padding(.top)
                        }
                        else {
                            Image(systemName: "questionmark.circle.fill")
                                .resizable()
                                .clipShape(Circle())
                                .frame(width:130, height: 130)
                                .foregroundColor(.gray)
                                .padding(.top)
                        }
                        
                        Text(userData.loggedInUser.username)
                            .fontWeight(.bold)
                            .foregroundStyle(theme.isDark ? .white : .black)
                            .font(.title2)
                            .padding(.top)
                        
                        Button(action: {
                            userData.isLoggedIn = !userData.isLoggedIn
                            Task{
                                await userData.updateUser(newUser: userData.loggedInUser )
                            }
                        }){
                            RoundedRectangle(cornerRadius: 25)
                                .fill(theme.LogButtonColor)
                                .frame(width:80,height: 40)
                                .overlay(
                                    Text("Log out")
                                        .foregroundStyle(.white)
                                )
                        }.padding()
                        
                        
                        ScrollView{
                            LazyVGrid(columns: adaptiveColumns, spacing: 20){
                                
                                ForEach(cardData.getCards(inds: userData.loggedInUser.likedCards)){ card in
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
                    }
                }.sheet(isPresented: $isPresented) {
                    CardView(card: $cardData.presentedCard)
                }
                .task {
                    do {
                        let (data, _) =  try await URLSession.shared.data(from: userData.loggedInUser.imageUrl)
                        image = UIImage(data: data)
                    } catch let error {
                        print(error)
                    }
                }
            }
        }
                else{
                    LogInView()
            }
    }
}

#Preview {
    ProfileView()
        .environmentObject(UserData())
        .environmentObject(Theme())
        .environmentObject(CardData())
}
