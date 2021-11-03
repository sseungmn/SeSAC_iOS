//
//  String+Extension.swift
//  SeSAC_WEEK06
//
//  Created by OHSEUNGMIN on 2021/11/01.
//

import Foundation

extension String {
//    var localized: String {
//        return NSLocalizedString(self, comment: "")
//    }
    
    func localized(tableName: String = "Localizable") -> String {
        return NSLocalizedString(self, tableName: tableName, bundle: .main, value: "", comment: "")
    }
    
}

extension Date {
    func toString() -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy년 MM월 dd일"
        return dateFormat.string(from: self)
    }
}
