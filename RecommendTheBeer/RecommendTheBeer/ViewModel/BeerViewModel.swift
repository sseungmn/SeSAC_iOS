//
//  BeerViewModel.swift
//  RecommendTheBeer
//
//  Created by SEUNGMIN OH on 2021/12/30.
//

import Foundation
import UIKit

class BeerViewModel {
  
  var beer = Observable<Beer>()
  var beerImage = Observable<UIImage>()
  
  func fetchBeerInfo() {
    BeerAPIService.requestRandomBeer { [weak self] beer in
      guard let beer = beer else { return }
      self?.beer.value = beer
      self?.fetchBeerImage(beer: beer)
    }
  }
  func fetchBeerImage(beer: Beer) {
    // Set Image
    BeerAPIService.requestBeerImage(beer: beer, completion: { [weak self] image in
      guard let image = image else { return }
      self?.beerImage.value = image
    })
  }
}

extension BeerViewModel {
  var numberOfRowsInSection: Int {
    return beer.value?.foodPairing.count ?? 0
  }
  func cellForRowAt(_ indexPath: IndexPath) -> String {
    return beer.value?.foodPairing[indexPath.row] ?? ""
  }
}
