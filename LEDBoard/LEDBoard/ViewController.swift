//
//  ViewController.swift
//  LEDBoard
//
//  Created by OHSEUNGMIN on 2021/10/05.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var boardView: UIView!
    @IBOutlet var userTextField: UITextField!
    @IBOutlet var sendButton: UIButton!
    @IBOutlet var textColorButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    // 1단계 : Project Setup & UI
    func setUI() {
        
        boardView.layer.cornerRadius = 5
        
        userTextField.placeholder = "텍스트를 입력해주세요"
        userTextField.borderStyle = .none
        
        sendButton.layer.borderWidth = 2
        sendButton.layer.cornerRadius = 5
        sendButton.layer.borderColor = UIColor.black.cgColor
        sendButton.tintColor = .black
        
        textColorButton.layer.borderWidth = 2
        textColorButton.layer.cornerRadius = 5
        textColorButton.layer.borderColor = UIColor.black.cgColor
        textColorButton.tintColor = .systemRed
        
        // default font
        resultLabel.font = UIFont.systemFont(ofSize: 140)
        resultLabel.textColor = UIColor.cyan
        resultLabel.textAlignment = NSTextAlignment.center
    }

    // 2단계 : send to Label
    @IBAction func sendButtonClicked(_ sender: UIButton) {
        sendTextToLabel()
    }
    
    // 2단계 : Random Text Color
    let colorArray : [UIColor] = [UIColor.systemRed, UIColor.systemBlue, UIColor.systemCyan, UIColor.systemGray, UIColor.systemMint, UIColor.systemPink, UIColor.systemTeal, UIColor.systemBrown, UIColor.systemGreen, UIColor.systemIndigo]
    @IBAction func textColorButtonClicked(_ sender: UIButton) {
        resultLabel.textColor = colorArray.shuffled()[0]
    }
    
    @IBAction func tabAction(_ sender: UITapGestureRecognizer) {
        // 3단계 : Tap Gesture
        view.endEditing(true)
        
        // 5단계 : Toggle View
        if boardView.isHidden == true {
            boardView.isHidden = false
        } else {
            boardView.isHidden = true
        }
    }
    
    // 4단계 : DidEndOnExit
    @IBAction func returnPressed(_ sender: Any) {
        sendTextToLabel()
        view.endEditing(true)
    }
    
    func sendTextToLabel() {
        resultLabel.text = userTextField.text
        userTextField.text = ""
    }
    
    
}
