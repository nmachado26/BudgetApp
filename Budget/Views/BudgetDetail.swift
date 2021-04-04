//
//  BudgetDetail.swift
//  Budget
//
//  Created by Nicolas Machado on 4/4/21.
//

import SwiftUI

struct BudgetDetail: View {
    
    @EnvironmentObject var dataModel: BudgetModel
    @Binding var budget: Budget
    
    var body: some View {
        Text("Hello W")
//        List(dataModel.budgetsData.filter({ $0.title == budget.title })){ item in
//            HStack {
//                Text(budget.title)
//            }
//        }
    }
    
}

