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
    
    @IBOutlet weak var todayTotalLabel: UILabel!
    @IBOutlet weak var todayPercentLabel: UILabel!
    @IBOutlet weak var stageImage: UIImageView!
    
    @IBOutlet weak var userInputWaterLabel: UITextField!
    @IBOutlet weak var allowanceLabel: UILabel!
    
    @IBOutlet weak var drinkButton: UIButton!
    
    var allowance: Int  { return UserDefaults.standard.integer(forKey: "allowance") }
    var todayPercent: Int { return  allowance == 0 ? 0 : todayTotal * 100 / allowance }
    var todayTotal: Int { return UserDefaults.standard.integer(forKey: "total") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.standardAppearance.shadowColor = .black
        self.view.backgroundColor = UIColor(named: "contentDefault")
        resetTodayWaterButton.tintColor = .white
        showProfileViewButton.tintColor = .white
        self.title = "물 마시기"
        
        // font size : 20, 20, 30, 13
        todayTotalLabel.textColor = .white
        todayTotalLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        todayPercentLabel.textColor = .white
        
        userInputWaterLabel.keyboardType = .numbersAndPunctuation
    }
    
    // View가 보여질 때 마다 해줘야 할 것은 따로 정의
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        update()
    }
    
    // MARK: 물 마시기
    @IBAction func drinkWaterClicked(_ sender: UIButton) {
        drinkWater()
    }
    // MARK: 키보드 내리기
    @IBAction func endEditing(_ sender: Any) {
        if userInputWaterLabel.isEditing { userInputWaterLabel.endEditing(true) }
    }
    
    // MARK: 초기화
    @IBAction func resetButtonClicked(_ sender: UIBarButtonItem) {
        UserDefaults.standard.set(0, forKey: "total")
        UserDefaults.standard.set(0, forKey: "percent")
        
        update()
    }
}

extension ViewController {
    func update() {
        setTodayLabel()
        setAlloanceLabel()
        setStageImage()
    }
    
    func drinkWater() {
        // UserInput이 Int형일때만 적용
        guard let input = Int(userInputWaterLabel.text!) else {
            // Int형이 아닐 때에는 오류를 표시
            return;
        }
        UserDefaults.standard.set(todayTotal + input, forKey: "total")
        
        userInputWaterLabel.text = ""
        update()
    }
    
    // MARK: 라벨에 적용
    func setTodayLabel() {
        todayTotalLabel.text = "\(todayTotal)ml"
        todayPercentLabel.text = "목표의 \(todayPercent)%"
    }
    
    func setAlloanceLabel() {
        let Lallowance: Double = Double(allowance) / 1000
        let nickName = UserDefaults.standard.string(forKey: "nickname") ?? "miniOS"
        allowanceLabel.text = "\(nickName)님의 하루 물 권장 섭취량은 \(Lallowance)L 입니다."
    }
    
    func setStageImage() {
        stageImage.image = getStageImage(todayPercent: self.todayPercent)
    }
}

func getStageImage(todayPercent: Int) -> UIImage {
    let UNIT: Double = 100 / 8
    var stage: Int
    
    switch todayPercent {
    case 0..<Int(1 * UNIT) :
        stage =  1
    case Int(1 * UNIT)...Int(2 * UNIT):
        stage =  2
    case Int(2 * UNIT)...Int(3 * UNIT):
        stage =  3
    case Int(3 * UNIT)...Int(4 * UNIT):
        stage = 4
    case Int(4 * UNIT)...Int(5 * UNIT):
        stage = 5
    case Int(5 * UNIT)...Int(6 * UNIT):
        stage = 6
    case Int(6 * UNIT)...Int(7 * UNIT):
        stage = 7
    case Int(7 * UNIT)...Int(8 * UNIT):
        stage = 8
    default:
        stage = 9
    }

    guard let image = UIImage(named: "1-\(stage)")  else {
        print("Invalid Image Name")
        return UIImage()
    }
    return image
}
