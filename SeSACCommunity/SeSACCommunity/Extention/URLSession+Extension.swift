//
//  URLSession+Extension.swift
//  SeSACCommunity
//
//  Created by SEUNGMIN OH on 2022/01/02.
//

import UIKit

extension URLSession {
  
  static func request<Model: Decodable>(_ session: URLSession = .shared, endpoint: URLRequest, completion: @escaping (Model?, APIError?) -> Void) {
    session.dataTask(with: endpoint) { data, response, error in
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
        switch response.statusCode {
        case 400:
          completion(nil, .invalidRequest)
        case 401:
          completion(nil, .tokenExpired)
        case 500...599:
          completion(nil, .serverError)
        default:
          completion(nil, .failed)
        }
        return
      }
      
      do {
        let userData = try JSONDecoder().decode(Model.self, from: data)
        completion(userData, nil)
      } catch {
        completion(nil, .invalidData)
      }
      
    }.resume()
  }
}
