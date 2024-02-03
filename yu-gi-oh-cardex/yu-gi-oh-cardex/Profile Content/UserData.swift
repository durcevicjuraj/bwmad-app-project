//
//  UserData.swift
//  yu-gi-oh-cardex
//
//  Created by Juraj Đurčević on 29.01.2024..
//

import Foundation

class UserData: ObservableObject{
    let users_url = URL(string: "https://ios-project-f4371-default-rtdb.europe-west1.firebasedatabase.app/Users.json")!
    
    @Published var users: [User] = []
    
    @Published var isLoggedIn: Bool = false // treba biti false
    
    @Published var loggedInUser : User = User(username: "Not logged in", password: "nothing", imageUrl: URL(string:"https://t4.ftcdn.net/jpg/00/64/67/63/360_F_64676383_LdbmhiNM6Ypzb3FM4PPuFP9rHe7ri8Ju.jpg")!, likedCards: ["none"])
    
    @Published var NotLoggedUser : User = User(username: "Not logged in", password: "nothing", imageUrl: URL(string:"https://t4.ftcdn.net/jpg/00/64/67/63/360_F_64676383_LdbmhiNM6Ypzb3FM4PPuFP9rHe7ri8Ju.jpg")!, likedCards: ["none"])
    
    func isCardFavorite(current: String) -> Bool {
        for card in loggedInUser.likedCards{
            if(card == current){
                return true
            }
        }
        return false
    }

    
    func registerUser(user: User) async
    {
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            let json = try encoder.encode(user)
            
            
            var request = URLRequest(url: users_url)
            request.httpMethod = "POST"
            request.httpBody = json
            
            let (_, response) = try await URLSession.shared.data(for: request)
            print(response)
        }catch let error {
            print(error)
        }
    }
    
    func updateUser(user: User) async
    {
//        do {
//            let encoder = JSONEncoder()
//            encoder.dateEncodingStrategy = .iso8601
//            let json = try encoder.encode(user)
//            
//            
//            var request = URLRequest(url: users_url)
//            request.httpMethod = "PUT"
//            request.httpBody = json
//            
//            let (_, response) = try await URLSession.shared.data(for: request)
//            print(response)
//        }catch let error {
//            print(error)
//        }
    }
    
    
    func fetchUsers() async
    {
        do {
            let (data, _) = try await URLSession.shared.data(from: users_url)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            let decoded_users = try decoder.decode([String: User].self, from: data)
            users = [User](decoded_users.values)
        } catch let error {
            print(error)
        }
    }

    
    func isUserRegistered(username: String) -> Bool {
        for user in users {
            if user.username == username {
                return true
            }
        }
        return false
    }
    
    func canUserLogIn(username: String, password: String) -> Bool {
        
        if(username.isEmpty || password.isEmpty){
            return false
        }
        for user in users {
            if user.username == username && user.password == password{
                loggedInUser = user
                isLoggedIn = true
                return true
            }
        }
        return false
    }
}
