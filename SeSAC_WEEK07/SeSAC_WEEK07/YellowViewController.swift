//
//  YellowViewController.swift
//  SeSAC_WEEK07
//
//  Created by OHSEUNGMIN on 2021/11/10.
//

import UIKit

// MARK: Delegate Protocol
protocol PassDataDelegate {
    func sendTextData(text: String)
}

class YellowViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    var textSpace: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.text = textSpace
        
    }
    
    // MARK: - Closure Handler
    var buttonActionHandler: ( () -> () )?
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        
        buttonActionHandler?()
        guard let presentVC = self.presentingViewController else { return }
        
        //
        self.dismiss(animated: true) {
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "PopUpViewController") as? PopUpViewController else { return }
            
            presentVC.present(vc, animated: true, completion: nil)
            print("화면이 닫혔습니다.")
        }
    }
    
    // MARK: - Delegate
    var delegate: PassDataDelegate?
    
    @IBAction func protocolButtonClicked(_ sender: UIButton) {
        if let text = textView.text {
            delegate?.sendTextData(text: text)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Notification
    @IBAction func notificationButtonClicked(_ sender: UIButton) {
        NotificationCenter.default.post(name: .myNotification, object: nil, userInfo: ["myText": textView.text!, "value": 123])
        
        self.dismiss(animated: true, completion: nil)
    }
    
}
