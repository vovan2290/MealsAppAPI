//
//  MealModel.swift
//  MealsAppAPI
//
//  Created by Imac on 3/11/23.
//

import Foundation

struct Response: Codable {
    var meals: [Meals]?
}

struct Meals: Codable {
    var strMeal: String?
    var strMealThumb: String?
    var idMeal: String?
}


