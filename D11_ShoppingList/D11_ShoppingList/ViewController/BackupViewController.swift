//
//  BackupViewController.swift
//  D11_ShoppingList
//
//  Created by OHSEUNGMIN on 2021/11/08.
//

import UIKit
import MBProgressHUD

class BackupViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func exitButtonClicked(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
        print("dismiss button clicked")
    }
    
    @IBAction func backupButtonClicked(_ sender: UIButton) {
        backup()
    }
    @IBAction func restoreButtonClicked(_ sender: UIButton) {
        let alert = UIAlertController(title: "Restore", message: "Progress continue...", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default) { _ in
            let indicator = MBProgressHUD.showAdded(to: self.view, animated: true)
            indicator.label.text = "Restore Data"
            indicator.isUserInteractionEnabled = false
            indicator.detailsLabel.text = "Please wait..."
            
            self.restore()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(ok)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
}
