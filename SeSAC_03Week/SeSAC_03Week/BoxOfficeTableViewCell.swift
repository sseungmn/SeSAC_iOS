//
//  BoxOfficeTableViewCell.swift
//  SeSAC_03Week
//
//  Created by OHSEUNGMIN on 2021/10/14.
//

import UIKit

class BoxOfficeTableViewCell: UITableViewCell {
    
    static let identifier = "BoxOfficeTableViewCell"
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let possibleHeight = self.frame.height - 16
        NSLayoutConstraint.activate([
            titleLabel.heightAnchor.constraint(equalToConstant: possibleHeight * 3 / 16),
            releaseDateLabel.heightAnchor.constraint(equalToConstant: possibleHeight * 2 / 16),
            overviewLabel.heightAnchor.constraint(equalToConstant: possibleHeight * 11 / 16),
        ])
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
