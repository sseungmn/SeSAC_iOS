//
//  ViewController.swift
//  SeSACCommunity
//
//  Created by SEUNGMIN OH on 2022/01/02.
//

import UIKit

class SignUpViewController: UIViewController {
  
  let mainView = SignUpView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(mainView)
    mainView.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide)
      make.right.left.equalToSuperview()
      make.height.equalTo(274)
    }
    view.backgroundColor = .white
    navigationItem.title = "새싹농장 가입하기"
  }

}
