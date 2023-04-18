//
//  UserProfile.swift
//  FoodApp
//
//  Created by Chumsook, Thawatchai on 18/04/2023.
//

import Foundation
class UserProfile {
    
    var basket = [String]()
    var ratings = [String: Int]()
    
    init() {
        let defaults = UserDefaults.standard
        basket = defaults.object(forKey: "basket") as? [String] ?? []
        ratings = defaults.object(forKey: "ratings") as? [String: Int] ?? [:]
    }
    
    func saveData() {
        let defaults = UserDefaults.standard
        defaults.set(basket, forKey: "basket")
        defaults.set(ratings, forKey: "ratings")
    }
    
    func getBasket() -> [String]{
        return basket
    }
    
    func updateBasket(input: [String]){
        basket = input
    }
}
