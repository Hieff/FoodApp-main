//
//  FoodCodeReponse.swift
//  FoodApp
//
//  Created by Thawatchai Chumsook on 20/04/2023.
//

import Foundation
struct FoodSearchResponse: Codable {
    let foods: Foods

    private enum CodingKeys: String, CodingKey {
        case foods = "foods"
    }
}

struct Foods: Codable {
    let food: [Food]

    private enum CodingKeys: String, CodingKey {
        case food = "food"
    }
}
