//
//  APIService.swift
//  SeSACCommunity
//
//  Created by SEUNGMIN OH on 2022/01/02.
//

import Foundation
enum APIError: Error {
  case failed, noData, invalidResponse, serverError, tokenExpired, invalidRequest, invalidData
}

enum APIRequest {
  enum Method: String {
    case GET, POST, PUT
    case DEL = "DELETE"
  }
  
  case SignUp(username: String, email: String, password: String)
  case SignIn(identifier: String, password: String)
  case ChangePassword(currentPassword: String, newPassword: String, confirmNewPassword: String)
  //  case CreatePost(text: String, Authorization: String)
  //  case ReadPost(Authorization: String)
  //  case UpdatePost(postId: String, text: String)
  //  case DeletePost(postId: String, Authorization: String)
  //  case CreateComment, ReadComment, UpdateComment, DeleteComment
  
  func URLReqeust() -> URLRequest {
    switch self {
    case .SignUp(let username, let email, let password):
      var request = URLRequest(url: url)
      request.httpBody = "username=\(username)&email=\(email)&password=\(password)".data(using: .utf8, allowLossyConversion: false)
      request.httpMethod = Method.POST.rawValue
      return request
      
    case .SignIn(let identifier, let password):
      var request = URLRequest(url: url)
      request.httpMethod = Method.POST.rawValue
      request.httpBody = "identifier=\(identifier)&password\(password)".data(using: .utf8, allowLossyConversion: false)
      return request
      
    case .ChangePassword(let currentPassword, let newPassword, let confirmNewPassword):
      var request = URLRequest(url: url)
      request.httpMethod = Method.POST.rawValue
      request.httpBody = "currentPassword=\(currentPassword)&newPassword\(newPassword)&confirmNewPassword=\(confirmNewPassword)".data(using: .utf8, allowLossyConversion: false)
      request.addValue(token, forHTTPHeaderField: "Authorization")
      return request
      
      //    case .CreatePost(let text, let Authorization):
      //      return URLReqeust()
      //    case .ReadPost(let Authorization):
      //      return URLReqeust()
      //    case .UpdatePost(let postId, let text):
      //      return URLReqeust()
      //    case .DeletePost(let postId, let Authorization):
      //      return URLReqeust()
    }
  }
}

extension APIRequest {
  var url: URL {
    switch self {
    case .SignUp: return .endPoint("/auth/local/register")
    case .SignIn: return .endPoint("/auth/local")
    case .ChangePassword: return .endPoint("/custom/change-password")
    }
  }
  var token: String {
    return UserDefaults.standard.string(forKey: "token") ?? ""
  }
}

extension URL {
  static let baseURL = "http://test.monocoding.com:1231"
  
  static func endPoint(_ path: String) -> URL {
    return URL(string: baseURL + path)!
  }
}

class APIService {
  static func requestSignIn(identifier: String, password: String, _ completion: @escaping (AccessInfo?, APIError?) -> Void) {
    URLSession.request(endpoint: APIRequest.SignIn(identifier: identifier, password: password).URLReqeust(), completion: completion)
  }
}
