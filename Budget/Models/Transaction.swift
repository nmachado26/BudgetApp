//
//  Transaction.swift
//  Budget
//
//  Created by Nicolas Machado on 4/10/21.
//

import Foundation
import UIKit
import SwiftUI
import RealmSwift
import Realm

class Transaction: Object, Identifiable {

    @objc dynamic var id = UUID().uuidString //needed to change to string prop accordign to Realm docs
    @objc dynamic var value: Int = 0
    @objc dynamic var memo: String = ""
    @objc dynamic var date: Date = Date()


    convenience init(value: Int, memo: String, date: Date) {

        self.init()

        self.value = value
        self.memo = memo
        self.date = date
    }

    override static func primaryKey() -> String? {
        return "id"
      }
}

