//
//  FetchedMealManager.swift
//  FoodApp
//
//  Created by Thawatchai Chumsook on 30/03/2023.
//

import Foundation
import UIKit


class FetchedMealManager {
        
    var listOfMeals: [String: MealDb.Meals] = [:]
    var searchedMeals: [MealDb.Meals] = []
    
    init() {
        fetchAllMeals { meal in
            self.listOfMeals[meal.strMeal] = meal
        }
    }
    
    func getMealsBySearch(name input: String) -> [MealDb.Meals] {
        var result = [MealDb.Meals]()
        for (mealName, meal) in listOfMeals {
            if mealName.lowercased().contains(input.lowercased()) {
                result.append(meal)
            }
        }
        searchedMeals = result
        return result
    }
    
    func fetchAllMeals(callback: @escaping (MealDb.Meals) -> Void) {
        for char in "abcdefghijklmnopqrstuvwxyz" {
            fetchMeals(meal: String(char), err: "FetchAllMeals -> failed to decode meal api json.") { meals in
                for meal in meals.meals {
                    callback(meal)
                }
            }
        }
    }
    
    func fetchMeals(meal mealName: String,  err errMsg: String, callback: @escaping (MealDb) -> Void ) {
        let url = URL(string: "https://www.themealdb.com/api/json/v1/1/search.php?f=" + mealName)!
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error accessing meal data api:\(error)")
                return;
            }
            let decoder = JSONDecoder()
            if let data = data {
                do {
                    let decoded = try decoder.decode(MealDb.self, from: data)
                    callback(decoded)
                } catch {
                    print(errMsg)
                }
            }
        }.resume()
    }
    
}
