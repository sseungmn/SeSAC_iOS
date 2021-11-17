//
//  HomeViewController.swift
//  SeSAC_WEEK06
//
//  Created by OHSEUNGMIN on 2021/11/01.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let array = [
        Array(repeating: "a", count: 20),
        Array(repeating: "b", count: 10),
        Array(repeating: "c", count: 15),
        Array(repeating: "d", count: 13),
        Array(repeating: "e", count: 18),
        Array(repeating: "f", count: 8),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
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

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        
        cell.data = array[indexPath.row] // cell에 array data를 넘겨준다.
        cell.collectionView.tag = indexPath.row
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 1 ? 300 : 170
    }
    
}

