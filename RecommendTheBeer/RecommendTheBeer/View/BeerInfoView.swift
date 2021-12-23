//
//  BeerInfoView.swift
//  RecommendTheBeer
//
//  Created by SEUNGMIN OH on 2021/12/24.
//

import UIKit

class BeerInfoView: BaseView {
  
  private let vstackView = UIStackView()
  private var nameLabel = UILabel()
  private var taglineLabel = UILabel()
  private var descriptionLabel = UILabel()
  private let moreClickableLabel = UILabel()
  
  private let cornerRadius: CGFloat = 8.0
  private let fillColor: UIColor = .white
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func configuration() {
    backgroundColor = fillColor
    layer.cornerRadius = cornerRadius
    
    vstackView.axis = .vertical
    vstackView.distribution = .fill
    vstackView.spacing = 10
    
    descriptionLabel.setContentCompressionResistancePriority(.sceneSizeStayPut, for: .vertical)
    
    nameLabel.font = .systemFont(ofSize: 23, weight: .bold)
    taglineLabel.font = .systemFont(ofSize: 15)
    descriptionLabel.font = .systemFont(ofSize: 15)
    descriptionLabel.numberOfLines = 0
    moreClickableLabel.text = "more"
    moreClickableLabel.font = .systemFont(ofSize: 13, weight: .heavy)
    
    [nameLabel, taglineLabel, descriptionLabel, moreClickableLabel].forEach { label in
      label.textAlignment = .center
      label.textColor = .black
    }
    descriptionLabel.textAlignment = .justified
    
    addTarget(moreClickableLabel, action: #selector(showMore))
  }
  
  // MARK: Make Label Clickable
  func addTarget(_ label: UILabel, action: Selector) {
    let tap = UITapGestureRecognizer(target: self, action: action)
    label.isUserInteractionEnabled = true
    label.addGestureRecognizer(tap)
  }
  
  @objc func showMore(_ sender: UILabel) {
    print("showMore")
  }
  
  override func setContraints() {
    self.addSubview(moreClickableLabel)
    moreClickableLabel.snp.makeConstraints { make in
      make.bottom.equalToSuperview().inset(20)
      make.centerX.equalToSuperview()
      make.height.equalTo(10)
    }
    
    self.addSubview(vstackView)
    vstackView.snp.makeConstraints { make in
      make.top.equalToSuperview().inset(25)
      make.left.right.equalToSuperview().inset(20)
      make.bottom.equalTo(moreClickableLabel.snp.top).inset(-20)
    }
    
    vstackView.addArrangedSubview(nameLabel)
    vstackView.addArrangedSubview(taglineLabel)
    vstackView.addArrangedSubview(descriptionLabel)
  }
  
  // MARK: Shadow
  override func layoutSubviews() {
    super.layoutSubviews()
    setShadow()
  }
  
  private func setShadow() {
    let shadowLayer = CAShapeLayer()
    
    shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
    shadowLayer.fillColor = fillColor.cgColor
    
    shadowLayer.shadowColor = UIColor.black.cgColor
    shadowLayer.shadowPath = shadowLayer.path
    shadowLayer.shadowOffset = .zero
    shadowLayer.shadowOpacity = 0.3
    shadowLayer.shadowRadius = 10
    
    layer.insertSublayer(shadowLayer, at: 0)
  }
  
  public func setInformation(_ beer: Beer) {
    self.nameLabel.text = beer.name
    self.taglineLabel.text = beer.tagline
    self.descriptionLabel.text = beer.beerDescription
  }
}
