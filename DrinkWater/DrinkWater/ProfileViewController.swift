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
    
    var allowance: Int  { return UserDefaults.standard.integer(forKey: "allowance") }
    var todayPercent: Int { return  allowance == 0 ? 0 : todayTotal * 100 / allowance }
    var todayTotal: Int { return UserDefaults.standard.integer(forKey: "total") }
    var nickname: String  { return UserDefaults.standard.string(forKey: "nickname") ?? "" }
    var height: Int { return UserDefaults.standard.integer(forKey: "height") }
    var weight: Int { return UserDefaults.standard.integer(forKey: "weight") }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    // view가 보여질 때 마다 바뀌어야 할 것은 따로 정의
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setStageImage()
    }
    
    @IBAction func saveButtonClicked(_ sender: UIBarButtonItem) {
        guard let nn = nicknameUserInput.text, let h = Int(heightUserInput.text!), let w = Int(weightUserInput.text!) else {
            showAlert(of: .UserInputError)
            return
        }
        UserDefaults.standard.set(nn, forKey: "nickname")
        UserDefaults.standard.set(h, forKey: "height")
        UserDefaults.standard.set(w, forKey: "weight")
        showAlert(of: .SaveCompletely)
    }
    
    @IBAction func endEditing(_ sender: Any) {
        if nicknameUserInput.isEditing || heightUserInput.isEditing || weightUserInput.isEditing {
            view.endEditing(true)
        }
    }
}

extension ProfileViewController {
    func setUI() {
        self.navigationController?.navigationBar.tintColor = .white
        self.view.backgroundColor = UIColor(named: "contentDefault")
        
        nicknameUserInput.text = nickname
        heightUserInput.text = String(height)
        weightUserInput.text = String(weight)
        
        nicknameUserInput.keyboardType = .default
        heightUserInput.keyboardType = .numberPad
        weightUserInput.keyboardType = .numberPad
    }
    
    func setStageImage() {
        stageImage.image = getStageImage(todayPercent: todayPercent)
    }
    
    func calculateAllowance() {
        let newAllowance = (height + weight) * 10 // ml
        print("new allowance : \(newAllowance)")
        UserDefaults.standard.set(newAllowance, forKey: "allowance")
    }
    
    func showAlert(of type: AlertType) {
        let alert: UIAlertController
        
        switch type {
        case .UserInputError:
            alert = UIAlertController(title: "입력 오류", message: "입력이 올바르지 않습니다.\n다시 한번 확인 해 주세요.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .cancel) { _ in
                print("Cancel Button Clicked")
            })
        case .SaveCompletely:
            alert = UIAlertController(title: "저장 완료", message: "입력이 올바르게 저장되었습니다.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default) { _ in
                print("OK Button Clicked")
                self.calculateAllowance()
                self.setStageImage()
            })
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    enum AlertType {
        case UserInputError, SaveCompletely
    }
}
