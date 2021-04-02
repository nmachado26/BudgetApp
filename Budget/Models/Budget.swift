//
//  Budget.swift
//  Budget
//
//  Created by Nicolas Machado on 4/2/21.
//

import Foundation
import UIKit
import SwiftUI

class Budget: Identifiable {
    
    var id = UUID()
    var emojiString: String
    var title: String
    var value: Double
    var spendType: String
    
    init(emojiString: String, title: String, value: Double, spendType: String) {
        self.emojiString = emojiString
        self.title = title
        self.value = value
        self.spendType = spendType
    }

}
