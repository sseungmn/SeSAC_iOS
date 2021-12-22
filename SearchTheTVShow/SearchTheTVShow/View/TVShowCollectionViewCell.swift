//
//  TVShowCollectionViewCell.swift
//  SearchTheTVShow
//
//  Created by SEUNGMIN OH on 2021/12/22.
//

import UIKit
import SnapKit

class TVShowCollectionViewCell: UICollectionViewCell {
    private var posterImage = UIImageView()
    let cornerRadius: CGFloat = 5.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterImage)
        posterImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        posterImage.layer.cornerRadius = cornerRadius
        posterImage.layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setPosterImage(path: String?) {
        let baseUrl = "https://image.tmdb.org/t/p/original"
        guard let path = path, let url = URL(string: baseUrl + path) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            let image = UIImage(data: data)
            DispatchQueue.main.async { [weak self] in
                self?.posterImage.image = image
            }
        }.resume()
    }
    
    func flash() {
        contentView.alpha = 0.5
      setNeedsDisplay()
      UIView.animate(withDuration: 0.5, animations: { [weak self] in
        self?.contentView.alpha = 1
      })
    }
}
