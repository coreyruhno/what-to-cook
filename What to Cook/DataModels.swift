//
//  DataModels.swift
//  What to Cook
//
//  Created by Corey Ruhno on 3/15/24.
//

import Foundation

struct Ingredient: Identifiable, Hashable {
    let id: String
    let title: String
    let foodType: FoodType
}

struct Recipe: Identifiable, Hashable {
    let id: String
    let title: String
    let ingrients: [Ingredient]
}

enum FoodType {
    case cheese, spice, pasta, produce, meat, sauce, bread, condiment
}

struct MockData {
    static let spaghettiNoodle = Ingredient(id: "1", title: "Spaghetti Noodle", foodType: .pasta)
    static let tomatoSauce = Ingredient(id: "2", title: "Tomato Sauce", foodType: .sauce)
    static let hamburgerMeat = Ingredient(id: "3", title: "Hamburger Meat", foodType: .meat)
    static let bun = Ingredient(id: "4", title: "Bun", foodType: .bread)
    static let ketchup = Ingredient(id: "5", title: "Ketchup", foodType: .condiment)
    
    static let spaghettiRec = Recipe(id: "1", title: "Spaghetti", ingrients: [spaghettiNoodle, tomatoSauce])
    static let hamburgerRec = Recipe(id: "2", title: "Hamburger", ingrients: [hamburgerMeat, bun, ketchup])
    
    static let mockRecipes = [spaghettiRec, hamburgerRec]
}
