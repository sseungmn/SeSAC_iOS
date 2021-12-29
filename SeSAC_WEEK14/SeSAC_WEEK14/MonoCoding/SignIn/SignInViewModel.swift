//
//  SingInViewModel.swift
//  SeSAC_WEEK14
//
//  Created by SEUNGMIN OH on 2021/12/28.
//

import Foundation

class SignInViewModel {
  var username: Observable<String> = Observable("minios")
  var password: Observable<String> = Observable("")
  
  func postUserLogin(completion: @escaping(String) -> Void) {
    APIService.login(identifier: username.value,
                     password: password.value) { userData, error in
      guard let userData = userData else {
        return
      }
      
      UserDefaults.standard.set(userData.jwt, forKey: "token")
      UserDefaults.standard.set(userData.user.username, forKey: "nickname")
      UserDefaults.standard.set(userData.user.id, forKey: "id")
      UserDefaults.standard.set(userData.user.email, forKey: "email")
      
      completion(userData.jwt)
    }
  }
  
  func fetchUsername() {
    username.value = UserDefaults.standard.string(forKey: "nickname") ?? ""
  }
}
