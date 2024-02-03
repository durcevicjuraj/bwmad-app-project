//
//  Card.swift
//  yu-gi-oh-cardex
//
//  Created by Juraj Đurčević on 23.01.2024..
//

import Foundation

class Card: Identifiable, Codable{
    /*Every Card has these attributes*/
    var id: String = UUID().uuidString
    var name: String
    var category: String
    var description : String
    var imageUrl : URL
    var type : String
    var archetype : String
    var attribute : String
    var isFavorite : Bool
    
    /*Extra & Monster Card attributes*/
    var rank : String
    var attack : String
    var defense : String
    
    init(name: String, category: String, description: String, imageUrl: URL, type: String, archetype: String, attribute: String, rank: String, attack: String, defense: String){
        self.name = name
        self.category = category
        self.description = description
        self.imageUrl = imageUrl
        self.type = type
        self.archetype = archetype
        self.attribute = attribute
        self.isFavorite = false
        self.rank = rank
        self.attack = attack
        self.defense = defense
    }
}




