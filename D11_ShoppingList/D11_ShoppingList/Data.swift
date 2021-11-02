//
//  Data.swift
//  D11_ShoppingList
//
//  Created by OHSEUNGMIN on 2021/10/14.
//

import Foundation
import RealmSwift

//struct Item {
//    var didBought: Bool
//    let title: String
//    var didBookmark: Bool
//
//    init(title: String){
//        self.title = title
//        didBought = false
//        didBookmark = false
//    }
//}

class Item: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var title: String
    @Persisted var bought: Bool
    @Persisted var bookmarked: Bool
    
    convenience init(title: String) {
        self.init()
        self.title = title
        self.bought = false
        self.bookmarked = false
    }
}
