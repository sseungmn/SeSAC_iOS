//
//  HomeViewController.swift
//  SeSAC_WEEK06
//
//  Created by OHSEUNGMIN on 2021/11/01.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let downcastStrings = self.tabBarController?.tabBar.items {
            downcastStrings[0].title = "Home"
            downcastStrings[1].title = "Search"
            downcastStrings[2].title = "Calendar"
            downcastStrings[3].title = "Setting"
        }
        self.tabBarController?.tabBar.items![0].image = UIImage(systemName: "house")
        self.tabBarController?.tabBar.items![1].image = UIImage(systemName:  "magnifyingglass")
        self.tabBarController?.tabBar.items![2].image = UIImage(systemName: "calendar")
        self.tabBarController?.tabBar.items![3].image = UIImage(systemName: "person.circle")
    }
    
    @IBAction func addButtonClicked(_ sender: UIBarButtonItem) {
        // 1. 스토리보드 특정
        let sb = UIStoryboard(name: "Content", bundle: nil)
        
        // 2. 스토리보드 내 여러 뷰컨트롤러 중 전환하고 싶은 뷰컨트롤러 가져오기
        let vc = sb.instantiateViewController(withIdentifier: "AddViewController") as! AddViewController
        
        let nav = UINavigationController(rootViewController: vc)
        
        nav.modalPresentationStyle = .fullScreen
        
        // 3. 화면 전환 방법을 선택해서 present
        present(nav, animated: true, completion: nil)
    }
}
