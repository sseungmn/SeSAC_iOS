//
//  BoardViewModel.swift
//  SeSAC_WEEK14
//
//  Created by SEUNGMIN OH on 2021/12/29.
//

import Foundation

class BoardViewModel {
  let board: Observable<Board> = Observable([])
  
  func fetchBoard() {
    guard let token = UserDefaults.standard.string(forKey: "token") else {
      print("토큰이 존재하지 않습니다.")
      return
    }
    
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
