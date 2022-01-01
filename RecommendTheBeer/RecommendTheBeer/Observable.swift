//
//  Observable.swift
//  RecommendTheBeer
//
//  Created by SEUNGMIN OH on 2021/12/30.
//

import Foundation

class Observable<Element> {
  typealias Listener = ( (Element?) -> Void )
  private var listener: Listener?
  
  var value: Element? {
    didSet {
      listener?(value)
    }
  }
  
  init(_ value: Element) {
    self.value = value
  }
  
  init() {
    self.value = nil
  }
  
  func bind(_ completion: @escaping Listener) {
    listener = completion
  }
}
