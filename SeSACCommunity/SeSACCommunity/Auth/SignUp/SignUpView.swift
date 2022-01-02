//
//  SignUpView.swift
//  SeSACCommunity
//
//  Created by SEUNGMIN OH on 2022/01/02.
//

import UIKit

class SignUpView: BaseView {
  
  let fieldTitles = ["이메일 주소", "닉네임", "비밀번호", "비밀번호 확인"]
  var VStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.spacing = 8
    return stackView
  }()
  var emailTextFeild = CustomTextField()
  var nickNameTextFeild = CustomTextField()
  var passwordTextFeild = CustomTextField()
  var passwordCheckTextFeild = CustomTextField()
  var confirmButton: CustomButton = {
    let button = CustomButton()
    button.setTitle("가입하기", for: .disabled)
    button.setTitle("시작하기", for: .normal)
    return button
  }()
  
  @objc func toggled(_ sender: UIButton) {
    sender.isEnabled.toggle()
    print(sender.isEnabled)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func configure() {
    confirmButton.addTarget(self, action: #selector(toggled), for: .touchUpInside)
    for (index, textField) in [emailTextFeild, nickNameTextFeild, passwordTextFeild, passwordCheckTextFeild].enumerated() {
      textField.placeholder = fieldTitles[index]
    }
  }
  
  override func setConstraint() {
    addSubview(VStackView)
    VStackView.addArrangedSubview(emailTextFeild)
    VStackView.addArrangedSubview(nickNameTextFeild)
    VStackView.addArrangedSubview(passwordTextFeild)
    VStackView.addArrangedSubview(passwordCheckTextFeild)
    VStackView.addArrangedSubview(confirmButton)
    VStackView.snp.makeConstraints { make in
      make.left.right.equalToSuperview().inset(20)
      make.top.equalToSuperview().inset(20)
    }
  }
}
