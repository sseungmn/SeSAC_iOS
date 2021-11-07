//
//  RealmQuery.swift
//  SeSAC_WEEK06
//
//  Created by OHSEUNGMIN on 2021/11/06.
//

import Foundation
import UIKit
import RealmSwift

extension UIViewController {
    func searchQueryFromUserDiary(text: String) -> Results<UserDiary> {
        let localRealm = try! Realm()
        
        let search = localRealm.objects(UserDiary.self).filter("diaryTitle CONTAINS[c] '\(text)' OR content CONTAINS[c] '\(text)'")
        
        return search
    }
    
    func getAllDiaryCountFromUserDiary() -> Int {
        let localRealm = try! Realm()
        
        return localRealm.objects(UserDiary.self).count
    }
}
