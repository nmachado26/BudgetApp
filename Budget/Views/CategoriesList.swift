//
//  CategoriesList.swift
//  Budget
//
//  Created by Nicolas Machado on 4/3/21.
//

import SwiftUI


//could probably reuse budgetsView by creating a wrapper class
struct CategoriesList: View {
    
    @Binding var dataModel: BudgetModel
    
    //replaced by dataModel.budgetsData
//    var budgetsData = [
//        Budget(emojiString: "🍔", title: "Food", budgetedValue: 300, spendType: "Need"),
//        Budget(emojiString: "☕️", title: "Coffee", budgetedValue: 80, spendType: "Want"),
//        Budget(emojiString: "💗", title: "Dates", budgetedValue: 200, spendType: "Want"),
//    ]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(self.dataModel.budgetsData, id: \.self) { budgetItem in
                        CategoryCell(budgetItem: budgetItem)
                    }
                }
                .padding(.horizontal, 0)
                .padding(.top, 20)
            }
        }
    }
}

//could probably reuse budgetsView by creating a wrapper class

struct CategoryCell : View {
    
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
            
        }
    }
}

//struct CategoriesList_Previews: PreviewProvider {
//    static var previews: some View {
//        CategoriesList()
//    }
//}
