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
    setConstraints()
    configuration()
    fetchBeerInfo()
  }
  
  func configuration() {
    view.backgroundColor = .darkGray
    beerInfoView.setMoreAction { [weak self] action in
      self?.beerImageView.snp.updateConstraints { make in
        make.height.equalTo(350)
      }
      self?.beerInfoView.moreAction()
    }
  }
  
  func setConstraints() {
    view.addSubview(beerImageView)
    beerImageView.snp.makeConstraints { make in
      make.top.left.right.equalTo(view.safeAreaLayoutGuide)
      make.height.equalTo(220)
    }
    view.addSubview(beerInfoView)
    beerInfoView.snp.makeConstraints { make in
      make.left.right.equalToSuperview().inset(20)
      make.top.equalTo(beerImageView.snp.bottom).offset(-50)
    }
    
  }
  
  func fetchBeerInfo() {
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
