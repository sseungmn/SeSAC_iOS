//
//  CollectionViewController.swift
//  D06_beamin
//
//  Created by OHSEUNGMIN on 2021/10/05.
//

import UIKit

struct ImageInfo {
    let name: String
    let image: UIImage?
    
    init(name: String, image: UIImage) {
        self.name = name
        self.image = image
    }
}

class CollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    // viewModel 변수를 추가
    let viewModel = ImageViewModel()
    
    // viewModel에서 count를 가져옴
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(viewModel.countOfImageList)
        return viewModel.countOfImageList
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as?
                Cell else {
                    print("failed")
                    return UICollectionViewCell()
                }
        let imageInfo = viewModel.imageInfo(at: indexPath.item)
        print(imageInfo)
        cell.update(info: imageInfo)
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}


class Cell: UICollectionViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    func update(info: ImageInfo) {
        imgView.image = info.image
        nameLabel.text = info.name
    }
}

// view Model
class ImageViewModel {
    let imageInfoList: [ImageInfo] = [
        ImageInfo(name: "가재", image: UIImage(named: "mono_baedal01")!),
        ImageInfo(name: "밥", image: UIImage(named: "mono_baedal04")!),
        ImageInfo(name: "떡볶이", image: UIImage(named: "mono_baedal05")!),
        ImageInfo(name: "컵케익", image: UIImage(named: "mono_baedal06")!),
        ImageInfo(name: "초밥", image: UIImage(named: "mono_baedal07")!),
        ImageInfo(name: "치킨", image: UIImage(named: "mono_baedal08")!),
        ImageInfo(name: "피자", image: UIImage(named: "mono_baedal09")!),
        ImageInfo(name: "덮밥", image: UIImage(named: "mono_baedal10")!),
        ImageInfo(name: "족발", image: UIImage(named: "mono_baedal12")!)
    ]
    
    var countOfImageList: Int {
        return imageInfoList.count
    }
    
    func imageInfo(at index: Int) -> ImageInfo {
        return imageInfoList[index]
    }
}
