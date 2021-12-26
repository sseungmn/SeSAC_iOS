//
//  BeerInfoView.swift
//  RecommendTheBeer
//
//  Created by SEUNGMIN OH on 2021/12/24.
//

import UIKit

public func debug(_ items: Any..., separator: String = " ", terminator: String = "\n") {
  var output = "Debug : "
  output += items.map { "\($0)" }.joined(separator: separator)
  Swift.print(output, terminator: terminator)
}

class BeerInfoView: BaseView {
  var isShrinked: Bool = true
  
  // MARK: private variable
  private let vstackView = UIStackView()
  private var nameLabel = UILabel()
  private var taglineLabel = UILabel()
  private var descriptionLabel = DescriptionLabel()
  private let moreButton = UIButton(type: .custom)
  
  private let cornerRadius: CGFloat = 8.0
  private let fillColor: UIColor = .white
  
  private let shadowLayer = CAShapeLayer()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    debug("        InfoView", #function)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func configuration() {
    backgroundColor = fillColor
    layer.cornerRadius = cornerRadius
    layer.insertSublayer(shadowLayer, at: 0)
    
    vstackView.axis = .vertical
    vstackView.distribution = .fill
    vstackView.spacing = 10
    
    descriptionLabel.setContentCompressionResistancePriority(.sceneSizeStayPut, for: .vertical)
    
    nameLabel.font = .systemFont(ofSize: 23, weight: .bold)
    taglineLabel.font = .systemFont(ofSize: 15)
    descriptionLabel.font = .systemFont(ofSize: 15)
    descriptionLabel.numberOfLines = 4
    moreButton.setTitle("more", for: .normal)
    moreButton.titleLabel?.font = .systemFont(ofSize: 13, weight: .heavy)
    
    moreButton.setTitleColor(.black, for: .normal)
    moreButton.titleLabel?.textAlignment = .center
    [nameLabel, taglineLabel, descriptionLabel].forEach { label in
      label.textAlignment = .center
      label.textColor = .black
    }
    descriptionLabel.textAlignment = .justified
  }
  
  override func setContraints() {
    self.addSubview(moreButton)
    moreButton.snp.makeConstraints { make in
      make.bottom.equalToSuperview().inset(10)
      make.centerX.equalToSuperview()
      make.height.equalTo(20)
    }
    
    self.addSubview(vstackView)
    vstackView.snp.makeConstraints { make in
      make.top.equalToSuperview().inset(25)
      make.left.right.equalToSuperview().inset(20)
      make.bottom.equalTo(moreButton.snp.top).inset(-10)
    }
    
    vstackView.addArrangedSubview(nameLabel)
    vstackView.addArrangedSubview(taglineLabel)
    vstackView.addArrangedSubview(descriptionLabel)
  }
  
  // MARK: more Button
  func setMoreAction(handler: @escaping (UIAction) -> Void) {
    moreButton.addAction(UIAction(handler: handler), for: .touchUpInside)
  }
  
  func moreAction() {
    debug("        InfoView", #function)
    if isShrinked {
      self.descriptionLabel.numberOfLines = 0
    } else {
      self.descriptionLabel.numberOfLines = 4
    }
    isShrinked.toggle()
//    DispatchQueue.main.async {
//      self.updateShadow()
//    }
  }
}

extension BeerInfoView {
  // MARK: Shadow
  func updateShadow() {
    shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
    debug("        InfoView", #function)
    shadowLayer.fillColor = fillColor.cgColor
    
    shadowLayer.shadowColor = UIColor.black.cgColor
    shadowLayer.shadowPath = shadowLayer.path
    shadowLayer.shadowOffset = .zero
    shadowLayer.shadowOpacity = 0.3
    shadowLayer.shadowRadius = 5
  }
  public func setInformation(_ beer: Beer) {
    debug("        InfoView", #function)
    // 1
    self.nameLabel.text = beer.name
    self.taglineLabel.text = beer.tagline
    self.descriptionLabel.text = beer.beerDescription
    // 2
//    DispatchQueue.main.async {
//      self.updateShadow()
//    }
  }
}

// MARK: DescriptionLabel
class DescriptionLabel: UILabel {
  override var bounds: CGRect {
    didSet {
      debug("DescriptionLabel", "height : ", bounds.height)
    }
  }
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func updateConstraints() {
    super.updateConstraints()
    debug("DescriptionLabel", #function)
  }

  override func draw(_ rect: CGRect) {
    super.draw(rect)
    debug("DescriptionLabel", #function)
    guard let stackView = superview as? UIStackView,
    let superView = stackView.superview as? BeerInfoView else { return }
    DispatchQueue.main.async {
      superView.updateShadow()
    }
  }
}
