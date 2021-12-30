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
  var beer: Beer?
  
  let beerImageView = BeerImageView()
  let beerInfoView = BeerInfoView()
  
  let tableView = BeerTableView()
  let bottomView = BottomView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setConstraints()
    configuration()
    fetchBeerInfo()
  }
  
  func configuration() {
    view.backgroundColor = .white
    
    tableView.setDelegate(self)
    setActions()
  }
  
  func setActions() {
    beerInfoView.setMoreAction { [weak self] _ in
      guard let beerImageView = self?.beerImageView else { return }
      guard let beerInfoView = self?.beerInfoView else { return }
      beerImageView.snp.updateConstraints { make in
        if beerImageView.isLarge {
          make.height.equalTo(220)
        } else {
          make.height.equalTo(300)
        }
        beerImageView.isLarge.toggle()
      }
      beerInfoView.moreAction()
    }
    
    bottomView.setResetButtonAction { [weak self] _ in
      self?.fetchBeerInfo()
      self?.resetContraints()
      self?.beerInfoView.defaultDescription()
      self?.beerImageView.isLarge = false
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
    
    view.addSubview(bottomView)
    bottomView.snp.makeConstraints { make in
      make.left.right.equalToSuperview()
      make.bottom.equalTo(view.safeAreaLayoutGuide)
      make.height.equalTo(60)
    }
    
    view.addSubview(tableView)
    tableView.snp.makeConstraints { make in
      make.top.equalTo(beerInfoView.snp.bottom)
      make.left.right.equalToSuperview().inset(20)
      make.bottom.equalTo(bottomView.snp.top)
    }
    
  }
  func resetContraints() {
    beerImageView.snp.updateConstraints { make in
      make.height.equalTo(220)
    }
    self.beerInfoView.moreAction()
  }
  
  func fetchBeerInfo() {
    viewModel.requestRandomBeer { [weak self] beer in
      guard let beer = beer else { return }
      self?.beer = beer
      // Set Info
      DispatchQueue.main.async {
        self?.tableView.reloadData()
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

extension ViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.beer?.foodPairing.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(
      withIdentifier: BeerTableViewCell.reuseIdentifier)
            as? BeerTableViewCell else { return UITableViewCell() }
    cell.title.text = self.beer?.foodPairing[indexPath.row]
    return cell
  }
}
