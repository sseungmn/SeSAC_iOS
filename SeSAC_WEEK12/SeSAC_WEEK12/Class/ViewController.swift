//
//  ViewController.swift
//  SeSAC_WEEK12
//
//  Created by SEUNGMIN OH on 2021/12/13.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var favoriteMenuView: SquareBoxView!
    
    let redView = UIView()
    let greenView = UIView()
    let blueView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        greenView.addSubview(redView)
        view.addSubview(blueView)
        view.addSubview(greenView)
        
        greenView.clipsToBounds = true
        greenView.alpha = 0.5
        
        redView.frame = CGRect(x: 30, y: 30, width: 200, height: 200)
        redView.backgroundColor = .red
        
        blueView.frame = CGRect(x: 100, y: 100, width: 150, height: 150)
        blueView.backgroundColor = .blue
        
        greenView.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        greenView.backgroundColor = .green
        
        favoriteMenuView.label.text = "즐겨찾기"
        favoriteMenuView.imageView.image = UIImage(systemName: "star")
        
     
    }

    @IBAction func presentButtonClicked(_ sender: UIButton) {
        present(DetailViewController(), animated: true, completion: nil)
    }
    

}

