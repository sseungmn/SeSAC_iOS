//
//  BeerImageView.swift
//  RecommendTheBeer
//
//  Created by SEUNGMIN OH on 2021/12/24.
//

import UIKit
import SnapKit

class BeerImageView: BaseView {
  
  // MARK: private property
  private let backgroundImageView = UIImageView()
  private let blurFilterView = UIVisualEffectView()
  private let beerImageView = UIImageView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  override func configuration() {
    backgroundImageView.contentMode = .scaleToFill
    blurFilterView.effect = UIBlurEffect(style: .light)
    beerImageView.contentMode = .scaleAspectFit
  }
  
  override func setContraints() {
    [backgroundImageView, blurFilterView].forEach { view in
      self.addSubview(view)
      view.snp.makeConstraints { make in
        make.edges.equalToSuperview()
      }
    }
    
    self.addSubview(beerImageView)
    beerImageView.snp.makeConstraints { make in
      make.top.bottom.equalToSuperview().inset(10)
      make.left.right.equalToSuperview()
    }
  }
  
  public func setImage(_ image: UIImage) {
    backgroundImageView.image = image
    beerImageView.image = image
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
