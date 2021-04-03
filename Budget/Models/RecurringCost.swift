//
//  RecurringCost.swift
//  Budget
//
//  Created by Nicolas Machado on 4/2/21.
//

import Foundation
import UIKit
import RealmSwift
import Realm


class RecurringCost: Object, Identifiable {

    @objc dynamic var id = UUID().uuidString
    @objc dynamic var emojiString: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var value: Int = 0
    @objc dynamic var frequency: String = ""
    @objc dynamic var monthlyCost: Int = 0 // want to make this nonoptional, but not in init.

    convenience init(emojiString: String, title: String, value: Int, frequency: String) {

        self.init()

        self.emojiString = emojiString
        self.title = title
        self.value = value
        self.frequency = frequency

        self.convertToMonthlyCost()
    }

    override static func primaryKey() -> String? {
        return "id"
      }

    func convertToMonthlyCost() {
        if frequency == "Weekly" {
            self.monthlyCost = value*4
        }
        else if frequency == "Monthly" {
            self.monthlyCost = value
        }
        else if frequency == "Yearly" {
            self.monthlyCost = value/12
        }
        else {
            print("Could not find frequency for recurring cost in RecurringCost init()")
        }
    }
}
