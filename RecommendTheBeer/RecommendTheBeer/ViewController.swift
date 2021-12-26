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
  let tableView: UITableView = {
    let tableView = UITableView()
    tableView.contentOffset = .zero
    tableView.contentInset = .zero
    return tableView
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    setConstraints()
    configuration()
    fetchBeerInfo()
  }
  
  func configuration() {
    view.backgroundColor = .white
    beerInfoView.setMoreAction { [weak self] _ in
      self?.beerImageView.snp.updateConstraints { make in
        make.height.equalTo(350)
      }
      self?.beerInfoView.moreAction()
    }
    
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(BeerTableViewCell.self, forCellReuseIdentifier: BeerTableViewCell.reuseIdentifier)
    tableView.backgroundColor = nil
    tableView.separatorStyle = .none
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
    view.addSubview(tableView)
    tableView.snp.makeConstraints { make in
      make.top.equalTo(beerInfoView.snp.bottom)
      make.left.right.equalToSuperview().inset(20)
      make.bottom.equalTo(view.safeAreaLayoutGuide)
    }
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
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let titleLabel: UILabel = {
      let label = UILabel()
      label.textColor = .black
      label.font = .boldSystemFont(ofSize: 23)
      label.text = "Food - Paring"
      return label
    }()
    let headerView: UIView = {
      let view = UIView()
      view.backgroundColor = nil
      return view
    }()
    
    headerView.addSubview(titleLabel)
    titleLabel.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    
    return headerView
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 50
  }
}
