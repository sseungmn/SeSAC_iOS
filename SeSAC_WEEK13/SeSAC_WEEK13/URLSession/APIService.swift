//
//  APIService.swift
//  SeSAC_WEEK13
//
//  Created by SEUNGMIN OH on 2021/12/21.
//

import Foundation
import UIKit

enum APIError: String, Error {
    case unknownError = "alert_error_unknown"
    case serverError = "alert_error_server"
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}

class APIService {
    let sourceURL = URL(string: "http://kobis.or.kr/kobisopenapi/webservice/rest/people/searchPeopleList.json?key=f5eef3421c602c6cb7ea224104795888")!
    
    func requestCast(completion: @escaping (Cast?) -> Void) {
        URLSession.shared.dataTask(with: sourceURL) { data, response, error in
            if let error = error {
                print(error)
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("ERROR")
                return
            }
            
            if let data = data, let castData = try? JSONDecoder().decode(Cast.self, from: data) {
                completion(castData)
                return
            }
            
            completion(nil)
        }.resume()
    }
    
    func showAlert(_ msg: APIError) {
    }
}
