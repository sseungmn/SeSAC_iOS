//
//  PostView.swift
//  SeSACCommunity
//
//  Created by SEUNGMIN OH on 2022/01/03.
//

import UIKit

class PostView: UITableViewCell {
  let contentStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.distribution = .fill
    stackView.spacing = 20
    return stackView
  }()
  let bodyLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 4
    return label
  }()
  let infoStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.distribution = .equalSpacing
    return stackView
  }()
  let userNameLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 13)
    label.textColor = .lightGray
    return label
  }()
  let dateLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 13)
    label.textColor = .lightGray
    return label
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    configure()
    setConstraint()
  }
  
  override func draw(_ rect: CGRect) {
    super.draw(rect)
    let screenSize = UIScreen.main.bounds
    let separatorHeight = CGFloat(8.0)
    let additionalSeparator = UIView.init(
      frame: CGRect(x: 0,
                    y: self.frame.size.height-separatorHeight,
                    width: screenSize.width,
                    height: separatorHeight)
    )
    additionalSeparator.backgroundColor = UIColor.systemGray5
    addSubview(additionalSeparator)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configure() {
  }
  
  func setConstraint() {
    addSubview(contentStackView)
    contentStackView.snp.makeConstraints { make in
      make.edges.equalToSuperview().inset(20)
    }
    contentStackView.addArrangedSubview(bodyLabel)
    contentStackView.addArrangedSubview(infoStackView)
    infoStackView.addArrangedSubview(userNameLabel)
    infoStackView.addArrangedSubview(dateLabel)
  }
}
