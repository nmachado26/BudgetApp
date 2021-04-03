//
//  RecurringView.swift
//  Budget
//
//  Created by Nicolas Machado on 4/2/21.
//

import SwiftUI

struct RecurringView: View {
    
    @Binding var dataModel: BudgetModel
    
    var body: some View {
        VStack(alignment: .leading){
            Spacer()
            Text("Recurring")
                .font(.title)
                .padding(.leading, 16)
            List(dataModel.recurringsData) { recurringItem in
                RecurringRow(recurringItem: recurringItem)
                    .padding(.vertical, 20)
            }.padding(.top, 10)
        }
    }
}

struct RecurringRow : View {
    
    var recurringItem: RecurringCost
    
    var body: some View {
        HStack {
            ZStack {
                Rectangle()
                    .frame(width: 80, height: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.black)
                    .opacity(0.1)
                    .cornerRadius(15)
                Text(recurringItem.emojiString)
                    .font(.title)
            }
            Text(recurringItem.title)
            Spacer()
            Text("$\(recurringItem.monthlyCost) / mo ")
        }.padding(.horizontal, 0)
    }
}

//struct RecurringView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecurringView()
//    }
//}
