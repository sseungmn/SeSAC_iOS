//
//  UITableViewCell+Extension.swift
//  RecommendTheBeer
//
//  Created by SEUNGMIN OH on 2021/12/27.
//

import UIKit

protocol ReusableView {
    static var reuseIdentifier: String { get }
}

extension UITableViewCell: ReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
