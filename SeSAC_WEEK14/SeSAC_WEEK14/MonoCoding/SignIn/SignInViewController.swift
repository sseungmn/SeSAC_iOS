//
//  SignInViewController.swift
//  SeSAC_WEEK14
//
//  Created by SEUNGMIN OH on 2021/12/27.
//

import UIKit

class SignInViewController: UIViewController {
  
  let mainView = SignInView()
  let viewModel = SignInViewModel()
  
  override func loadView() {
    self.view = mainView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    viewModel.username.bind { text in
      self.mainView.usernameTextField.text = text
    }
    
    viewModel.password.bind { text in
      self.mainView.passwordTextField.text = text
    }
    
    mainView.usernameTextField.addTarget(self, action: #selector(userNameTextFieldDidChange), for: .editingChanged)
    mainView.passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidChange), for: .editingChanged)
    
    mainView.signInButton.addTarget(self, action: #selector(signInButtonClicked), for: .touchUpInside)
    
    viewModel.fetchUsername()
  }
  
  @objc func userNameTextFieldDidChange(_ textField: UITextField) {
    viewModel.username.value = textField.text ?? ""
  }
  
  @objc func passwordTextFieldDidChange(_ textField: UITextField) {
    viewModel.password.value = textField.text ?? ""
  }
  
  @objc func signInButtonClicked() {
    viewModel.postUserLogin { token in
      
      UserDefaults.standard.set(token, forKey: "token")
      
      DispatchQueue.main.async {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: BoardViewController())
        windowScene.windows.first?.makeKeyAndVisible()
      }
      
    }
    
  }
  
}

