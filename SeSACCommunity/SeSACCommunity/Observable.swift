//
//  Observable.swift
//  SeSACCommunity
//
//  Created by SEUNGMIN OH on 2022/01/01.
//

import Foundation

class Observable<Element> {
  typealias Listener = (Element) -> Void
  private var listener: Listener?
  
  var value: Element {
    didSet {
      listener?(value)
    }
  }
  
  init(_ value: Element) {
    self.value = value
  }
  
  func bind(_ listener: @escaping Listener) {
    self.listener = listener
  }
}
