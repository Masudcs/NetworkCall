//
//  NetworkManger.swift
//  NetworkTry
//
//  Created by Softzino on 22/5/24.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case badServerResponse
}

struct NetworkManager {
    func fetch<T: Codable>(from urlString: String, header: [String: String] = [:], parameter: [String: Any] = [:]) async throws -> T {
        // Create URLComponents to build the URL with query parameters
        guard var urlComponents = URLComponents(string: urlString) else {
            throw NetworkError.badURL
        }
        
        // Add query parameters
        if !parameter.isEmpty {
            urlComponents.queryItems = parameter.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        }
        
        // Construct the URL from the components
        guard let url = urlComponents.url else {
            throw NetworkError.badURL
        }
        
        // Create a URLRequest
        var request = URLRequest(url: url)
        
        // Add headers to the request
        for (key, value) in header {
            request.addValue(value, forHTTPHeaderField: key)
        }
        
        print("\(request)...")
        // Perform the network request
        let (data, response) = try await URLSession.shared.data(for: request)
        
        // Check the response status code
        guard (200 ... 299).contains((response as? HTTPURLResponse)?.statusCode ?? 500) else {
            throw NetworkError.badServerResponse
        }
        
        // Decode the JSON response into the expected type
        let result = try JSONDecoder().decode(T.self, from: data)
        
        print("\(result)...")
        return result
    }
    
    func delete(from urlString: String, header: [String: String] = [:], parameter: [String: Any] = [:]) async throws {
        // Create URLComponents to build the URL with query parameters
        guard var urlComponents = URLComponents(string: urlString) else {
            throw NetworkError.badURL
        }
        
        // Add query parameters
        if !parameter.isEmpty {
            urlComponents.queryItems = parameter.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        }
        
        // Construct the URL from the components
        guard let url = urlComponents.url else {
            throw NetworkError.badURL
        }
        
        // Create a URLRequest
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        // Add headers to the request
        for (key, value) in header {
            request.addValue(value, forHTTPHeaderField: key)
        }
        
        // Perform the network request
        print("before network request...")
        let (_, response) = try await URLSession.shared.data(for: request)
        
        // Check the response status code
        print("After network request...")
        guard (200 ... 299).contains((response as? HTTPURLResponse)?.statusCode ?? 500) else {
            throw NetworkError.badServerResponse
        }
        print("Come last")
    }
    
    func post<T: Codable, U: Codable>(from urlString: String, body: T, header: [String: String] = [:]) async throws -> U {
        // Create URL
        guard let url = URL(string: urlString) else {
            throw NetworkError.badURL
        }
        
        // Create a URLRequest
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        // request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Add headers to the request
        for (key, value) in header {
            request.addValue(value, forHTTPHeaderField: key)
        }
        
        // Encode the body
        // let jsonData = try JSONEncoder().encode(body)
        request.httpBody = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
        
        // print("\(request.httpBody).. after encoding")
        
        // Perform the network request
        let (data, response) = try await URLSession.shared.data(for: request)
        
        // Check the response status code
        guard (200 ... 299).contains((response as? HTTPURLResponse)?.statusCode ?? 500) else {
//            print("inside")
//            let result = try JSONDecoder().decode(U.self, from: data)
//            print("\(result)")
            
            throw NetworkError.badServerResponse
        }
        // print("outside")
        
        // Decode the JSON response into the expected type
        let result = try JSONDecoder().decode(U.self, from: data)
        print("\(result)..")
        return result
    }
    
    func put<T: Codable, U: Codable>(from urlString: String, body: T, header: [String: String] = [:]) async throws -> U {
        // Create URL
        guard let url = URL(string: urlString) else {
            throw NetworkError.badURL
        }
        
        // Create a URLRequest
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Add headers to the request
        for (key, value) in header {
            request.addValue(value, forHTTPHeaderField: key)
        }
        
        // Encode the body
        let jsonData = try JSONEncoder().encode(body)
        request.httpBody = jsonData
        
        // Perform the network request
        let (data, response) = try await URLSession.shared.data(for: request)
        
        // Check the response status code
        guard (200 ... 299).contains((response as? HTTPURLResponse)?.statusCode ?? 500) else {
            throw NetworkError.badServerResponse
        }
        
        // Decode the JSON response into the expected type
        let result = try JSONDecoder().decode(U.self, from: data)
        
        return result
    }
}
