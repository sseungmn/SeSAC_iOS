//
//  ViewController.swift
//  SeSACCommunity
//
//  Created by SEUNGMIN OH on 2022/01/02.
//

import UIKit

class SignInViewController: UIViewController {
  
  let mainView = SignInView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(mainView)
    mainView.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide)
      make.right.left.equalToSuperview()
      make.height.equalTo(162)
    }
    mainView.confirmButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    view.backgroundColor = .white
    navigationItem.title = "새싹농장 가입하기"
  }
  
  @objc func buttonTapped(_ sender: UIButton) {
    guard let id = mainView.nickNameTextFeild.text else { return }
    guard let pw = mainView.passwordTextFeild.text else { return }
    APIService.requestSignIn(identifier: id, password: pw) { userData, error in
      guard error == nil else {
        print(error)
        return
      }
      guard let userData = userData else { return }
      UserDefaults.standard.set(userData.jwt, forKey: "token")
      UserDefaults.standard.set(userData.user.id, forKey: "id")
      UserDefaults.standard.set(userData.user.username, forKey: "username")
    }
  }

}
