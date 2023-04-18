//
//  ImageFinder.swift
//  FoodApp
//
//  Created by Thawatchai Chumsook on 18/04/2023.
//

import Foundation
import UIKit

class ImageFinder {
    
    func fetch(_ imgURL: String, callback: @escaping (UIImage?) -> Void ){
        let url = URL(string: imgURL)
        if let content = url {
            //print("Fetching image: \(imageName)")
            let task = URLSession.shared.dataTask(with: content) { data, response, error in
                if error != nil {
                    print(error)
                } else {
                    callback(UIImage(data: data!))
                }
            }
            task.resume()
        }
    }
    
}
