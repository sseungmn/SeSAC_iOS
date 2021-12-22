//
//  CollectionViewCell+Extension.swift
//  SearchTheTVShow
//
//  Created by SEUNGMIN OH on 2021/12/22.
//

import UIKit

protocol ReusableView {
    static var reuseIdentifier: String { get }
}

//extension UICollectionViewCell: ReusableView {
//    static var reuseIdentifier: String {
//        return String(describing: self)
//    }
//}

extension UICollectionReusableView: ReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
