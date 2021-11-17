//
//  MenuViewController.swift
//  D11_ShoppingList
//
//  Created by OHSEUNGMIN on 2021/11/04.
//

import UIKit

class MenuViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var restoreAction: ( () -> () )?
    var backupAction: ( () -> () )?
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            print("Restore Button Clicked!")
            restoreAction!()
        } else if indexPath.row == 1 {
            print("Backup Button Clicked!")
            backupAction!()
        }
    }
}
