//
//  APIService.swift
//  SeSAC_WEEK14
//
//  Created by SEUNGMIN OH on 2021/12/28.
//

import Foundation

enum APIError: Error {
  case invalidResponse, noData, failed, invalidData
}

class APIService {
  static func login(identifier: String, password: String, completion: @escaping (User?, APIError?) -> Void) {
    let url = URL(string: "http://test.monocoding.com/auth/local")!
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    // String -> Data, dictionary -> JsonSerialization / Codable
    request.httpBody = "identifier=\(identifier)&password=\(password)".data(using: .utf8, allowLossyConversion: false)
    
    URLSession.shared.dataTask(with: request) { data, response, error in
      guard error == nil else {
        completion(nil, .failed)
        return
      }
      
      guard let data = data else {
        completion(nil, .noData)
        return
      }
      
      guard let response = response as? HTTPURLResponse else {
        completion(nil, .invalidResponse)
        return
      }
      
      guard response.statusCode == 200 else {
        completion(nil, .failed)
        return
      }
      
      do {
        let userData = try JSONDecoder().decode(User.self, from: data)
        completion(userData, nil)
      } catch {
        completion(nil, .invalidData)
      }
    }.resume()
  }
}
