//
//  SearchTableViewCell.swift
//  SeSAC_WEEK06
//
//  Created by OHSEUNGMIN on 2021/11/02.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    static let identifier = "SearchTableViewCell"

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupUI() {
        titleLabel.font = .boldSystemFont(ofSize: 17)
        dateLabel.font = .systemFont(ofSize: 13)
        dateLabel.textColor = .systemGray4
        contentLabel.font = UIFont().batang
        contentLabel.textColor = .systemGray3
    }

}
