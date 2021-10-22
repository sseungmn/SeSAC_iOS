//
//  SearchTableViewCell.swift
//  D13_TrendMedia
//
//  Created by OHSEUNGMIN on 2021/10/23.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet var previewImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var detailLabel: UILabel!
    @IBOutlet var overviewLabel: UILabel!
    
    static let identifier = "SearchTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor(named: "serachViewBackground")
        self.previewImageView.contentMode = .scaleAspectFill
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
