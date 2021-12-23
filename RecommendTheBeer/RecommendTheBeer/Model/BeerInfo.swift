//
//  BeerInfo.swift
//  RecommendTheBeer
//
//  Created by SEUNGMIN OH on 2021/12/23.
//

import Foundation

typealias BeerArray = [Beer]

// MARK: - BeerInfo
struct Beer: Codable {
  let id: Int
  let name, tagline: String
  let beerDescription: String
  let imageURL: String?
  let foodPairing: [String]
  let brewersTips: String

  enum CodingKeys: String, CodingKey {
    case id
    case name, tagline
    case beerDescription = "description"
    case imageURL = "image_url"
    case foodPairing = "food_pairing"
    case brewersTips = "brewers_tips"
  }
}
