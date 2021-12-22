//
//  SignViewController.swift
//  SeSAC_WEEK13
//
//  Created by SEUNGMIN OH on 2021/12/21.
//

import UIKit

class SignViewController: BaseViewController {
    
    var mainView = SignView()
    var viewModel = SignViewModel()
    
    //뷰컨의 루트뷰를 로드할 때 호출되는 메서드
    //새로운 뷰를 반환하려고 할 때 사용
    override func loadView() {
        self.view = mainView
    }
    
    //loadView 메서드 이후에 호출된다.
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind { text, color in
            self.mainView.passwordTextField.text = text
            self.mainView.passwordTextField.textColor = color
        }
    }
    
    override func configure() {
        title = viewModel.navigationTitle
        mainView.emailTextField.placeholder = "이메일 작성 바람"
        mainView.signButton.addTarget(self, action: #selector(signButtonClicked), for: .touchUpInside)
        mainView.signButton.setTitle(viewModel.buttonTitle, for: .normal)
    }
    
    override func setupConstraints() {
        
    }
    
    @objc
    func signButtonClicked() {
        print(#function)
        guard let text = mainView.emailTextField.text else { return }
        viewModel.text = text
        
    }
    
}
