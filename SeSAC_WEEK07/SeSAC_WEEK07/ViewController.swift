//
//  ViewController.swift
//  SeSAC_WEEK07
//
//  Created by OHSEUNGMIN on 2021/11/10.
//

import UIKit

class ViewController: UIViewController, PassDataDelegate {
    

    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addObserver()
    }
    
    // MARK: - Closure Handler
    @IBAction func buttonClicked(_ sender: UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "YellowViewController") as? YellowViewController else { return }
        
        vc.buttonActionHandler = {
            self.textView.text = vc.textView.text
        }
        vc.textSpace = textView.text
        
        self.present(vc, animated: true, completion: nil)
    }
    
    // MARK: - Delegate
    @IBAction func protocolButtonClicked(_ sender: Any) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "YellowViewController") as? YellowViewController else { return }
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
    func sendTextData(text: String) {
        textView.text = text
    }
    
    // MARK: - Notification
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("firstNotification"), object: nil)
    }
    
    @IBAction func notificationButtonClicked(_ sender: UIButton) {
        NotificationCenter.default.post(name: NSNotification.Name("firstNotification"), object: nil, userInfo: ["myText": textView.text!, "value": 123])
        
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "YellowViewController") as? YellowViewController else { return }
        
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func firstNotification(notification: NSNotification) {
        print("NOTIFICATION")
        if let text = notification.userInfo?["myText"] as? String {
            textView.text = text
        }
    }
    
    func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(firstNotification(notification:)), name: .myNotification, object: nil)
    }

}


extension NSNotification.Name {
    static let myNotification = NSNotification.Name("firstNotification")
}
