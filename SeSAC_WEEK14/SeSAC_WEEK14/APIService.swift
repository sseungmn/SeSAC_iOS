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
  static func register(username: String, email: String, password: String, completion: @escaping (User?, APIError?) -> Void) {
    
    var request = URLRequest(url: Endpoint.signup.url)
    request.httpMethod = "POST"
    request.httpBody = "username=\(username)&email=\(email)&password=\(password)".data(using: .utf8, allowLossyConversion: false)
    
    URLSession.request(endpoint: request, completion: completion)
  }
  
  static func login(identifier: String, password: String, completion: @escaping (User?, APIError?) -> Void) {
    
    var request = URLRequest(url: Endpoint.login.url)
    request.httpMethod = "POST"
    // String -> Data, dictionary -> JsonSerialization / Codable
    request.httpBody = "identifier=\(identifier)&password=\(password)".data(using: .utf8, allowLossyConversion: false)
    URLSession.request(.shared, endpoint: request, completion: completion)
  }
  
  static func board(token: String, completion: @escaping (Board?, APIError?) -> Void) {
    
    var request = URLRequest(url: Endpoint.boards.url)
    request.httpMethod = "GET"
    // String -> Data, dictionary -> JsonSerialization / Codable
    request.setValue("bearer \(token)", forHTTPHeaderField: "authorization")
    
    URLSession.request(endpoint: request, completion: completion)
  }
  
  static func lotto(_ number: Int, completion: @escaping (Lotto?, APIError?) -> Void) {
    let url = URL(string: "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(number)")!
    
    URLSession.shared.dataTask(with: url) { data, response, error in
      DispatchQueue.main.async {
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
          let userData = try JSONDecoder().decode(Lotto.self, from: data)
          completion(userData, nil)
        } catch {
          completion(nil, .invalidData)
        }
      }
    }.resume()
  }
  
  static func person(_ text: String, page: Int, completion: @escaping (Person?, APIError?) -> Void) {
    let scheme = "https"
    let host = "api.themoviedb.org"
    let path = "/3/search/person"
    
    let key = "3b81b8174adb8e3a51b52e4a6997af2b"
    let language = "ko-KR"
    let query = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    
    var component = URLComponents()
    component.scheme = scheme
    component.host = host
    component.path = path
    component.queryItems = [
      URLQueryItem(name: "api_key", value: key),
      URLQueryItem(name: "query", value: query),
      URLQueryItem(name: "page", value: "\(page)"),
      URLQueryItem(name: "language", value: language)
    ]
    let request = URLRequest(url: component.url!)
    
    URLSession.request(endpoint: request, completion: completion)
  }
}
