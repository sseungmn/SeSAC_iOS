//
//  SignUpViewController.swift
//  SeSAC_WEEK14
//
//  Created by SEUNGMIN OH on 2021/12/28.
//

import UIKit

class SignUpViewController: UIViewController {
  
  let mainView = SignUpView()
  override func loadView() {
    self.view = mainView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    mainView.signInButton.addTarget(self, action: #selector(signUpButtonClicked), for: .touchUpInside)
  }
  
  @objc func signUpButtonClicked() {
    APIService.register(
      username: mainView.usernameTextField.text!,
      email: mainView.emailTextField.text!,
      password: mainView.passwordTextField.text!) { userData, error in
        guard let userData = userData else {
          return
        }
        print(userData)
        UserDefaults.standard.set(userData.jwt, forKey: "token")
        UserDefaults.standard.set(userData.user.username, forKey: "nickname")
        UserDefaults.standard.set(userData.user.id, forKey: "id")
        UserDefaults.standard.set(userData.user.email, forKey: "email")
        
        DispatchQueue.main.async {
          guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
          windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: MainViewController())
          windowScene.windows.first?.makeKeyAndVisible()
        }
      }
  }
}
