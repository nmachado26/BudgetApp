//
//  RecurringCost.swift
//  Budget
//
//  Created by Nicolas Machado on 4/2/21.
//

import Foundation
import UIKit


class RecurringCost {
    var emojiString: String
    var title: String
    var value: Double
    var frequency: String
    var monthlyCost: Double = 0 // want to make this nonoptional, but not in init.
    
    init(emojiString: String, title: String, value: Double, frequency: String) {
        self.emojiString = emojiString
        self.title = title
        self.value = value
        self.frequency = frequency
        
        self.convertToMonthlyCost()
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
