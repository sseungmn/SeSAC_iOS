//
//  ViewController.swift
//  RecommendTheBeer
//
//  Created by SEUNGMIN OH on 2021/12/23.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
  
  let viewModel = BeerViewModel()
  
  let beerImageView = BeerImageView()
  let beerInfoView = BeerInfoView()
  
  let tableView = BeerTableView()
  let bottomView = BottomView()
  
  // layout constant
  let horizontalInset = 20
  let imageViewDefaultHeight = 220
  let imageViewMoreHeight = 300
  let bottomViewHeight = 60
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setConstraints()
    configuration()
    viewModel.fetchBeerInfo()
  }
  
  func configuration() {
    view.backgroundColor = .white
    
    bindObservable()
    tableView.setDelegate(self)
    setActions()
  }
  
  func setConstraints() {
    view.addSubview(beerImageView)
    beerImageView.snp.makeConstraints { make in
      make.top.left.right.equalTo(view.safeAreaLayoutGuide)
      make.height.equalTo(self.imageViewDefaultHeight)
    }
    view.addSubview(beerInfoView)
    beerInfoView.snp.makeConstraints { make in
      make.left.right.equalToSuperview().inset(self.horizontalInset)
      make.top.equalTo(beerImageView.snp.bottom).offset(-50)
    }
    
    view.addSubview(bottomView)
    bottomView.snp.makeConstraints { make in
      make.left.right.equalToSuperview()
      make.bottom.equalTo(view.safeAreaLayoutGuide)
      make.height.equalTo(self.bottomViewHeight)
    }
    
    view.addSubview(tableView)
    tableView.snp.makeConstraints { make in
      make.top.equalTo(beerInfoView.snp.bottom)
      make.left.right.equalToSuperview().inset(self.horizontalInset)
      make.bottom.equalTo(bottomView.snp.top)
    }
    
  }
  func resetContraints() {
    beerImageView.snp.updateConstraints { make in
      make.height.equalTo(self.imageViewDefaultHeight)
    }
    self.beerInfoView.moreAction()
  }
  
  func bindObservable() {
    viewModel.beer.bind({ [weak self] beer in
      guard let beer = beer else { return }
      DispatchQueue.main.async {
        self?.beerInfoView.setInformation(beer)
        self?.tableView.reloadData()
      }
    })
    viewModel.beerImage.bind({ [weak self] image in
      guard let image = image else { return }
      DispatchQueue.main.async {
        self?.beerImageView.setImage(image)
      }
    })
  }
  
  func setActions() {
    beerInfoView.setMoreAction { [weak self] _ in
      guard let self = self else { return }
      self.beerImageView.snp.updateConstraints { make in
        if self.beerImageView.isLarge {
          make.height.equalTo(self.imageViewDefaultHeight)
        } else {
          make.height.equalTo(self.imageViewMoreHeight)
        }
        self.beerImageView.isLarge.toggle()
      }
      self.beerInfoView.moreAction()
    }
    
    bottomView.setRefreshButtonAction { [weak self] _ in
      self?.viewModel.fetchBeerInfo()
      self?.resetContraints()
      self?.beerInfoView.defaultDescription()
      self?.beerImageView.isLarge = false
    }
  }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.numberOfRowsInSection
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(
      withIdentifier: BeerTableViewCell.reuseIdentifier)
            as? BeerTableViewCell else { return UITableViewCell() }
    cell.title.text = viewModel.cellForRowAt(indexPath)
    return cell
  }
}
