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
    
    viewModel.userName.bind { text in
      self.mainView.usernameTextField.text = text
    }
    
    viewModel.password.bind { text in
      self.mainView.passwordTextField.text = text
    }
    
    mainView.usernameTextField.addTarget(self, action: #selector(userNameTextFieldDidChange), for: .editingChanged)
    mainView.passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidChange), for: .editingChanged)
    
    mainView.signInButton.addTarget(self, action: #selector(signInButtonClicked), for: .touchUpInside)
  }
  
  @objc func userNameTextFieldDidChange(_ textField: UITextField) {
    viewModel.userName.value = textField.text ?? ""
  }
  
  @objc func passwordTextFieldDidChange(_ textField: UITextField) {
    viewModel.password.value = textField.text ?? ""
  }
  
  @objc func signInButtonClicked() {
    viewModel.postUserLogin {
      DispatchQueue.main.async {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: MainViewController())
        windowScene.windows.first?.makeKeyAndVisible()
      }
      
    }
    
  }
  
}

