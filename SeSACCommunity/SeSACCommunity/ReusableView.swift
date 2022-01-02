//
//  CustomTextField.swift
//  SeSACCommunity
//
//  Created by SEUNGMIN OH on 2022/01/02.
//

import UIKit
import SnapKit

// MARK: CustomTextField
class CustomTextField: UITextField {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configure() {
    layer.borderWidth = 1.0
    layer.borderColor = UIColor.lightGray.cgColor
    layer.cornerRadius = 5.0
    
    tintColor = .lightGray
  }
  
  override func textRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.insetBy(dx: 13, dy: 13)
  }
  
  override func editingRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.insetBy(dx: 13, dy: 13)
  }
}

// MARK: CustomButton
class CustomButton: UIButton {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    titleLabel?.font = .boldSystemFont(ofSize: 20)
    setTitleColor(.white, for: .normal)
    backgroundColor = .themeColor
    layer.cornerRadius = 5.0
    snp.makeConstraints { make in
      make.height.equalTo(50)
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override var isSelected: Bool {
    get {
      super.isEnabled
    }
    set(newValue) {
      if newValue == true {
        backgroundColor = .themeColor
      } else {
        backgroundColor = .lightGray
      }
    }
  }
}
