//
//  CustomTableViewCell.swift
//  RecommendTheBeer
//
//  Created by SEUNGMIN OH on 2021/12/27.
//

import UIKit

class BeerTableViewCell: UITableViewCell {
  let title: UILabel = {
   let label = UILabel()
    label.textAlignment = .left
    label.textColor = .black
    label.font = .systemFont(ofSize: 15)
    return label
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.backgroundColor = .white
    self.addSubview(title)
    title.snp.makeConstraints { make in
      make.edges.equalToSuperview().inset(8)
    }
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
