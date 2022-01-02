//
//  UIViewController+Extension.swift
//  SeSACCommunity
//
//  Created by SEUNGMIN OH on 2022/01/03.
//

import UIKit

extension UIViewController {
  func makeRootViewController(_ vc: UIViewController) {
    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
    windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: vc)
    windowScene.windows.first?.makeKeyAndVisible()
  }
}
