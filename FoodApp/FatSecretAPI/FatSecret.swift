//
//  FatSecret.swift
//  FoodApp
//
//  Created by Thawatchai Chumsook on 17/04/2023.
//

import Foundation
struct FatSecretAPI: Decodable {
    
    struct Recipe: Decodable {
        let cooking_time_mind: String?
        let directions: Direction?
        let ingredients: Ingredients?
        let number_of_servings: String?
        let preparation_time_min: String?
        let rating: String?
        //let serving_sizes: Servings?
        
        
    }
    
    struct Direction: Decodable {
        let direction_description: String?
        let direction_number: String?
    }
    
    struct Ingredients: Decodable {
        
    }
    
    struct Ingredient: Decodable {
        let food_id: String?
        let food_name: String?
        let ingredient_description: String?
        let ingredient_url: String?
        let measurement_description: String?
        let number_of_units: String?
        let serving_ud: String?
    }
}
