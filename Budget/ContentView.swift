//
//  ContentView.swift
//  Budget
//
//  Created by Nicolas Machado on 4/2/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selection = 0 //selectedtab
    @EnvironmentObject var dataModel : BudgetModel
    
    
    var body: some View {
        TabView(selection: $selection) {
            CalculatorView().tabItem {
                Image(systemName: "plus")
                Text("Add")
            }.tag(0)
            BudgetView().tabItem {
                Image(systemName: "creditcard")
                Text("Budget")
            }.tag(1)
            RecurringsView().tabItem {
                Image(systemName: "repeat")
                Text("Recurring")
            }.tag(2)
            OverviewView().tabItem {
                Image(systemName: "house")
                //selection == 3 ? Image(systemName: "house.fill") : Image(systemName: "house")
                Text("Overview")
            }.tag(3)
        }
        .accentColor(.black)
        .environmentObject(dataModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
