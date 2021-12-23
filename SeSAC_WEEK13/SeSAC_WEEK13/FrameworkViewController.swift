//
//  FrameworkViewController.swift
//  SeSAC_WEEK13
//
//  Created by SEUNGMIN OH on 2021/12/23.
//

import SeSACFramework
import UIKit

class FrameworkViewController: SeSACOpen {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let sesac = SeSACOpen()
        sesac.presentWebViewController(url: "https://naver.com", trainsitionStyle: .push, vc: self)
    }
}
