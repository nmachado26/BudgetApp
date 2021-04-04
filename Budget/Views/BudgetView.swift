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


struct BudgetView: View {
    
    @EnvironmentObject var dataModel: BudgetModel
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
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(dataModel.budgetsData.indices, id: \.self) { i in
                            BudgetCell(budgetItem: $dataModel.budgetsData[i])
                        }
                    }
                    .padding(.horizontal, 0)
                    .padding(.top, 20)
                }
                .environmentObject(dataModel)
                .sheet(isPresented: $showingAddBudgetView) {
                    AddBudgetView(isPresented: $showingAddBudgetView)
                }
                .navigationBarTitle("Budget", displayMode: .inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            self.showingAddBudgetView = true
                        }, label: {
                            Image(systemName: "plus")
                        })
                        .sheet(isPresented: $showingAddBudgetView) {
                            AddBudgetView(isPresented: $showingAddBudgetView)
                        }
                    }
                }
                //.navigationBarHidden(true)
            }
        }
    }
}

struct BudgetCell : View {
    
    @Binding var budgetItem: Budget
    
    var body: some View {
        VStack {
            NavigationLink(destination: BudgetDetail(budget: $budgetItem)) {
                ZStack {
                    Rectangle()
                        .frame(width: 80, height: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .foregroundColor(cellBackgroundColor)
                        .cornerRadius(15)
                    Text(budgetItem.emojiString)
                        .font(emojiFont)
                }
            }
            Text(budgetItem.title)
                .font(bold14Font)
            Text("$\(budgetItem.remainingValue()) left")
                .font(medium13Font)
            
        }
    }
}
