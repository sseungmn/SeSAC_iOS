//
//  BaseViewController.swift
//  SeSAC_WEEK13
//
//  Created by SEUNGMIN OH on 2021/12/22.
//

import UIKit
import SnapKit

// 뷰컨마다 중복되는 메서드들을 한곳에 정리하자
// UI 같은거
class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        configure()
        setupConstraints()
    }
    
    func configure() {
        view.backgroundColor = .white
    }
    
    func setupConstraints() {
        
    }
    
}
