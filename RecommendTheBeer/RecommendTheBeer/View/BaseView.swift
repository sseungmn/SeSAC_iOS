//
//  BaseView.swift
//  RecommendTheBeer
//
//  Created by SEUNGMIN OH on 2021/12/24.
//

import UIKit

class BaseView: UIView {
  override init(frame: CGRect) {
    super.init(frame: frame)
    setContraints()
    setConfiguration()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setConfiguration() {}
  
  func setContraints() {}
}
