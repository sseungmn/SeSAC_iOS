//
//  SignUpView.swift
//  SeSAC_WEEK14
//
//  Created by SEUNGMIN OH on 2021/12/28.
//

import UIKit

class SignUpView: UIView, ViewRepresentable {
  let usernameTextField = UITextField()
  let emailTextField = UITextField()
  let passwordTextField = UITextField()
  let signInButton = UIButton()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
    setupContraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupView() {
    addSubview(usernameTextField)
    usernameTextField.backgroundColor = .white
    addSubview(emailTextField)
    emailTextField.backgroundColor = .white
    addSubview(passwordTextField)
    passwordTextField.backgroundColor = .white
    addSubview(signInButton)
    signInButton.backgroundColor = .orange
  }
  
  func setupContraints() {
    usernameTextField.snp.makeConstraints { make in
      make.center.equalToSuperview()
      make.width.equalTo(self.snp.width).multipliedBy(0.9)
      make.height.equalTo(50)
    }
    emailTextField.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalTo(usernameTextField.snp.bottom).offset(20)
      make.width.equalTo(self.snp.width).multipliedBy(0.9)
      make.height.equalTo(50)
    }
    passwordTextField.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalTo(emailTextField.snp.bottom).offset(20)
      make.width.equalTo(self.snp.width).multipliedBy(0.9)
      make.height.equalTo(50)
    }
    signInButton.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalTo(passwordTextField.snp.bottom).offset(20)
      make.width.equalTo(self.snp.width).multipliedBy(0.9)
      make.height.equalTo(50)
    }
  }
}
