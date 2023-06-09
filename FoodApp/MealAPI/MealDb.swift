//
//  MealDb.swift
//  FoodApp
//
//  Created by Thawatchai Chumsook on 29/03/2023.
//

import Foundation
struct MealDb: Decodable {
    
    let meals: [Meals]
    
    struct Meals:Decodable {
        let idMeal: String
        let strMeal: String
        let strDrinkAlternate: String?
        let strArea: String
        let strInstructions: String
        let strMealThumb: String?
        let strTags: String?
        
        
        let strIngredient1: String?
        let strIngredient2: String?
        let strIngredient3: String?
        let strIngredient4: String?
        let strIngredient5: String?
        let strIngredient6: String?
        let strIngredient7: String?
        let strIngredient8: String?
        let strIngredient9: String?
        let strIngredient10: String?
        let strIngredient11: String?
        let strIngredient12: String?
        let strIngredient13: String?
        let strIngredient14: String?
        let strIngredient15: String?
        let strIngredient16: String?
        let strIngredient17: String?
        let strIngredient18: String?
        let strIngredient19: String?
        let strIngredient20: String?
        
        let strMeasure1: String?
        let strMeasure2: String?
        let strMeasure3: String?
        let strMeasure4: String?
        let strMeasure5: String?
        let strMeasure6: String?
        let strMeasure7: String?
        let strMeasure8: String?
        let strMeasure9: String?
        let strMeasure10: String?
        let strMeasure11: String?
        let strMeasure12: String?
        let strMeasure13: String?
        let strMeasure14: String?
        let strMeasure15: String?
        let strMeasure16: String?
        let strMeasure17: String?
        let strMeasure18: String?
        let strMeasure19: String?
        let strMeasure20: String?
        
        let strSource: String?
        let strImageSource: String?
        let strCreativeCommonsConfirmed: String?
        let dateModified: String?
        
        // Calculating time it takes to cook the recipe
        func cookingTime() -> Double{
            let instructionsArray = strInstructions.components(separatedBy: " ")
            var timeCounter = 0
            var x = 0
            
            while x < instructionsArray.count{
                if(instructionsArray[x].lowercased().contains("minutes") || instructionsArray[x].lowercased().contains("min") && x > 1){
                    if(instructionsArray[x-1].contains("-")){
                        timeCounter += removingDash(input: instructionsArray[x-1])
                    } else {
                        timeCounter += Int(instructionsArray[x-1]) ?? 0
                    }
                }
                if(instructionsArray[x].lowercased().contains("seconds") || instructionsArray[x].lowercased().contains("sec") && x > 1){
                    if(instructionsArray[x-1].contains("-")){
                        timeCounter += removingDash(input: instructionsArray[x-1])
                    } else {
                        timeCounter += (Int(instructionsArray[x-1]) ?? 0) / 60
                    }
                    
                }
                if(instructionsArray[x].lowercased().contains("hours") || instructionsArray[x].lowercased().contains("hr") && x > 1){
                    if(instructionsArray[x-1].contains("-")){
                        timeCounter += removingDash(input: instructionsArray[x-1])
                    } else {
                        timeCounter += (Int(instructionsArray[x-1]) ?? 0) * 60
                    }
                }
                x = x + 1
            }
            if(timeCounter <= 0){
                timeCounter = 60
            }
            let updateByFourtyPercent = Double(timeCounter) * 1.4
            let rounded = updateByFourtyPercent - (updateByFourtyPercent.truncatingRemainder(dividingBy: 1.0))
            return rounded
        }
        
        func removingDash(input:String) -> Int {
            let number = input.firstIndex(of: "-")!
            var changedString = input[number...]
            changedString.remove(at: changedString.firstIndex(of: "-")!)
            let integer = Int(changedString) ?? 0
            return integer
        }
        
        
        func getIngredients() -> [String]{
            let tempIngredients = [strIngredient1,strIngredient2,strIngredient3,strIngredient4,strIngredient5,strIngredient6,strIngredient7,strIngredient8,strIngredient9,strIngredient10,strIngredient11,strIngredient12,strIngredient13,strIngredient14,strIngredient15,strIngredient16,strIngredient17,strIngredient18,strIngredient19,strIngredient20]
            var ingredients = [String]()
            for x in tempIngredients{
                if x != nil && x != ""{
                    ingredients.append(x!)
                }
            }
            return ingredients
        }
        
    }
    
}
