//
//  ShoppingListTableViewController.swift
//  D11_ShoppingList
//
//  Created by OHSEUNGMIN on 2021/10/14.
//

import UIKit
import RealmSwift

class ShoppingListTableViewController: UITableViewController {

//    var shoppingList = [Item]()
    let localRealm = try! Realm()
    var tasks: Results<Item>!
    
    @IBOutlet weak var userInputTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Realm is located at : ", localRealm.configuration.fileURL!)
        
        tasks = localRealm.objects(Item.self).sorted(byKeyPath: "title", ascending: false)
    }
    @IBAction func addItemButtonClicked(_ sender: UIButton) {
        guard let title = userInputTextField.text else { return }
        let row = Item(title: title)
        
        userInputTextField.text = ""
        try! localRealm.write {
            localRealm.add(row)
        }
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ShoppingListTableViewCell.identifier, for: indexPath) as? ShoppingListTableViewCell else {
            return UITableViewCell()
        }
        let item = tasks[indexPath.row]
        cell.boughtButton.isSelected = item.bought
        cell.shoppinListLabel.text = item.title
        cell.bookmarkButton.isSelected = item.bookmarked
        cell.bookmarkButtonAction = { [unowned self] in
            cell.bookmarkButton.isSelected = cell.bookmarkButton.isSelected ? false : true
            try! localRealm.write {
                item.bookmarked = cell.bookmarkButton.isSelected
            }
        }
        cell.boughtButtonAction = { [unowned self] in
            cell.boughtButton.isSelected = cell.boughtButton.isSelected ? false : true
            try! localRealm.write {
                item.bought = cell.boughtButton.isSelected
            }
        }
        
        return cell
    }
    
    @objc func setBoughtButton() {
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 12
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let task = tasks[indexPath.row]
            try! localRealm.write {
                localRealm.delete(task)
            }
            tableView.reloadData()
        }
    }
}
