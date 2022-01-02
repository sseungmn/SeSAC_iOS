//
//  BaseView.swift
//  SeSACCommunity
//
//  Created by SEUNGMIN OH on 2022/01/01.
//

import UIKit
import SnapKit

class BaseView: UIView {
  static let titleSize: CGFloat = 20
  static let subtitleSize: CGFloat = 15
  static let textSize: CGFloat = 13
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .white
    configure()
    setConstraint()
  }
  
  required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
  
  func configure() {}
  
  func setConstraint() {}
}
