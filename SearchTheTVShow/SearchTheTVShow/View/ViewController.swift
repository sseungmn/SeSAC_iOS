//
//  ViewController.swift
//  SearchTheTVShow
//
//  Created by SEUNGMIN OH on 2021/12/21.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
  let collectionViewTitleHeight: CGFloat = 30

  let searchAPI = tmdbAPI()
  var tvShowData: TVShow?
  
  let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
  let searchBar: UISearchBar = {
    let searchBar = UISearchBar()
    searchBar.placeholder = "Search TV Show"
    return searchBar
  }()
  
  // MARK: Set CollectionView
  func setFlowLayout() {
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

    navigationItem.titleView = searchBar
    searchBar.delegate = self

    view.addSubview(collectionView)
    collectionView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
 
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.register(
      TVShowCollectionViewCell.self,
      forCellWithReuseIdentifier: TVShowCollectionViewCell.reuseIdentifier)
    collectionView.register(
      TVShowCollectionViewHeader.self,
      forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
      withReuseIdentifier: TVShowCollectionViewHeader.reuseIdentifier)
  }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return tvShowData?.results.count ?? 0
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: TVShowCollectionViewCell.reuseIdentifier,
      for: indexPath) as? TVShowCollectionViewCell else { return UICollectionViewCell() }
    cell.setPosterImage(path: tvShowData?.results[indexPath.row].posterPath)

    return cell
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    if let cell = collectionView.cellForItem(at: indexPath) as? TVShowCollectionViewCell {
      cell.flash()
    }
    print(tvShowData?.results[indexPath.row].originalName)
    print(tvShowData?.results[indexPath.row].id)
  }
}

// MARK: CollectionView Header
extension ViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    if kind == UICollectionView.elementKindSectionHeader {
      let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TVShowCollectionViewHeader.reuseIdentifier, for: indexPath)
      return headerView
    } else {
      return UICollectionReusableView()
    }
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    return CGSize(width: view.frame.width, height: collectionViewTitleHeight)
  }
}

extension ViewController: UISearchBarDelegate {
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    print("검색 시작")
    if let query = searchBar.text, !query.isEmpty {
      search(for: query)
    }
  }

  func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    print("검색 시작")
    if let query = searchBar.text, !query.isEmpty {
      search(for: query)
    }
  }

  func search(for query: String) {
    searchAPI.requestTVShow(query: query) { tvShow in
      print("성공")
      self.tvShowData = tvShow

      DispatchQueue.main.async {
        self.collectionView.reloadData()
      }
    }

  }
}
