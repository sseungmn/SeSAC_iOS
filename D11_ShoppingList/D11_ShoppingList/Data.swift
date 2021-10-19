//
//  Data.swift
//  D11_ShoppingList
//
//  Created by OHSEUNGMIN on 2021/10/14.
//

import Foundation

struct Item {
    var didBought: Bool
    let title: String
    var didBookmark: Bool
    
    init(title: String){
        self.title = title
        didBought = false
        didBookmark = false
    }
}

//class ShoppingList {
//    static var shared = ShoppingList()
//
//    // userdefaults에 custom object 저장하는 방법 공부 필요
//    private var shoppingList: [Item] {
//        guard let shoppingList = UserDefaults.standard.array(forKey: "shoppingList") as? [Item] else {
//            return [Item]()
//        }
//        return shoppingList
//    }
//
//    var count: Int  { return shoppingList.count }
//
//    func getItem(row: Int) -> Item {
//        return shoppingList[row]
//    }
//
//    func update(command: Command, item: Item? = nil, row: Int? = nil) {
//        var tmpShoppingList = shoppingList
//        switch command {
//        case .append:
//            tmpShoppingList.append(item!)
//        case .delete:
//            tmpShoppingList.remove(at: row!)
//        }
//        UserDefaults.standard.set(tmpShoppingList, forKey: "shoppingList")
//    }
//}
//
//enum Command {
//    case append
//    case delete
//}
