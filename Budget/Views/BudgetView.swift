//
//  BudgetView.swift
//  Budget
//
//  Created by Nicolas Machado on 4/2/21.
//

import SwiftUI

//https://www.hackingwithswift.com/quick-start/swiftui/how-to-position-views-in-a-grid-using-lazyvgrid-and-lazyhgrid

struct BudgetView: View {
    
    let budgets = [
        Budget(emojiString: "🚀", title: "Food", budgetedValue: 120, spendType: "Need"),
        Budget(emojiString: "🚀", title: "Food", budgetedValue: 120, spendType: "Need"),
        Budget(emojiString: "🚀", title: "Food", budgetedValue: 120, spendType: "Need"),
        Budget(emojiString: "🚀", title: "Food", budgetedValue: 120, spendType: "Need"),
        Budget(emojiString: "🚀", title: "Food", budgetedValue: 120, spendType: "Need")
    ]
    
    let data = (1...100).map { "Item \($0)" }
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Recurring")
                .font(.title)
                .padding(.leading, 16)
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(budgets, id: \.self) { budgetItem in
                        BudgetCell(budgetItem: budgetItem)
                    }
                }
                .padding(.horizontal, 0)
                .padding(.top, 20)
            }
        }
    }
}

struct BudgetCell : View {
    
    var budgetItem: Budget
    
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .frame(width: 80, height: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.black)
                    .opacity(0.1)
                    .cornerRadius(15)
                Text(budgetItem.emojiString)
                    .font(.title)
            }
            Text(budgetItem.title)
            Text("$\(budgetItem.remainingValue()) left")
            
        }
    }
}

struct BudgetView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetView()
    }
}
