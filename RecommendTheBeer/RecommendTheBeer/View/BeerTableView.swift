//
//  BeerTableView.swift
//  RecommendTheBeer
//
//  Created by SEUNGMIN OH on 2021/12/30.
//

import UIKit

class BeerTableView: BaseView {
  let headerView = UIView()
  let titleLabel: UILabel = {
    let label = UILabel()
    label.textColor = .black
    label.font = .boldSystemFont(ofSize: 23)
    label.text = "Food - Paring"
    return label
  }()
  let tableView: UITableView = {
    let tableView = UITableView()
    tableView.backgroundColor = nil
    tableView.separatorStyle = .none
    return tableView
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setConfiguration()
    setContraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func reloadData() {
    tableView.reloadData()
  }
  
  func setDelegate<ViewController: UITableViewDelegate & UITableViewDataSource>(_ viewController: ViewController) {
    tableView.delegate = viewController
    tableView.dataSource = viewController
  }
  
  override func setConfiguration() {
    tableView.register(BeerTableViewCell.self, forCellReuseIdentifier: BeerTableViewCell.reuseIdentifier)
  }
  
  override func setContraints() {
    addSubview(headerView)
    headerView.snp.makeConstraints { make in
      make.top.equalToSuperview().inset(10)
      make.left.right.equalToSuperview()
      make.height.equalTo(30)
    }
    headerView.addSubview(titleLabel)
    titleLabel.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    addSubview(tableView)
    tableView.snp.makeConstraints { make in
      make.top.equalTo(headerView.snp.bottom)
      make.left.right.bottom.equalToSuperview()
    }
  }
}
