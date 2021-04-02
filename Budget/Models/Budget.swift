//
//  Budget.swift
//  Budget
//
//  Created by Nicolas Machado on 4/2/21.
//

import Foundation
import UIKit
import SwiftUI

struct Budget: Identifiable, Hashable {
    
    //why does this not work with Class, but does with struct?
    
    var id = UUID()
    var emojiString: String
    var title: String
    var budgetedValue: Int
    var spendType: String
    
    var currentSpend: Int = 0
    
    init(emojiString: String, title: String, budgetedValue: Int, spendType: String) {
        
        self.emojiString = emojiString
        self.title = title
        self.budgetedValue = budgetedValue
        self.spendType = spendType
 
    }
    
    func remainingValue() -> Int {
        return budgetedValue - currentSpend
    }


}
