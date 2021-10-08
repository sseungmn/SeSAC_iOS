//
//  ViewController.swift
//  D09_DrinkWater
//
//  Created by OHSEUNGMIN on 2021/10/08.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var resetTodayWaterButton: UIBarButtonItem!
    @IBOutlet weak var showProfileViewButton: UIBarButtonItem!
    
    @IBOutlet weak var todayTotalWaterLabel: UILabel!
    @IBOutlet weak var todayPercentWaterLabel: UILabel!
    @IBOutlet weak var stageImage: UIImageView!
    
    @IBOutlet weak var userInputWaterLabel: UITextField!
    @IBOutlet weak var personalWaterDescriptionLabel: UILabel!
    @IBOutlet weak var drinkWaterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.standardAppearance.shadowColor = .black
        self.view.backgroundColor = UIColor(named: "contentDefault")
        resetTodayWaterButton.tintColor = .white
        showProfileViewButton.tintColor = .white
        self.title = "물 마시기"
        
        // font size : 20, 20, 30, 13
        todayTotalWaterLabel.textColor = .white
        todayTotalWaterLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
//        UserDefaults.standard.set(0, forKey: "total")
        todayPercentWaterLabel.textColor = .white
        todayTotalWaterLabel.text = "0ml"
        todayPercentWaterLabel.text = "목표의 0%"
        
        stageImage.image = UIImage(named: "1-1")
        
        personalWaterDescriptionLabel.text = "안녕하세요님의 하루 물 섭취량은 0L입니다."
    }
    
    func setTodayWaterLabel() {
        let allowance = UserDefaults.standard.integer(forKey: "allowance")
        let total = UserDefaults.standard.integer(forKey: "total")
        todayTotalWaterLabel.text = String(total)
        todayPercentWaterLabel.text = String(total / allowance)
    }
}

