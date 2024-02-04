//
//  yu_gi_oh_cardexApp.swift
//  yu-gi-oh-cardex
//
//  Created by Juraj Đurčević on 23.01.2024..
//  2355 lines of code in total

import SwiftUI

@main
struct yu_gi_oh_cardexApp: App {
    
    @StateObject var cardData = CardData()
    @StateObject var theme = Theme()
    @StateObject var userData = UserData()
    
    @State private var selectedTab = 1
    
    var body: some Scene {
        WindowGroup {
            TabView(selection: $selectedTab) {
                        MoreView()
                            .tabItem {
                                Label("More", systemImage: "ellipsis.circle")
                            }
                            .tag(0)
                            .toolbarBackground(theme.isDark ? theme.darkColor : theme.whiteColor, for: .tabBar)
                            .toolbarBackground(.visible, for: .tabBar)
                        SearchView()
                            .tabItem {
                                Label("Search", systemImage: "magnifyingglass.circle")
                            }
                            .tag(1)
                            .toolbarBackground(theme.isDark ? theme.darkColor : theme.whiteColor, for: .tabBar)
                            .toolbarBackground(.visible, for: .tabBar)
                        ProfileView()
                            .tabItem {
                                Label("Profile", systemImage: "person.circle.fill")
                            }
                            .tag(2)
                            .toolbarBackground(theme.isDark ? theme.darkColor : theme.whiteColor, for: .tabBar)
                            .toolbarBackground(.visible, for: .tabBar)
            }
            .accentColor(.red)
            .environmentObject(cardData)
            .environmentObject(theme)
            .environmentObject(userData)
            .task {
                await cardData.fetchCards()
                await userData.fetchUsers()
            }
        }
    }
}
