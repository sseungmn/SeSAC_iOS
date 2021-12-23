//
//  BeerAPI.swift
//  RecommendTheBeer
//
//  Created by SEUNGMIN OH on 2021/12/24.
//

import UIKit
import Alamofire

class BeerAPIViewModel {
  
  func requestRandomBeer(completion: @escaping (UIImage?) -> Void) {
    let baseURL = URL(string: "https://api.punkapi.com/v2/beers/random")!
    AF.request(baseURL).response { [weak self] response in
      guard let data = response.data else {
        print("Data Error")
        return
      }
      guard let decodedData = try? JSONDecoder().decode(Beer.self, from: data) else {
        print("Decode Error")
        return
      }
      guard let beer = decodedData.first else { return }
      
      if let imageURLString = beer.imageURL,
         let imageURL = URL(string: imageURLString) {
        self?.requestBeerImage(url: imageURL, completion: completion)
      }
    }
  }
  
  func requestBeerImage(url: URL, completion: @escaping (UIImage?) -> Void) {
    AF.request(url).response { response in
      if let error = response.error {
        print("Request Error : ", error)
        return
      }
      guard let data = response.data else {
        print("Data Error")
        completion(nil)
        return
      }
      guard let image = UIImage(data: data) else {
        print("Image Error")
        completion(nil)
        return
      }
      
      completion(image)
    }
  }
}
