//
//  Budget.swift
//  Budget
//
//  Created by Nicolas Machado on 4/2/21.
//

import Foundation
import UIKit
import SwiftUI
import RealmSwift
import Realm

//why does this not work with Class, but does with struct?


// Realm migration necessary when editing the db models https://stackoverflow.com/questions/51661056/unable-to-do-a-realm-migration-in-swift
class Budget: Object, Identifiable {

//    static func == (lhs: Budget, rhs: Budget) -> Bool {
//        if lhs.title == rhs.title { return true }
//        return false
//    }

    @objc dynamic var id = UUID().uuidString //needed to change to string prop accordign to Realm docs
    @objc dynamic var emojiString: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var budgetedValue: Int = 0
    @objc dynamic var spendType: String = ""
    
    let transactions  = RealmSwift.List<Transaction>()
    //@objc dynamic var transactions: [Transaction] = [Transaction]()

    @objc dynamic var currentSpend: Int = 0


    //why convenience? https://stackoverflow.com/questions/41092582/fatal-error-use-of-unimplemented-initializer-init-for-class
    //https://docs.swift.org/swift-book/LanguageGuide/Initialization.html#//apple_ref/doc/uid/TP40014097-CH18-XID_331 init docs


    convenience init(emojiString: String, title: String, budgetedValue: Int, spendType: String) {

        self.init()

        self.emojiString = emojiString
        self.title = title
        self.budgetedValue = budgetedValue
        self.spendType = spendType

    }

    override static func primaryKey() -> String? {
        return "id"
      }

    func remainingValue() -> Int {
        return budgetedValue - currentSpend
    }
    
    func addTransaction(transaction: Transaction) {
        let realm = try! Realm()
        try! realm.write {
            self.transactions.insert(transaction, at: 0)
        }
    }


}
