//
//  ViewController.swift
//  RecommendTheBeer
//
//  Created by SEUNGMIN OH on 2021/12/23.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
  
  let viewModel = BeerAPIViewModel()

  let beerImageView = BeerImageView()
  let beerInfoView = BeerInfoView()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.addSubview(beerImageView)
    beerImageView.snp.makeConstraints { make in
      make.top.left.right.equalTo(view.safeAreaLayoutGuide)
      make.height.equalTo(220)
    }
    view.addSubview(beerInfoView)
    beerInfoView.snp.makeConstraints { make in
      make.left.right.equalToSuperview().inset(20)
      make.top.equalTo(view.safeAreaLayoutGuide).inset(170)
      make.height.equalTo(220)
    }
    
    viewModel.requestRandomBeer { [weak self] beer in
      guard let beer = beer else { return }
      // Set Info
      DispatchQueue.main.async {
        self?.beerInfoView.setInformation(beer)
      }
      
      // Set Image
      self?.viewModel.requestBeerImage(beer: beer, completion: { image in
        guard let image = image else { return }
        DispatchQueue.main.async {
          self?.beerImageView.setImage(image)
        }
      })
    }
  }
}
