//
//  MainViewController.swift
//  SeSAC_WEEK14
//
//  Created by SEUNGMIN OH on 2021/12/28.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
  let idLabel = UILabel()
  let usernameLabel = UILabel()
  let emailLabel = UILabel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    idLabel.text = UserDefaults.standard.string(forKey: "id")
    usernameLabel.text = UserDefaults.standard.string(forKey: "nickname")
    emailLabel.text = UserDefaults.standard.string(forKey: "email")
    [idLabel, usernameLabel, emailLabel].forEach { label in
      label.textColor = .black
      label.font = .systemFont(ofSize: 20, weight: .bold)
    }
    emailLabel.textColor = .black
    
    setContraints()
  }
  
  func setContraints() {
    view.addSubview(idLabel)
    idLabel.snp.makeConstraints { make in
      make.center.equalToSuperview()
    }
    view.addSubview(usernameLabel)
    usernameLabel.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalTo(idLabel.snp.bottom).offset(20)
    }
    view.addSubview(emailLabel)
    emailLabel.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalTo(usernameLabel.snp.bottom).offset(20)
    }
  }
}
