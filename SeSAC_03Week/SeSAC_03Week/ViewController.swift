//
//  ViewController.swift
//  SeSAC_03Week
//
//  Created by OHSEUNGMIN on 2021/10/12.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func memoButtonClicked(_ sender: UIButton) {
        
        // 1. 스토리보드 특정
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // 2. 스토리보드 내 많은 뷰컨트롤러 중 전환하고자 하는 뷰컨트롤러 가져오기
        let vc = storyboard.instantiateViewController(withIdentifier: "MemoTableViewController") as! MemoTableViewController
        
        // 2-1. 네비게이션 컨트롤러 임베드
        let nav = UINavigationController(rootViewController: vc)
        
        
        // (화면 전환 옵션) & vc가 아닌 nav
//        nav.modalTransitionStyle = .partialCurl
        nav.modalPresentationStyle = .fullScreen
        
        // 3. present (vc가 아닌 nav)
        self.present(nav, animated: true, completion:  nil)
    }
    
    @IBAction func BoxOfficeButtonClicked(_ sender: UIButton) {
        // 1. 스토리보드 특정
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // 2. 스토리보드 내 많은 뷰컨트롤러 중 전환하고자 하는 뷰컨트롤러 가져오기
        let vc = storyboard.instantiateViewController(withIdentifier: "BoxOfficeTableViewController") as! BoxOfficeTableViewController
        
        // 3. present
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

