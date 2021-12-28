//
//  BoardViewController.swift
//  SeSAC_WEEK14
//
//  Created by SEUNGMIN OH on 2021/12/29.
//

import UIKit
import SnapKit

class BoardViewController: UIViewController {
  
  let tableView = UITableView()
  let viewModel = BoardViewModel()
  private var token: String?
  
  convenience init(token: String) {
    self.init()
    self.token = token
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(tableView)
    tableView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    tableView.register(BoardTableViewCell.self, forCellReuseIdentifier: "cell")
    tableView.delegate = self
    tableView.dataSource = self
    
    viewModel.fetchBoard(token!)
    viewModel.board.bind { Board in
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    }
  }
}

extension BoardViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.numberOfRowInSection
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? BoardTableViewCell else { return UITableViewCell() }
    let post = viewModel.cellForRowAt(at: indexPath)
    cell.postIdLabel.text = "\(post.id)"
    cell.postTextLabel.text = post.text
    cell.authorIdLabel.text = "\(post.usersPermissionsUser.id)"
    cell.authorNameLabel.text = post.usersPermissionsUser.username
    cell.authorEmailLabel.text = post.usersPermissionsUser.email
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 60
  }
  
  
}
