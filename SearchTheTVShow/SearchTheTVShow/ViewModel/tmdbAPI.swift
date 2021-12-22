//
//  SearchAPI.swift
//  SearchTheTVShow
//
//  Created by SEUNGMIN OH on 2021/12/21.
//

import UIKit

class tmdbAPI {
    private var params: [String: Any] = [
        "api_key": Bundle.main.tmdb,
        "language": "en"
    ]
    
    func request<Model: Codable>(url: URL, completion: @escaping (Model?) -> Void) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("ERROR")
                return
            }
            
            if let data = data, let castData = try? JSONDecoder().decode(Model.self, from: data) {
                completion(castData)
            }
        }.resume()
    }
    
    func requestTVShow(query: String, completion: @escaping (TVShow?) -> Void) {
        
        params["query"] = query
        let requestURL = makeRequestURL(baseURL: "https://api.themoviedb.org/3/search/tv",
                                        params: params)
        request(url: requestURL, completion: completion)
    }
    
    func requestTVShowDetail(id: Int, completion: @escaping (TVShowDetail?) -> Void) {
        
        params["tv_Id"] = id
        let requestURL = makeRequestURL(baseURL: "https://api.themoviedb.org/3/tv",
                                        params: params)
        request(url: requestURL, completion: completion)
    }
    
    func makeRequestURL(baseURL: String, params: [String: Any]) -> URL {
        
        var urlString = baseURL
        for (index, param) in params.enumerated() {
            let prefix = index == 0 ? "?" : "&"
            urlString += "\(prefix)\(param.key)=\(param.value)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        }
        return URL(string: urlString)!
    }
}
