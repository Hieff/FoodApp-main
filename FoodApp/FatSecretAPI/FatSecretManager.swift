//
//  FatSecretManager.swift
//  FoodApp
//
//  Created by Thawatchai Chumsook on 17/04/2023.
//

import Foundation
import OAuthSwift

class FatSecretManager {
    
    
    
    init() {
        /*generateSignature { token in
            self.searchFood(query: "chicken", accessToken: token) { result in
                
            }
        }*/
    }
    
    func searchFood(query: String, accessToken: String, completion: @escaping (String) -> Void) {
        let apiKey = "67ad3ae8b4fd41d2b646fff4658965a9"
        let apiSecret = "fbe652dff18549ac9656235180ace02e"

        let oauthswift = OAuth2Swift(
            consumerKey: apiKey,
            consumerSecret: apiSecret,
            authorizeUrl: "https://oauth.fatsecret.com/oauth/authenticate",
            accessTokenUrl: "https://oauth.fatsecret.com/oauth/token",
            responseType: "code"
        )
        oauthswift.client.credential.oauthToken = accessToken
        oauthswift.client.get("https://platform.fatsecret.com/rest/server.api?method=foods.search&search_expression=\(query)&format=json") { result in
            do {
                let response = try result.get()
                guard let dataString = response.string else {
                   print("Unable to parse response data.")
                   return
                }
                let jsonData = Data(dataString.utf8)
                do {
                    let searchResponse = try JSONDecoder().decode(FoodSearchResponse.self, from: jsonData)
                    // Access the search results in searchResponse.foods.food array
                    print("reponse: \(searchResponse)")
                } catch {
                    print("Error decoding search response: \(error.localizedDescription)")
                }
            } catch {
                print("Error search response: \(error.localizedDescription)")
            }
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

extension String {
    func percentEncoded() -> String {
        let allowed = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-._~")
        return self.addingPercentEncoding(withAllowedCharacters: allowed)!
    }
}
