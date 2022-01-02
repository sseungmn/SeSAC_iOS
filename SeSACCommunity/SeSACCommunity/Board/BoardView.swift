//
//  BoardView.swift
//  SeSACCommunity
//
//  Created by SEUNGMIN OH on 2022/01/03.
//

import UIKit

class BoardView: BaseView {
  var tableView: UITableView = {
    let tableView = UITableView()
    tableView.separatorStyle = .none
    return tableView
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  func setDelegate<ViewController: UITableViewDelegate & UITableViewDataSource>(_ vc: ViewController) {
    tableView.delegate = vc
    tableView.dataSource = vc
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func configure() {
    tableView.register(PostView.self, forCellReuseIdentifier: "post")
  }
  
  override func setConstraint() {
    addSubview(tableView)
    tableView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
}
