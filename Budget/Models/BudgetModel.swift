//
//  BudgetModel.swift
//  Budget
//
//  Created by Nicolas Machado on 4/3/21.
//

import Foundation

final class BudgetModel {
    
    var budgetsData: [Budget]
    var recurringsData: [RecurringCost]
    
    init() {
        self.budgetsData = [
            Budget(emojiString: "🍔", title: "Food", budgetedValue: 300, spendType: "Need"),
            Budget(emojiString: "☕️", title: "Coffee", budgetedValue: 80, spendType: "Want"),
            Budget(emojiString: "💗", title: "Dates", budgetedValue: 200, spendType: "Want"),
        ]
        
        self.recurringsData = [
            RecurringCost(emojiString: "🏋️‍♀️", title: "Gym", value: 120, frequency: "Monthly"),
            RecurringCost(emojiString: "🏠", title: "Rent", value: 1300, frequency: "Monthly"),
            RecurringCost(emojiString: "🎥", title: "Netflix", value: 10, frequency: "Monthly")
        ]
    }
    
    func addBudget(budget: Budget) {
        self.budgetsData.insert(budget, at: 0)
    }
    
    //why does class func not allow access to my lists (budgetsData)?
    func addRecurring(recurringItem: RecurringCost) {
        self.recurringsData.insert(recurringItem, at: 0)
    }
    
    func addExpense(budget: Budget, expenseString: String) {
        guard let i = self.budgetsData.firstIndex(of: budget) else {
            print("ERROR addExpense. no instance of budget found")
            return
        }
        guard let expense = Int(expenseString) else {
            print("ERROR addExpense. expense cant be converted to int")
            return
        }
        let updatedBudget = Budget(emojiString: budget.emojiString, title: budget.title, budgetedValue: budget.budgetedValue - expense, spendType: budget.spendType)
        self.budgetsData.insert(updatedBudget, at: i)
        self.budgetsData.remove(at: i+1)
    }
}
