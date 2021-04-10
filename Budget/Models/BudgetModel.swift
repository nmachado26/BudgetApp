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
    @Published var budgetsData: [Budget]
    @Published var recurringsData: [RecurringCost]

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

    }

    func addBudget(budget: Budget) {

        let realm = try! Realm()
        try! realm.write {
            realm.add(budget)
            print("added budget to realm")
        }

        self.budgetsData.insert(budget, at: 0)


    }

    //why does class func not allow access to my lists (budgetsData)?
    func addRecurring(recurringItem: RecurringCost) {
        
        let realm = try! Realm()
        try! realm.write {
            realm.add(recurringItem)
            print("added recurring cost to realm")
        }

        self.recurringsData.insert(recurringItem, at: 0)
        print("hello")
    }

    func addExpense(budget: Budget, transaction: Transaction) {
//        guard let i = self.budgetsData.firstIndex(of: budget) else {
//            print("ERROR addExpense. no instance of budget found")
//            return
//        }

//        budget.currentSpend = budget.currentSpend + expense
//        let updatedBudget = Budget(emojiString: budget.emojiString, title: budget.title, budgetedValue: budget.budgetedValue - expense, spendType: budget.spendType)
//        self.budgetsData.insert(updatedBudget, at: i)
//        self.budgetsData.remove(at: i+1)


        let realm = try! Realm()
        try! realm.write {
            budget.currentSpend = budget.currentSpend + transaction.value
        }
        
        budget.addTransaction(transaction: transaction)
        
        
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
    
    func getPercentSpent() -> Double {
        return Double(getTotalSpent()) / Double(getTotalBudget())
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
        
        for recurringItem in recurringsData.filter({ $0.spendType == "need" }) {
            needSum = needSum + recurringItem.monthlyCost
        }
        
        return needSum
    }
    
    func getChartDataModel() -> [ChartCellModel]{
        let sample = [ ChartCellModel(color: turquoiseColor, value: CGFloat(getWantsSpent()), name: "Wants"),
                       ChartCellModel(color: orangeColor, value: CGFloat(getNeedsSpent()), name: "Needs"),
                       ChartCellModel(color: unfilledChartColor, value: CGFloat(getAmountSaved()), name: "Saved"),]
        return sample
    }
}
