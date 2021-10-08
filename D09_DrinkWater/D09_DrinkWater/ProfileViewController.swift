//
//  ProfileViewController.swift
//  D09_DrinkWater
//
//  Created by OHSEUNGMIN on 2021/10/09.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var stageImage: UIImageView!
    @IBOutlet weak var nicknameUserInput: UITextField!
    @IBOutlet weak var heightUserInput: UITextField!
    @IBOutlet weak var weightUserInput: UITextField!
    
    var nickname: String = ""
    var height: Int = 0
    var weight: Int = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = .white
        self.view.backgroundColor = UIColor(named: "contentDefault")
        
        getUserData()
        stageImage.image = UIImage(named: "1-1")
        nicknameUserInput.text = nickname
        heightUserInput.text = String(height)
        weightUserInput.text = String(weight)
    }
    
    func getUserData() {
        nickname = UserDefaults.standard.string(forKey: "nickname") ?? "miniOS"
        height = UserDefaults.standard.integer(forKey: "height")
        height = height == 0 ? 160 : height
        weight = UserDefaults.standard.integer(forKey: "weight")
        weight = weight == 0 ? 50 : weight
    }
    
}
