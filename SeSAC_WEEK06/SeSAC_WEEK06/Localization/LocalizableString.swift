//
//  LocalizableString.swift
//  SeSAC_WEEK06
//
//  Created by OHSEUNGMIN on 2021/11/01.
//

import Foundation

enum LocalizableString: String {
    case welcome_text
    case data_backup
    
    var localized: String {
        return self.rawValue.localized() // Localizable.strings
    }
    
    var localizedSetting: String {
        return self.rawValue.localized(tableName: "Setting") // Setting.strings
    }
}
