//
//  ViewController.swift
//  RecommendTheBeer
//
//  Created by SEUNGMIN OH on 2021/12/23.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
  
  let viewModel = BeerAPIViewModel()

  let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    return imageView
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    view.addSubview(imageView)
    imageView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    
    viewModel.requestRandomBeer { [weak self] image in
      guard let image = image else { return }
      DispatchQueue.main.async {
        self?.imageView.image = image
      }
    }
  }
}
