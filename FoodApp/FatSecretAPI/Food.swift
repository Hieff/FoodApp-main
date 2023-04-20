//
//  Food.swift
//  FoodApp
//
//  Created by Thawatchai Chumsook on 20/04/2023.
//

import Foundation
struct Food: Codable {
    let foodId: String
    let foodName: String
    let foodType: String
    let foodUrl: String
    let servings: [Serving]?

    private enum CodingKeys: String, CodingKey {
        case foodId = "food_id"
        case foodName = "food_name"
        case foodType = "food_type"
        case foodUrl = "food_url"
        case servings = "servings"
    }
}

struct Serving: Codable {
    let servingId: String
    let servingDescription: String
    let servingUrl: String
    let metricServingAmount: String?
    let metricServingUnit: String?
    let numberOfUnits: String?
    let measurementDescription: String?

    private enum CodingKeys: String, CodingKey {
        case servingId = "serving_id"
        case servingDescription = "serving_description"
        case servingUrl = "serving_url"
        case metricServingAmount = "metric_serving_amount"
        case metricServingUnit = "metric_serving_unit"
        case numberOfUnits = "number_of_units"
        case measurementDescription = "measurement_description"
    }
}
