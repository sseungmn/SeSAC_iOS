//
//  TVShowCollectionViewHeader.swift
//  SearchTheTVShow
//
//  Created by SEUNGMIN OH on 2021/12/23.
//

import UIKit
import SnapKit

class TVShowCollectionViewHeader: UICollectionReusableView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "영화 및 TV 프로그램"
        label.font = .boldSystemFont(ofSize: 15)
        label.textAlignment = .left
//        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(8)
            make.top.right.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
