//
//  Endpoint.swift
//  SeSAC_WEEK14
//
//  Created by SEUNGMIN OH on 2021/12/29.
//

import Foundation

enum Endpoint {
  case signup
  case login
  case boards
  case boardDetail(id: Int)
}

// 1번째 방법 ( 유지보수, 확장에 쉽다 )
extension Endpoint {
  var url: URL {
    switch self {
    case .signup: return .makeEndpoint("auth/local/register")
    case .login: return .makeEndpoint("auth/local")
    case .boards: return .makeEndpoint("boards")
    case .boardDetail(id: let id): return .makeEndpoint("board/\(id)")
    }
  }
}

extension URL {
  static let baseURL = "http://test.monocoding.com/"
  
  static func makeEndpoint(_ endpoint: String) -> URL {
    URL(string: baseURL + endpoint)!
  }
}

extension URLSession {
  typealias Handler = (Data?, URLResponse?, Error?) -> Void
  
  //  @discardableResult
  func dataTask(_ endpoint: URLRequest, handler: @escaping Handler) -> URLSessionDataTask {
    let task = dataTask(with: endpoint, completionHandler: handler)
    task.resume()
    return task
  }
  
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
        completion(nil, .failed)
        return
      }
      
      do {
        let userData = try JSONDecoder().decode(Model.self, from: data)
        completion(userData, nil)
      } catch {
        completion(nil, .invalidData)
      }
    }
  }
}
