//
//  BoardViewModel.swift
//  SeSAC_WEEK14
//
//  Created by SEUNGMIN OH on 2021/12/29.
//

import Foundation

class BoardViewModel {
  let board: Observable<Board> = Observable([])
  
  func fetchBoard(_ token: String) {
    APIService.board(token: token) { board, error in
      guard let board = board else {
        return
      }
      self.board.value = board
    }
  }
}

extension BoardViewModel {
  var numberOfRowInSection: Int {
    return board.value.count
  }
  
  func cellForRowAt(at indexPath: IndexPath) -> Post {
    return board.value[indexPath.row]
  }
}
