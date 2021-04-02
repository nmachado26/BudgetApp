//
//  RecurringView.swift
//  Budget
//
//  Created by Nicolas Machado on 4/2/21.
//

import SwiftUI

struct RecurringView: View {
    
    let recurringCosts = [
        RecurringCost(emojiString: "😂", title: "Food", value: 120, frequency: "Weekly"),
        RecurringCost(emojiString: "✅", title: "Check", value: 120, frequency: "Monthly"),
        RecurringCost(emojiString: "🚀", title: "Rocket", value: 10, frequency: "Monthly")
    ]
    
    var body: some View {
        VStack(alignment: .leading){
            Spacer()
            Text("Recurring")
                .font(.title)
                .padding(.leading, 16)
            List(recurringCosts) { recurringItem in
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

struct RecurringView_Previews: PreviewProvider {
    static var previews: some View {
        RecurringView()
    }
}
