//
//  BeerAPI.swift
//  RecommendTheBeer
//
//  Created by SEUNGMIN OH on 2021/12/24.
//

import UIKit
import Alamofire

class BeerAPIService {
  
  static func requestRandomBeer(completion: @escaping (Beer?) -> Void) {
    let baseURL = URL(string: "https://api.punkapi.com/v2/beers/random")!
    AF.request(baseURL).response { response in
      if let error = response.error {
        print("Request Error : ", error)
        return
      }
      guard let data = response.data else {
        print("Data Error")
        return
      }
      guard let decodedData = try? JSONDecoder().decode(BeerArray.self, from: data) else {
        print("Decode Error")
        return
      }
      guard let beer = decodedData.first else { return }
      
      completion(beer)
    }
  }
  
  static func requestBeerImage(beer: Beer, completion: @escaping (UIImage?) -> Void) {
    guard let imageURLString = beer.imageURL,
       let imageURL = URL(string: imageURLString) else {
         print("Image URL Error")
         return
    }
    
    AF.request(imageURL).response { response in
      if let error = response.error {
        print("Image Request Error : ", error)
        return
      }
      guard let data = response.data else {
        print("Image Data Error")
        completion(nil)
        return
      }
      guard let image = UIImage(data: data) else {
        print("Data convert to Image Error")
        completion(nil)
        return
      }
      
      completion(image)
    }
  }
}
