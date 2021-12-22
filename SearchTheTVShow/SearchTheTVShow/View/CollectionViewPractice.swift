//
//  collectionViewPractice.swift
//  SearchTheTVShow
//
//  Created by SEUNGMIN OH on 2021/12/22.
//

import UIKit

class CollectionViewPractice: UIViewController {
    private let collectionViewTitleHeight: CGFloat = 30
    
    // MARK: Private Variable
    private var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search TV Show"
        return searchBar
    }()
    
    // MARK: Set CollectionView
    private func setFlowLayout() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 8
        layout.sectionInset = UIEdgeInsets(top: 0, left: spacing, bottom: spacing, right: spacing)
        let safeAreaFrame = view.safeAreaLayoutGuide.layoutFrame
        layout.itemSize = CGSize(width: (safeAreaFrame.width - 4 * spacing) / 3,
                                 height: (safeAreaFrame.height - 4 * spacing - collectionViewTitleHeight) / 4)
        
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        collectionView.collectionViewLayout = layout
    }
    
    override func viewDidLayoutSubviews() {
        // safeArea는 이 메서드 이후에 확정되기 때문에, 이곳에 safeArea를 이용한 UI구성을 해주어야한다.
        setFlowLayout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
        setContraints()
    }
    
    private func configuration() {
        searchBar.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
    }
    
    private func setContraints() {
        navigationItem.titleView = searchBar
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}


extension CollectionViewPractice: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .brown
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 5.0
        return cell
    }
    
}

extension CollectionViewPractice: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath)
            headerView.backgroundColor = .lightGray
            return headerView
        } else {
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: collectionViewTitleHeight)
    }
}

extension CollectionViewPractice: UISearchBarDelegate {
    
}
