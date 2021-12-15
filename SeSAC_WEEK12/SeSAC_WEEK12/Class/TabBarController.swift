//
//  TabBarController.swift
//  
//
//  Created by SEUNGMIN OH on 2021/12/15.
//

import UIKit

// NavigationController, TabBarController
// TabBar, TabBarItem(title, imgae, selectImage), tintColor
// iOS 13 ~ : UITabBarAppearance (버전에 따른 분기 처리 필요)
class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstVC = SettingViewController(nibName: "SettingViewController", bundle: nil)
        firstVC.tabBarItem.title = "설정 화면"
        firstVC.tabBarItem.image = UIImage(systemName: "star")
        firstVC.tabBarItem.selectedImage = UIImage(systemName: "star.fill")
        
        let secondVC = SnapDetailViewController()
        secondVC.tabBarItem = UITabBarItem(title: "스냅킷", image: UIImage(systemName: "trash"), selectedImage: UIImage(systemName: "trash.fill"))
        let thirdVC = DetailViewController()
        thirdVC.tabBarItem = UITabBarItem(title: "디테일", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.circle"))
        
        setViewControllers([firstVC, secondVC, thirdVC], animated: true)
        
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()
        
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
        tabBar.tintColor = .black
    }
}
