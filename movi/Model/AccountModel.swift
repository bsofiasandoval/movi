//
//  AccountModel.swift
//  movi
//
//  Created by Alonso Huerta on 14/09/24.
//

import Foundation

struct Account: Codable, Hashable {
    let _id: String
    let type: String
    let nickname: String
    let rewards: Int
    let balance: Double
    let account_number: String?
    let customer_id: String
}

func getAccounts(customerId: String, completion: @escaping (Result<[Account], Error>) -> Void) {
    // Construct the URL
    let urlString = "\(baseURL)/customers/\(customerId)/accounts"
    guard var urlComponents = URLComponents(string: urlString) else {
        completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL components"])))
        return
    }
    // Add the API key as a query parameter
    urlComponents.queryItems = [URLQueryItem(name: "key", value: key)]
    
    guard let url = urlComponents.url else {
        completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
        return
    }
    
    // Create the GET request
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    
    // Perform the request
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        // Handle errors
        if let error = error {
            completion(.failure(error))
            return
        }
        
        // Check for valid data
        guard let data = data else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
            return
        }
        
        // Decode the JSON data
        do {
            let decoder = JSONDecoder()
            let accounts = try decoder.decode([Account].self, from: data)
            completion(.success(accounts))
        } catch {
            completion(.failure(error))
        }
    }
    task.resume()
}
