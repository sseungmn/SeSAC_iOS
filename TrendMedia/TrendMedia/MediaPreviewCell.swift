//
//  MediaPreviewCell.swift
//  D13_TrendMedia
//
//  Created by OHSEUNGMIN on 2021/10/21.
//

import UIKit

class MediaPreviewCell: UITableViewCell {
    
    static let identifier = "MediaPreviewCell"
    @IBOutlet weak var outerPreviewContainer: UIView!
    @IBOutlet weak var previewContainer: UIView!
    @IBOutlet weak var contentGenreLabel: UILabel!
    @IBOutlet weak var contentTitleLabel: UILabel!
    @IBOutlet weak var contentStarringLabel: UILabel!
    @IBOutlet weak var contentReleaseDateLabel: UILabel!
    @IBOutlet var previewImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        outerPreviewContainer.layer.masksToBounds = false
        outerPreviewContainer.backgroundColor = nil
        outerPreviewContainer.layer.shadowColor = UIColor.systemGray2.cgColor
        outerPreviewContainer.layer.shadowRadius = 10.0
        outerPreviewContainer.layer.shadowOpacity = 0.8
        
        previewContainer.layer.masksToBounds = true
        previewContainer.layer.borderWidth = 0
        previewContainer.layer.cornerRadius = CGFloat(10)
        
        previewImage.layer.masksToBounds = false
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
