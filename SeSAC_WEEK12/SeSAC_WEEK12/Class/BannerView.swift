//
//  BannerView.swift
//  SeSAC_WEEK12
//
//  Created by SEUNGMIN OH on 2021/12/13.
//

import UIKit

class BannerView: UIView {
    
    let mainLable = UILabel()
    let descriptionLabel = UILabel()
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("override init")
        
        loadLayout()
    }
    
    // 실패 가능한 이니셜라이저
    // xib를 사용하지 않기 때문에 변환하기 위해서 필요한 coder가 필요하지 않다.
    required init?(coder: NSCoder) {
        print("required init")
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadLayout() {
        mainLable.font = .boldSystemFont(ofSize: 15)
        mainLable.textColor = .black
        mainLable.text = "내일 오를 주식을 맞춰주세요!"
        descriptionLabel.font = .systemFont(ofSize: 12)
        descriptionLabel.textColor = .darkGray
        descriptionLabel.text = "맞히면 500원을 드려요"
        
        mainLable.frame = CGRect(x: 30, y: 30, width: UIScreen.main.bounds.width - 130, height: 40)
        descriptionLabel.frame = CGRect(x: 30, y: 80, width: UIScreen.main.bounds.width - 130, height: 30)
        
        self.addSubview(mainLable)
        self.addSubview(descriptionLabel)
    }
}
