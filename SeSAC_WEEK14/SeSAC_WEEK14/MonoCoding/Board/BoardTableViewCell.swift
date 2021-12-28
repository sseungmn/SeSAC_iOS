//
//  BoardTableViewCell.swift
//  SeSAC_WEEK14
//
//  Created by SEUNGMIN OH on 2021/12/29.
//

import Foundation
import UIKit

class BoardTableViewCell: UITableViewCell {
  let postStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.distribution = .fillProportionally
    stackView.backgroundColor = .darkGray
    return stackView
  }()
  let postIdLabel = UILabel()
  let postTextLabel = UILabel()
  
  let authorStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.distribution = .fillProportionally
    stackView.backgroundColor = .gray
    return stackView
  }()
  let authorIdLabel = UILabel()
  let authorNameLabel = UILabel()
  let authorEmailLabel = UILabel()
  
  func setContraints() {
    contentView.addSubview(postStackView)
    postStackView.snp.makeConstraints { make in
      make.left.top.right.equalToSuperview()
      make.height.equalTo(30)
    }
    postStackView.addArrangedSubview(postIdLabel)
    postStackView.addArrangedSubview(postTextLabel)
    
    contentView.addSubview(authorStackView)
    authorStackView.snp.makeConstraints { make in
      make.top.equalTo(postStackView.snp.bottom)
      make.left.right.bottom.equalToSuperview()
      make.height.equalTo(30)
    }
    authorStackView.addArrangedSubview(authorIdLabel)
    authorStackView.addArrangedSubview(authorNameLabel)
    authorStackView.addArrangedSubview(authorEmailLabel)
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setContraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
