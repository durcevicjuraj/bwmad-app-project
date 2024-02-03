//
//  SettingsView.swift
//  yu-gi-oh-cardex
//
//  Created by Juraj Đurčević on 01.02.2024..
//

import SwiftUI



struct SettingsView: View {
    
    @EnvironmentObject var theme : Theme
    
    let settings : [String] = ["Account", "Accessibility", "Notifications", "Offline Mode"]
    
    @State var selectedSetting : String = ""
    
    @Binding var selectedCategory : String
    
    var body: some View {
        ZStack{
            
            theme.isDark ? Image("darkBackground").resizable().ignoresSafeArea() : Image("whiteBackground").resizable().ignoresSafeArea()
            
            VStack{
                
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
                Spacer()
                
                RoundedRectangle(cornerRadius: 25)
                    .fill(theme.isDark ? theme.darkColor.opacity(0.5) : theme.whiteColor.opacity(0.5))
                    .stroke(theme.isDark ? .white : .black)
                    .frame(width: 175,height: 50)
                    .overlay(
                        HStack{
//                            Text("Dark")
//                                .fontWeight(.bold)
//                                .foregroundStyle(theme.isDark ? .white : .black)
                            Toggle("Darkness", isOn: $theme.isDark)
                                .foregroundStyle(theme.isDark ? .white : .black)
                                .fontWeight(.bold)
                                .padding()
                        }
                    )
                
                ForEach(settings, id: \.self){ setting in
                    ZStack{
                        Button(action: {
                            selectedSetting = setting
                        }){
                            RoundedRectangle(cornerRadius: 25)
                                .fill(theme.isDark ? theme.darkColor.opacity(0.5) : theme.whiteColor.opacity(0.5))
                                .stroke(theme.isDark ? .white : .black)
                                .frame(width: 175,height: 50)
                                .overlay(
                                    Text(setting)
                                        .fontWeight(.bold)
                                        .foregroundStyle(theme.isDark ? .white : .black)
                                )
                        }.padding(.horizontal)
                    }
                }
                Spacer()
            }
        }
    }
}

#Preview {
    SettingsView(selectedCategory: Binding.constant("Settings"))
        .environmentObject(Theme())
}
