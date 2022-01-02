//
//  ViewController.swift
//  SeSACCommunity
//
//  Created by SEUNGMIN OH on 2022/01/01.
//

import UIKit

class WelcomeViewController: UIViewController {
  
  let mainView = WelcomeView()

  override func loadView() {
    view = mainView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    navigationItem.backBarButtonItem = backButton
    mainView.startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
    mainView.fotterLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(loginLabelTapped)))
  }
  
  @objc func startButtonTapped() {
    makeRootViewController(SignUpViewController())
  }
  
  @objc private func loginLabelTapped(_ sender: UITapGestureRecognizer) {
    guard let text = mainView.fotterLabel.text else { return }
    let loginRange = (text as NSString).range(of: "로그인")
    
    if sender.didTapAttributedTextInLabel(label: mainView.fotterLabel, inRange: loginRange) {
      makeRootViewController(SignInViewController())
    }
  }
}
