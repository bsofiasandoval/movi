//
//  LoginModel.swift
//  movi
//
//  Created by Alonso Huerta on 14/09/24.
//

import Foundation

struct Customer: Codable {
    let _id: String
    let first_name: String
    let last_name: String
    let address: Address
}

struct Address: Codable {
    let street_number: String
    let street_name: String
    let city: String
    let state: String
    let zip: String
}

func getCustomer(customerId: String, completion: @escaping (Result<Customer, Error>) -> Void) {
    // Construct the URL
    let urlString = "\(baseURL)/customers/\(customerId)"
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
            let customer = try decoder.decode(Customer.self, from: data)
            completion(.success(customer))
        } catch {
            completion(.failure(error))
        }
    }
    task.resume()
}
