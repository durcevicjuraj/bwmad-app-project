//
//  UserData.swift
//  yu-gi-oh-cardex
//
//  Created by Juraj Đurčević on 29.01.2024..
//

import Foundation

class UserData: ObservableObject{
    let users_url = URL(string: "https://ios-project-f4371-default-rtdb.europe-west1.firebasedatabase.app/Users.json")!
    let usersPut_url = URL(string: "https://ios-project-f4371-default-rtdb.europe-west1.firebasedatabase.app/Users")!

    
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
            
            let (data , response) = try await URLSession.shared.data(for: request)
            print(response)
            
            if let httpResponse = response as? HTTPURLResponse {
                        print("Status code: \(httpResponse.statusCode)")
                    }
                    
                    if let responseData = String(data: data, encoding: .utf8) {
                        print("Response data: \(responseData)")
                    }
        }catch let error {
            print(error)
        }
    }
    
    func updateUser(newUser: User) async
    {
            do {
                // Fetch all users
                let (data, _) = try await URLSession.shared.data(from: users_url)
                
                // Decode users data
                let decoder = JSONDecoder()
                let decodedUsers = try decoder.decode([String: User].self, from: data)
                
                // Iterate through users to find and update matching user
                for (key, existingUser) in decodedUsers {
                    if existingUser.username == newUser.username {
                        // Update user if names match
                        let encoder = JSONEncoder()
                        encoder.dateEncodingStrategy = .iso8601
                        let json = try encoder.encode(newUser)
                        
                        // Construct URL with key appended to users_url
                        let urlWithKey = URL(string: "\(usersPut_url)/\(key).json")!
                        
                        print(urlWithKey)
                        
                        var request = URLRequest(url: urlWithKey)
                        request.httpMethod = "PUT"
                        request.httpBody = json
                        
                        let (_, response) = try await URLSession.shared.data(for: request)
                        print(response)
                        // Assuming only one user can have the same name,
                        // break the loop if a match is found
                        break
                    }
                }
            } catch let error {
                print(error)
            }
        
        loggedInUser = NotLoggedUser
    }
    
    
    func fetchUsers() async
    {
        do {
            let (data, _) = try await URLSession.shared.data(from: users_url)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            let decoded_users = try decoder.decode([String: User].self, from: data)
            users = [User](decoded_users.values)
            
            for (key, value) in decoded_users {
                        print("Key: \(key), Value: \(value)")
                    }
            
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
