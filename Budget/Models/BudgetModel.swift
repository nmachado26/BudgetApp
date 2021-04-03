//
//  BudgetModel.swift
//  Budget
//
//  Created by Nicolas Machado on 4/3/21.
//

import Foundation
import RealmSwift

final class BudgetModel: ObservableObject {

    //ssoooooo inefficient. Make the BudgetModel a binding everywhere. temp solution
    var budgetsData: [Budget]
    var recurringsData: [RecurringCost]
    var testStr: String

    //var realm: Realm - don't do singleton yet

    init() {

        do {
            let realm = try Realm()
        } catch {
            print(error.localizedDescription)
        }

        let realm = try! Realm()
        self.budgetsData = realm.objects(Budget.self).toArray(type: Budget.self)


        self.recurringsData = realm.objects(RecurringCost.self).toArray(type: RecurringCost.self)

        
        self.testStr = "Before"
        
        self.budgetsData.append(contentsOf: [
            Budget(emojiString: "🍔", title: "Food", budgetedValue: 300, spendType: "need"),
            Budget(emojiString: "☕️", title: "Coffee", budgetedValue: 80, spendType: "want"),
            Budget(emojiString: "💗", title: "Dates", budgetedValue: 200, spendType: "want"),
        ])
        
        self.recurringsData.append(contentsOf: [
            RecurringCost(emojiString: "🏋️‍♀️", title: "Gym", value: 120, spendType: "need"),
            RecurringCost(emojiString: "🏠", title: "Rent", value: 1300, spendType: "need"),
            RecurringCost(emojiString: "🎥", title: "Netflix", value: 10, spendType: "want")
        ])

    }

    func addBudget(budget: Budget) {

        self.testStr = "SUCCESS"
        let realm = try! Realm()
        try! realm.write {
            realm.add(budget)
            print("added budget to realm")
        }

        self.budgetsData.insert(budget, at: 0)


    }

    //why does class func not allow access to my lists (budgetsData)?
    func addRecurring(recurringItem: RecurringCost) {
        self.testStr = "SUCCESS"
        
        let realm = try! Realm()
        try! realm.write {
            realm.add(recurringItem)
            print("added recurring cost to realm")
        }

        self.recurringsData.insert(recurringItem, at: 0)
        print("hello")
    }

    func addExpense(budget: Budget, expenseString: String) {
//        guard let i = self.budgetsData.firstIndex(of: budget) else {
//            print("ERROR addExpense. no instance of budget found")
//            return
//        }
        guard let expense = Int(expenseString) else {
            print("ERROR addExpense. expense cant be converted to int")
            return
        }
//        budget.currentSpend = budget.currentSpend + expense
//        let updatedBudget = Budget(emojiString: budget.emojiString, title: budget.title, budgetedValue: budget.budgetedValue - expense, spendType: budget.spendType)
//        self.budgetsData.insert(updatedBudget, at: i)
//        self.budgetsData.remove(at: i+1)


        let realm = try! Realm()
        try! realm.write {
            budget.currentSpend = budget.currentSpend + expense
        }
        print("hi")
    }
}

extension BudgetModel {
    
    //overview fetch methods
    
    func getTotalBudget() -> Int{
        
        var sum = 0
        for budget in budgetsData {
            sum =  sum + budget.budgetedValue
        }
        
        for recurring in recurringsData {
            sum = sum + recurring.monthlyCost
        }
        
        return sum
    }
    
    func getTotalSpent() -> Int{
        
        var budgetSpend = 0
        for budget in budgetsData {
            budgetSpend =  budgetSpend + budget.currentSpend
        }
        
        var recurringSpend = 0
        for recurringItem in recurringsData {
            recurringSpend = recurringSpend + recurringItem.monthlyCost
        }
      
        return budgetSpend + recurringSpend
    }
    
    func getAmountSaved() -> Int {
        
        var saved = 0
        for budget in budgetsData {
            saved =  saved + budget.remainingValue()
        }
        
        return saved
    }
    
    func getWantsSpent() -> Int {
        
        var wantSum = 0
        
        for budget in budgetsData.filter({ $0.spendType == "want" }) {
            wantSum = wantSum + budget.currentSpend
        }
        
        for recurringItem in recurringsData.filter({ $0.spendType == "want" }) {
            wantSum = wantSum + recurringItem.monthlyCost
        }
        
        return wantSum
    }
    
    func getNeedsSpent() -> Int {
        
        var needSum = 0
        
        for budget in budgetsData.filter({ $0.spendType == "need" }) {
            needSum = needSum + budget.currentSpend
        }
        
        for recurringItem in recurringsData.filter({ $0.spendType == "want" }) {
            needSum = needSum + recurringItem.monthlyCost
        }
        
        return needSum
    }
}
