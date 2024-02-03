//
//  LogInView.swift
//  yu-gi-oh-cardex
//
//  Created by Juraj Đurčević on 01.02.2024..
//

import SwiftUI

struct LogInView: View {
    
    @EnvironmentObject var theme : Theme
    @EnvironmentObject var userData : UserData
    
    @State var isPresented: Bool = false
    @State var isRegistering: Bool = false
    
    @State var wasLogInProblem : Bool = false
    @State var usernameQuery = ""
    @State var passwordQuery = ""
    
    @State private var offsetY: CGFloat = UIScreen.main.bounds.height
    
    var body: some View {
        ZStack{
            
            theme.isDark ? Image("darkBackground").resizable().ignoresSafeArea(.all) : Image("whiteBackground").resizable().ignoresSafeArea()
            
            VStack{
                Spacer()
                Image("yugiohLogo")
                    .resizable()
                    .frame(width:300,height: 100)
                    .padding()
                
                
                RoundedRectangle(cornerRadius: 25)
                    .fill(.gray)
                    .stroke(theme.isDark ? .white : .black)
                    .frame(width: 250,height: 25)
                    .overlay(
                        TextField("Username...", text: $usernameQuery)
                            .foregroundStyle(theme.isDark ? .black : .white)
                            .autocapitalization(.none)
                            .multilineTextAlignment(.center)
                            .padding()
                    ).padding(.bottom)
                
                RoundedRectangle(cornerRadius: 25)
                    .fill(.gray)
                    .stroke(theme.isDark ? .white : .black)
                    .frame(width: 250,height: 25)
                    .overlay(
                        SecureField("Password...", text: $passwordQuery)
                            .foregroundStyle(theme.isDark ? .black : .white)
                            .autocapitalization(.none)
                            .multilineTextAlignment(.center)
                            .padding()
                    )
                
                
                Button(action: {
                    Task{
                        if(userData.canUserLogIn(username: usernameQuery, password: passwordQuery)){
                            wasLogInProblem = false
                            usernameQuery = ""
                            passwordQuery = ""
                        }
                        else{
                            wasLogInProblem = true
                        }
                    }
                }
                ){
                    RoundedRectangle(cornerRadius: 25)
                        .fill(theme.LogButtonColor)
                        .frame(width:80,height: 40)
                        .overlay(
                            Text("Log in")
                                .foregroundStyle(.white)
                        )
                }.padding()
                
                if(wasLogInProblem){
                    Text("Sorry, login failed. Please check your credentials and try again.")
                        .foregroundStyle(.red)
                        .multilineTextAlignment(.center)
                        .padding()
                }
                else{
                    Text("Sorry, login failed. Please check your credentials and try again.")
                        .foregroundStyle(.clear)
                        .multilineTextAlignment(.center)
                        .padding()
                }
                
                Spacer()
                Text("New here?\nClick 'Register' to create your account now!")
                    .foregroundStyle(theme.isDark ? .white : .black)
                    .multilineTextAlignment(.center)
                    .fontWeight(.bold)
                Button(action: {isRegistering = !isRegistering})
                {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(theme.isDark ? theme.DarkRegButtonColor : theme.LightRegButtonColor)
                        .frame(width:80,height: 40)
                        .overlay(
                            Text("Register")
                                .foregroundStyle(theme.isDark ? .white : .black)
                        )
                }.padding()
            }
            
            if(isRegistering){
                RegisterView(isPresented: $isRegistering)
                    .offset(y: isPresented ? 0 : offsetY)
                            .onAppear {
                                // Slide-in animation
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    offsetY = 0
                                }
                            }
                            .onDisappear {
                                // Slide-out animation
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    offsetY = 500
                                }
                            }
            }
        }
    }
}

#Preview {
    LogInView()
        .environmentObject(Theme())
        .environmentObject(UserData())
}
