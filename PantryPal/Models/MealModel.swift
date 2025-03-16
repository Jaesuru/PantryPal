//
//  MealModel.swift
//  PantryPal
//
//  Created by Jason Jiang on 3/15/25.
//

import SwiftUI
import Foundation

struct MealModel: Identifiable, Decodable {
    let idMeal: String
    let strMeal: String
    let strMealThumb: String
    let strInstructions: String
    
    var id: String { idMeal }
}

struct MealResponse: Decodable {
    let meals: [MealModel]?
}
