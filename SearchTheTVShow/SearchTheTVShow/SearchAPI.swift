//
//  SearchAPI.swift
//  SearchTheTVShow
//
//  Created by SEUNGMIN OH on 2021/12/21.
//

import UIKit

class SearchAPI {
    private let key = Bundle.main.tmdb
    
    let baseURLString = "https://api.themoviedb.org/3/search/tv"
    
    func requestTVShow(query: String, completion: @escaping (TVShow?) -> Void) {
        let params: [String: Any] = [
            "api_key": key,
//            "language": "ko",
            "query": query
        ]
        
        var urlString = baseURLString
        for (index, param) in params.enumerated() {
            let prefix = index == 0 ? "?" : "&"
            urlString += "\(prefix)\(param.key)=\(param.value)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        }
        let url = URL(string: urlString)!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("ERROR")
                return
            }
            
            if let data = data, let castData = try? JSONDecoder().decode(TVShow.self, from: data) {
                completion(castData)
            }
        }.resume()
    }
}
