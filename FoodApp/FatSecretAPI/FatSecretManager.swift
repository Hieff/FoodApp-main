//
//  FatSecretManager.swift
//  FoodApp
//
//  Created by Thawatchai Chumsook on 17/04/2023.
//

import Foundation
class FatSecretManager {
    
    
    
    init() {
        //fetchRequest("Pizza");
    }
    
    
    func fetchRequest(_ search: String) {
        generateSignature { accessToken in
            print(accessToken)
            // Define the URL, headers, and parameters
            let url = URL(string: "https://platform.fatsecret.com/api/1.0/")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
            let parameters = ["method": "food.search", "search_expression": search, "format": "json"]
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])

            // Create a URLSession
            let session = URLSession.shared

            // Create a data task with the request
            let task = session.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    return
                }
                
                // Check if there's data returned
                guard let data = data else {
                    print("No data returned.")
                    return
                }
                                
                // Parse the response data
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    print("Response JSON: \(json ?? [:])")
                    // Handle the response data as needed
                } catch {
                    print("Error parsing JSON: \(error.localizedDescription)")
                }
            }
            task.resume()
        }
    }
    
    fileprivate func generateSignature(callback:@escaping (String) -> Void) {
        // Define the URL
        let url = URL(string: "https://oauth.fatsecret.com/connect/token")!

        // Define the headers
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let clientID = "67ad3ae8b4fd41d2b646fff4658965a9"
        let clientSecret = "fbe652dff18549ac9656235180ace02e"
        let authString = "\(clientID):\(clientSecret)"
        if let authData = authString.data(using: .ascii) {
            let base64AuthString = authData.base64EncodedString()
            request.setValue("Basic \(base64AuthString)", forHTTPHeaderField: "Authorization")
        }

        // Define the parameters
        let parameters = ["scope": "basic", "grant_type": "client_credentials"]
        let body = parameters.map { "\($0.key)=\($0.value)" }.joined(separator: "&")
        request.httpBody = body.data(using: .utf8)

        // Create a URLSession
        let session = URLSession.shared
        // Create a data task with the request
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }

            // Check if there's data returned
            guard let data = data else {
                print("No data returned.")
                return
            }
            // Parse the response data
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                callback(json!["access_token"] as! String);
            } catch {
                print("Signature Error parsing JSON: \(error.localizedDescription)")
            }
        }
        // Start the data task
        task.resume()
    }
    
    
}
