//
//  BudgetView.swift
//  Budget
//
//  Created by Nicolas Machado on 4/2/21.
//

import SwiftUI

//https://www.hackingwithswift.com/quick-start/swiftui/how-to-position-views-in-a-grid-using-lazyvgrid-and-lazyhgrid

//https://www.hackingwithswift.com/articles/216/complete-guide-to-navigationview-in-swiftui

//https://github.com/markvanwijnen/NavigationBarLargeTitleItems


struct RecurringsView: View {
    
    @EnvironmentObject var dataModel: BudgetModel
    @State private var showingAddRecurringView = false
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        
        
        NavigationView {
            VStack(alignment: .leading){
                ScrollView {
                    ForEach(dataModel.recurringsData.indices, id: \.self) { i in
                        RecurringCell(recurringItem: $dataModel.recurringsData[i])
                            .padding(.bottom, 16)
                    }
                    .sheet(isPresented: $showingAddRecurringView) {
                        AddRecurringCostView(isPresented: $showingAddRecurringView)
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 24)
                }
                .environmentObject(dataModel)
                .navigationBarTitle("Recurring", displayMode: .inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            self.showingAddRecurringView = true
                        }, label: {
                            Image(systemName: "plus")
                        })
                    }
                }
            }
        }
    }
}

struct RecurringCell : View {
    
    @Binding var recurringItem: RecurringCost
    
    var body: some View {
        HStack {
            ZStack {
                Rectangle()
                    .frame(width: 80, height: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .foregroundColor(cellBackgroundColor)
                    .cornerRadius(15)
                Text(recurringItem.emojiString)
                    .font(emojiFont)
            }
            Text(recurringItem.title)
                .font(bold18Font)
            Spacer()
            Text("$\(recurringItem.monthlyCost) / mo ")
                .font(medium14Font)
        }.padding(.horizontal, 0)
    }
}
