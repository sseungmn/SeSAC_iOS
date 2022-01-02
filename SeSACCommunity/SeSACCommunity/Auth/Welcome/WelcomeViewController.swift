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
    view.backgroundColor = .white
    navigationItem.title = "새싹"
    let right = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(nextVC))
    right.image = UIImage(systemName: "arrow.right")
    navigationItem.rightBarButtonItem = right
    let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    navigationItem.backBarButtonItem = backButton
  }
  @objc func nextVC() {
    let vc = SignUpViewController()
    navigationController?.pushViewController(vc, animated: true)
    
  }

}
