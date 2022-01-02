//
//  BoardViewController.swift
//  SeSACCommunity
//
//  Created by SEUNGMIN OH on 2022/01/03.
//

import UIKit

class BoardViewController: UIViewController {
  
  let mainView = BoardView()
  var board = [Post]()
  
  override func loadView() {
    view = mainView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    mainView.setDelegate(self)
    APIService.requestPostRead { board, error in
      guard let board = board else {
        return
      }
      self.board = board
      print(board)
      DispatchQueue.main.async {
        self.mainView.tableView.reloadData()
      }
    }
  }
}

extension BoardViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return board.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = mainView.tableView.dequeueReusableCell(withIdentifier: "post", for: indexPath) as? PostView else { return UITableViewCell() }
    cell.bodyLabel.text = board[indexPath.row].text
    cell.userNameLabel.text = board[indexPath.row].user.username
    cell.dateLabel.text = board[indexPath.row].updatedAt
    return cell
  }
}
