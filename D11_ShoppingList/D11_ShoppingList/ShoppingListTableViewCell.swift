//
//  ShoppingListTableViewCell.swift
//  D11_ShoppingList
//
//  Created by OHSEUNGMIN on 2021/10/14.
//

import UIKit

class ShoppingListTableViewCell: UITableViewCell {

    static let identifier = "ShoppingListCell"
    
    @IBOutlet weak var boughtCheckButton: UIButton!
    @IBOutlet weak var shoppinListLabel: UILabel!
    @IBOutlet weak var bookmarkCheckButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        NSLayoutConstraint.activate([
            bookmarkCheckButton.widthAnchor.constraint(equalTo: self.heightAnchor, constant: -16)
        ])
    }
    

    @IBAction func starButtonClicked(_ sender: UIButton) {
        self.bookmarkCheckButton.isSelected = self.bookmarkCheckButton.isSelected ? false : true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            self.boughtCheckButton.isSelected = self.boughtCheckButton.isSelected ? false : true
        }
    }

}
