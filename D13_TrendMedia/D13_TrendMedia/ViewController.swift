//
//  ViewController.swift
//  D13_TrendMedia
//
//  Created by OHSEUNGMIN on 2021/10/19.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var mediaTypeContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mediaTypeContainer.layer.cornerRadius = CGFloat(10)
        mediaTypeContainer.layer.shadowRadius = CGFloat(10)
        mediaTypeContainer.layer.shadowColor = UIColor.systemGray2.cgColor
        mediaTypeContainer.layer.shadowOpacity = 0.8
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MediaPreviewCell.identifier) as? MediaPreviewCell else {
            return UITableViewCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 2
    }
    

}

