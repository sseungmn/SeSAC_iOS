//
//  ViewController.swift
//  D07_EmotionDiary
//
//  Created by OHSEUNGMIN on 2021/10/07.
//

import UIKit

class ViewController: UIViewController{
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        
        layout.scrollDirection = .vertical
        layout.sectionInset = .zero
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        
        // collectionView의 Autoresizing mask를 false로 지정
        // 코드로 constraints를 지정해줄 것이기 때문에
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundImageView = UIImageView()
        backgroundImageView.image = UIImage(named: "contentBackground")
        view.addSubview(backgroundImageView)
        backgroundImageView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        
        setupCollectionView()
    }
    
}

// MARK: - CollectionView

extension ViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func setupCollectionView() {
        self.view.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // 재사용되는 cell의 id를 collectionvView에 등록한다.
        collectionView.register(emotionCell.self, forCellWithReuseIdentifier: "emotionCell")
        
        // superView에 대한 collectionView의 constraints를 지정.
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -40),
            collectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 250),
            
            // height = width * 0.9 + 0
            collectionView.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9, constant: 0)
        ])
    }
    
    // cell의 개수를 정한다.
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    // cell에 들어갈 객체를 정한다.
    // as?를 통해 원하는 cell class로 캐스팅해주면, 해당 클래스의 메서드를 사용할 수 있다.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "emotionCell", for: indexPath) as? emotionCell else {
            print("failed")
            return UICollectionViewCell()
        }
        
        cell.setInfo(info: EmotionInfo(index: indexPath.item))
        return cell
    }
    
    // item별 size를 계산한다.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height = collectionView.frame.height
        
        let itemsPerRow: CGFloat = 3
        let widthPadding = 10 * (itemsPerRow + 1)
        let itemsPerColumn: CGFloat = 3
        let heightPadding = 10 * (itemsPerColumn + 1)
        
        let cellWidth = (width - widthPadding) / itemsPerRow
        let cellHeight = (height - heightPadding) / itemsPerColumn
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    // line사이의 간격을 계산
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}

// MARK: - CollectionViewCell

struct EmotionInfo {
    let emotionTitles = ["행복해", "사랑해", "좋아해",
                         "당황해", "지루해", "답답해",
                         "난감해", "우울해", "비참해"
    ]
    
    let image: UIImage?
    let title: String
    
    init(index: Int) {
        self.image = UIImage(named: "mono_slime\(index+1)")
        self.title = emotionTitles[index]
    }
}

class emotionCell : UICollectionViewCell {
    let button = UIButton()
    let titleLabel = UILabel()
    let countLabel = UILabel()
    
    let spacing: CGFloat = 5 // button과 text사이의 간격을 지정
    let textSize: CGFloat = 17
    let titleWidth: CGFloat = 50

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel.font = UIFont.systemFont(ofSize: textSize)
        countLabel.text = String(0)
        countLabel.font = UIFont.systemFont(ofSize: textSize)
        
        self.addSubview(button)
        self.addSubview(titleLabel)
        self.addSubview(countLabel)
        
        
        button.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height - (textSize + spacing))
        titleLabel.frame = CGRect(x: (self.frame.width - titleWidth) / 2, y: self.frame.height - textSize, width: titleWidth, height: textSize)
        countLabel.frame = CGRect(x: (self.frame.width + titleWidth) / 2, y: self.frame.height - textSize, width: titleWidth / 2, height: textSize)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setInfo(info: EmotionInfo) {
        self.button.setImage(info.image, for: .normal)
        self.titleLabel.text = info.title
    }
}

// MARK: - Preview

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct Preview: PreviewProvider{
    static var previews: some View {
        UIViewPreview {
            let cell = emotionCell()
            cell.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
            return cell
        }.previewLayout(.sizeThatFits)
    }
}
#endif

#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct UIViewPreview<View: UIView>: UIViewRepresentable {
    let view: View

    init(_ builder: @escaping () -> View) {
        view = builder()
    }

    // MARK: - UIViewRepresentable

    func makeUIView(context: Context) -> UIView {
        return view
    }

    func updateUIView(_ view: UIView, context: Context) {
        view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        view.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
}
#endif
