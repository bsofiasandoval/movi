//
//  eCheqModel.swift
//  movi
//
//  Created by Alonso Huerta on 14/09/24.
//

import Foundation

// MARK: - Codable Structs

struct NewAccount: Codable {
    let type: String
    let nickname: String
    let rewards: Int
    let balance: Double
}

struct CreateAccountResponse: Codable {
    let code: Int
    let message: String
    let objectCreated: AccountCreated
}

struct AccountCreated: Codable {
    let type: String
    let nickname: String
    let rewards: Int
    let balance: Double
    let customer_id: String
    let _id: String
}

struct TransferResponse: Codable {
    let code: Int
    let message: String
    let objectCreated: TransferCreated
}

struct TransferCreated: Codable {
    let _id: String
    let type: String
    let transaction_date: String?
    let status: String
    let medium: String
    let payer_id: String
    let payee_id: String
    let amount: Double
    let description: String?
}

struct TransferRequest: Codable {
    let medium: String
    let payee_id: String
    let amount: Double
    let description: String?
}

// MARK: - Functions

func updateAccount(phoneNumber: String, completion: @escaping (Result<String, Error>) -> Void) {
    var urlComponents = URLComponents(string: "\(baseURL)/customers/\(MoBiId)/accounts")!
    urlComponents.queryItems = [
        URLQueryItem(name: "key", value: key)
    ]
    
    guard let url = urlComponents.url else {
        completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
        return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        // Error handling
        if let error = error {
            completion(.failure(error))
            return
        }
        
        // Ensure data is received
        guard let data = data else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let accounts = try decoder.decode([Account].self, from: data)
            
            // Check if an account with the given nickname exists
            if let existingAccount = accounts.first(where: { $0.nickname == phoneNumber }) {
                completion(.success(existingAccount._id))
            } else {
                // Create a new savings account
                createSavingsAccount(phoneNumber: phoneNumber, completion: completion)
            }
        } catch {
            completion(.failure(error))
        }
    }
    task.resume()
}

func createSavingsAccount(phoneNumber: String, completion: @escaping (Result<String, Error>) -> Void) {
    var urlComponents = URLComponents(string: "\(baseURL)/customers/\(MoBiId)/accounts")!
    urlComponents.queryItems = [
        URLQueryItem(name: "key", value: key)
    ]
    
    guard let url = urlComponents.url else {
        completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
        return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let newAccount = NewAccount(
        type: "Savings",
        nickname: phoneNumber,
        rewards: 0,
        balance: 0
    )
    
    do {
        let encoder = JSONEncoder()
        let jsonData = try encoder.encode(newAccount)
        request.httpBody = jsonData
    } catch {
        completion(.failure(error))
        return
    }
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        // Error handling
        if let error = error {
            completion(.failure(error))
            return
        }
        
        // Ensure data is received
        guard let data = data else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
            return
        }
        
        // Check HTTP status code
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 {
            do {
                let decoder = JSONDecoder()
                let createResponse = try decoder.decode(CreateAccountResponse.self, from: data)
                let accountID = createResponse.objectCreated._id
                completion(.success(accountID))
            } catch {
                completion(.failure(error))
            }
        } else {
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
            let errorMessage = HTTPURLResponse.localizedString(forStatusCode: statusCode)
            let error = NSError(
                domain: "",
                code: statusCode,
                userInfo: [NSLocalizedDescriptionKey: errorMessage]
            )
            completion(.failure(error))
        }
    }
    task.resume()
}

func createECheq(checkingAccountId: String, phoneNumber: String, amount: Double, completion: @escaping (Result<String, Error>) -> Void) {
    // Step 1: Get the payee's account ID
    updateAccount(phoneNumber: phoneNumber) { result in
        switch result {
        case .success(let payeeId):
            // Proceed to create the transfer
            // Step 2: Create the transfer
            let urlString = "\(baseURL)/accounts/\(checkingAccountId)/transfers"
            guard var urlComponents = URLComponents(string: urlString) else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL components"])))
                return
            }
            urlComponents.queryItems = [URLQueryItem(name: "key", value: key)]
            
            guard let url = urlComponents.url else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
                return
            }
            
            // Create the transfer request body
            let transferRequest = TransferRequest(
                medium: "balance",
                payee_id: payeeId,
                amount: amount,
                description: nil
            )
            
            // Encode the request body to JSON
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            do {
                let encoder = JSONEncoder()
                let jsonData = try encoder.encode(transferRequest)
                request.httpBody = jsonData
            } catch {
                completion(.failure(error))
                return
            }
            
            // Perform the POST request to create the transfer
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                    return
                }
                
                // Check HTTP status code
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 {
                    do {
                        let decoder = JSONDecoder()
                        let transferResponse = try decoder.decode(TransferResponse.self, from: data)
                        let transferID = transferResponse.objectCreated._id
                        // Step 3: Return the transfer ID
                        completion(.success(transferID))
                    } catch {
                        completion(.failure(error))
                    }
                } else {
                    let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
                    let errorMessage = HTTPURLResponse.localizedString(forStatusCode: statusCode)
                    let error = NSError(
                        domain: "",
                        code: statusCode,
                        userInfo: [NSLocalizedDescriptionKey: errorMessage]
                    )
                    completion(.failure(error))
                }
            }
            task.resume()
            
        case .failure(let error):
            // Handle error from updateAccount
            completion(.failure(error))
        }
    }
}
