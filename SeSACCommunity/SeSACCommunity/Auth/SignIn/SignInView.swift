//
//  SignUpView.swift
//  SeSACCommunity
//
//  Created by SEUNGMIN OH on 2022/01/02.
//

import UIKit

class SignInView: BaseView {
  
  let fieldTitles = ["닉네임", "비밀번호"]
  var VStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.spacing = 8
    return stackView
  }()
  var nickNameTextFeild = CustomTextField()
  var passwordTextFeild = CustomTextField()
  var confirmButton: CustomButton = {
    let button = CustomButton()
    button.setTitle("로그인", for: .normal)
    return button
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func configure() {
    for (index, textField) in [nickNameTextFeild, passwordTextFeild].enumerated() {
      textField.placeholder = fieldTitles[index]
    }
  }
  
  override func setConstraint() {
    addSubview(VStackView)
    VStackView.addArrangedSubview(nickNameTextFeild)
    VStackView.addArrangedSubview(passwordTextFeild)
    VStackView.addArrangedSubview(confirmButton)
    VStackView.snp.makeConstraints { make in
      make.left.right.equalToSuperview().inset(20)
      make.top.equalToSuperview().inset(20)
    }
  }
}
