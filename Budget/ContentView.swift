//
//  ContentView.swift
//  Budget
//
//  Created by Nicolas Machado on 4/2/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selection = 0 //selectedtab
    @State var dataModel = BudgetModel()
    
    var body: some View {
        TabView(selection: $selection) {
            CalculatorView(dataModel: self.$dataModel).tabItem {
                selection == 0 ? Image(systemName: "house.fill") : Image(systemName: "house")
                Text("Home")
            }.tag(0)
            BudgetView(dataModel: self.$dataModel).tabItem {
                selection == 1 ? Image(systemName: "house.fill") : Image(systemName: "house")
                Text("Budget")
            }.tag(1)
            RecurringsView(dataModel: self.$dataModel).tabItem {
                selection == 2 ? Image(systemName: "house.fill") : Image(systemName: "house")
                Text("Recurring")
            }.tag(2)
            OverviewView(dataModel: self.$dataModel).tabItem {
                selection == 3 ? Image(systemName: "house.fill") : Image(systemName: "house")
                Text("Overview")
            }.tag(3)
        }.accentColor(primaryColor)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
