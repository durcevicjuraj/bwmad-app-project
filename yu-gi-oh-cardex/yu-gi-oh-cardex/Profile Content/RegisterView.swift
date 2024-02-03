//
//  RegisterView.swift
//  yu-gi-oh-cardex
//
//  Created by Juraj Đurčević on 29.01.2024..
//

import SwiftUI

struct RegisterView: View {
    
    @EnvironmentObject var theme : Theme
    @EnvironmentObject var userData : UserData
    
    @Binding var isPresented: Bool
    
    @State var passwordQuery = ""
    @State var usernameQuery = ""
    
    @State var isTaken: Bool = false
    
    var body: some View {
        
        ZStack{
                         
            RoundedRectangle(cornerRadius: 25)
                .fill(theme.isDark ? theme.darkColor.opacity(0.95) : theme.whiteColor.opacity(0.95))
                .stroke(theme.isDark ? .white : .black, lineWidth:2)
                .frame(width: 300,height: 390)
                .overlay(
                    VStack{
                        Spacer()
                        HStack{
                            Spacer()
                            Button(action: {isPresented = false}){
                                Image(systemName: "arrowshape.backward")
                                    .resizable()
                                    .frame(width:25,height: 25)
                                    .foregroundStyle(theme.isDark ? .white : .black)
                                    .padding(.trailing,20)
                                    .padding(.top,5)
                            }
                        }
                        
                        Spacer()
                        
                        Text("Welcome aboard! Dive into the world of Yu-Gi-Oh! cards with our app after completing your registration.")
                            .foregroundStyle(theme.isDark ? .white : .black)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                        
                        Spacer()
                        Spacer()
                        
                        Text("Input your username:")
                            .fontWeight(.bold)
                            .foregroundStyle(theme.isDark ? .white : .black)
                        RoundedRectangle(cornerRadius: 25)
                            .fill(.gray)
                            .stroke(theme.isDark ? .white : .black)
                            .frame(width: 250,height: 25)
                            .overlay(
                                TextField("Username...", text: $usernameQuery)
                                    .foregroundStyle(theme.isDark ? .black : .white)
                                    .autocapitalization(.none)
                                    .autocorrectionDisabled()
                                    .multilineTextAlignment(.center)
                                    .padding()
                            )
                        
                        Text("Input your password:")
                            .fontWeight(.bold)
                            .foregroundStyle(theme.isDark ? .white : .black)
                        RoundedRectangle(cornerRadius: 25)
                            .fill(.gray)
                            .stroke(theme.isDark ? .white : .black)
                            .frame(width: 250,height: 25)
                            .overlay(
                                SecureField("Password...", text: $passwordQuery)
                                    .foregroundStyle(theme.isDark ? .black : .white)
                                    .autocapitalization(.none)
                                    .autocorrectionDisabled()
                                    .multilineTextAlignment(.center)
                                    .padding()
                            )
                        
                        Spacer()
                        
                        Button(action: {
                            if(userData.isUserRegistered(username: usernameQuery)){
                                isTaken = true
                            }
                            else {
                                Task {
                                    let user = User(username: usernameQuery, password: passwordQuery)
                                    await userData.registerUser(user: user)
                                    userData.users.append(user)
                                }
                                isTaken = false
                                isPresented = !isPresented
                            }
                        })
                        {
                            VStack{
                                if(isTaken){
                                    Text("The username is already taken.")
                                        .foregroundStyle(.red)
                                }
                                else{
                                    Text("The username is already taken.")
                                        .foregroundStyle(.clear)
                                }
                                
                                RoundedRectangle(cornerRadius: 25)
                                    .fill(theme.LogButtonColor)
                                    .frame(width:80,height: 40)
                                    .overlay(
                                        Text("Register")
                                            .foregroundStyle(.white)
                                    )
                            }
                        }.disabled(passwordQuery.isEmpty || usernameQuery.isEmpty)
                        .padding()
                        Spacer()
                    }
                )
        }
    }
}

#Preview {
    RegisterView(isPresented: Binding.constant(true))
        .environmentObject(Theme())
        .environmentObject(UserData())
}
