//
//  ShoppingListTableViewCell.swift
//  D11_ShoppingList
//
//  Created by OHSEUNGMIN on 2021/10/14.
//

import UIKit

class ShoppingListTableViewCell: UITableViewCell {

    static let identifier = "ShoppingListCell"
    
    @IBOutlet weak var boughtButton: UIButton!
    @IBOutlet weak var shoppinListLabel: UILabel!
    @IBOutlet weak var bookmarkButton: UIButton!
    
    var bookmarkButtonAction: (() -> ())?
    var boughtButtonAction: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        NSLayoutConstraint.activate([
            bookmarkButton.widthAnchor.constraint(equalTo: self.heightAnchor, constant: -16)
        ])
        boughtButton.addTarget(self, action: #selector(self.boughtButtonClicked(_:)), for: .touchUpInside)
        bookmarkButton.addTarget(self, action: #selector(self.bookmarkButtonClicked(_:)), for: .touchUpInside)
    }
    
    
    @IBAction func bookmarkButtonClicked(_ sender: UIButton) {
        bookmarkButtonAction?()
//        self.bookmarkButton.isSelected = self.bookmarkButton.isSelected ? false : true
    }


    @IBAction func boughtButtonClicked(_ sender: UIButton) {
        boughtButtonAction?()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            boughtButtonAction!()
//            self.boughtButton.isSelected = self.boughtButton.isSelected ? false : true
        }
    }

}
