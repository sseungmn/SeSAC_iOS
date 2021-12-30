//
//  BottomView.swift
//  RecommendTheBeer
//
//  Created by SEUNGMIN OH on 2021/12/27.
//

import UIKit

class BottomView: BaseView {
  // MARK: private variables
  private let resetButton = UIButton()
  private let shareButton = UIButton()
  
  private let cornerRadius: CGFloat = 8.0
  private let pointSize: CGFloat = 20.0
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func setConfiguration() {
    backgroundColor = nil
    
    resetButton.layer.borderWidth = 3
    resetButton.layer.borderColor = UIColor.themeColor.cgColor
    resetButton.tintColor = .themeColor
    resetButton.backgroundColor = .white
    resetButton.setImage(UIImage(systemName: "arrow.triangle.2.circlepath"), for: .normal)
    resetButton.layer.cornerRadius = cornerRadius
    var config = UIButton.Configuration.plain()
    config.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: pointSize)
    resetButton.configuration = config
    
    shareButton.layer.cornerRadius = cornerRadius
    shareButton.backgroundColor = .themeColor
    shareButton.setTitle("Share BEER", for: .normal)
    shareButton.titleLabel?.font = .boldSystemFont(ofSize: pointSize)
    shareButton.titleLabel?.font = shareButton.titleLabel?.font.withSize(15)
    shareButton.titleLabel?.font = .systemFont(ofSize: 15)
    shareButton.setTitleColor(.black, for: .normal)
  }
  
  override func setContraints() {
    self.addSubview(resetButton)
    resetButton.snp.makeConstraints { make in
      make.left.equalToSuperview().inset(20)
      make.top.bottom.equalToSuperview()
      make.width.equalTo(resetButton.snp.height)
    }
    self.addSubview(shareButton)
    shareButton.snp.makeConstraints { make in
      make.right.equalToSuperview().inset(20)
      make.top.bottom.equalToSuperview()
      make.left.equalTo(resetButton.snp.right).offset(10)
    }
  }
  
  // MARK: set Actions
  public func setResetButtonAction(handler: @escaping (UIAction) -> Void) {
    resetButton.addAction(UIAction(handler: handler), for: .touchUpInside)
  }
  
  public func setShareButtonAction(handler: @escaping (UIAction) -> Void) {
    resetButton.addAction(UIAction(handler: handler), for: .touchUpInside)
  }
}
