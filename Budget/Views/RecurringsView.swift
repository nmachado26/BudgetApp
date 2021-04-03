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

    @Binding var dataModel: BudgetModel
    @State private var showingAddBudgetView = false

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]

    var body: some View {


        NavigationView {
            VStack(alignment: .leading){
                ScrollView {
                    HStack() {
                        Spacer()

                        Button(action: {
                            self.showingAddBudgetView = true
                        }, label: {
                            Image(systemName: "plus")
                        })
                        .sheet(isPresented: $showingAddBudgetView) {
                            AddRecurringCostView(dataModel: $dataModel, isPresented: $showingAddBudgetView)
                        }

                    }
                    .padding(.horizontal, 16)

                    Text(dataModel.testStr)
                    //LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(dataModel.recurringsData.indices, id: \.self) { i in
                            RefreshCell(recurringItem: $dataModel.recurringsData[i])
                        }
                    //}
                    .padding(.horizontal, 0)
                    .padding(.top, 20)
                }
                .navigationBarTitle("Refresh")
                //.navigationBarHidden(true)
            }
        }
    }
}

struct RefreshCell : View {

    @Binding var recurringItem: RecurringCost

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
