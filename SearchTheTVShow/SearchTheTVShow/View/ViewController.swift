//
//  ViewController.swift
//  SearchTheTVShow
//
//  Created by SEUNGMIN OH on 2021/12/21.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    let searchAPI = SearchAPI()
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 10,
                                 height: UIScreen.main.bounds.height / 4)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        return cv
    }()
    var tvShowData: TVShow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(TVShowCollectionViewCell.self, forCellWithReuseIdentifier: TVShowCollectionViewCell.reuseIdentifier)
        searchAPI.requestTVShow(query: "빅뱅") { tvShow in
            print("성공")
            print(tvShow)
            self.tvShowData = tvShow
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tvShowData?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TVShowCollectionViewCell.reuseIdentifier, for: indexPath) as? TVShowCollectionViewCell else { return UICollectionViewCell() }
        cell.setPosterImage(path: tvShowData?.results[indexPath.row].posterPath)
        
        return cell
    }
    
    
}

