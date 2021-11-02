//
//  UIFont + Extension.swift
//  SeSAC_WEEK06
//
//  Created by OHSEUNGMIN on 2021/11/01.
//

import UIKit

//====> S-CoreDream-2EextraLight
//====> S-CoreDream-5Medium
//====> S-CoreDream-9Black

//====> GowunBatang-Regular
//====> GowunBatang-Bold

extension UIFont {
    var mainBlack: UIFont {
        return UIFont(name: "S-CoreDream-9Black", size: 14)!
    }
    var batang: UIFont {
        return UIFont(name: "GowunBatang-Regular", size: 14)!
    }
}
