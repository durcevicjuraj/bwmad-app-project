//
//  User.swift
//  yu-gi-oh-cardex
//
//  Created by Juraj Đurčević on 29.01.2024..
//

import Foundation

class User: Identifiable, Codable{
    
    var id: String = UUID().uuidString
    var username : String
    var password : String
    var imageUrl : URL
    var likedCards : [String]  = ["nothing"]
    
    init(username: String, password : String){
        self.username = username
        self.password = password
        self.imageUrl = URL(string:"https://t4.ftcdn.net/jpg/00/64/67/63/360_F_64676383_LdbmhiNM6Ypzb3FM4PPuFP9rHe7ri8Ju.jpg")!
    }
    
    init(username: String, password : String,imageUrl: URL){
        self.username = username
        self.password = password
        self.imageUrl = imageUrl
    }
    
    init(username: String, password : String,imageUrl: URL, likedCards : [String]){
        self.username = username
        self.password = password
        self.imageUrl = imageUrl
        self.likedCards = likedCards
    }
}
