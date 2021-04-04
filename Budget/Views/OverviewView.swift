//
//  OverviewView.swift
//  Budget
//
//  Created by Nicolas Machado on 4/2/21.
//

import SwiftUI

struct OverviewView: View {
    
    @EnvironmentObject var dataModel: BudgetModel
    
    var body: some View {
        
        backgroundGrayColor
            .ignoresSafeArea(.all) // Ignore just for the color
            .overlay(
                VStack(spacing: 24) {
                    StatusView()
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                        .padding(.top, 200)
                        .environmentObject(dataModel)
                    MonthlyView()
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 200)
                        .environmentObject(dataModel)
                }
            
            )
    
    }
}

struct StatusView: View {
    
    @EnvironmentObject var dataModel: BudgetModel
    
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Status")
                .font(bold18Font)
                .padding(.bottom, 8)
            HStack(spacing:5) {
                Text("$\(dataModel.getTotalBudget() - dataModel.getTotalSpent())")
                    .font(bold22Font)
                Text("left to spend")
                    .font(bold22Font)
            }
            ProgressBar(value: dataModel.getPercentSpent())
                .cornerRadius(10)
                .frame(height: 20)
                .padding(.bottom, 24)
            HStack {
                Rectangle()
                    .frame(width: 6, height: 20)
                    .cornerRadius(10) //overdone
                    .foregroundColor(.black)
                Text("Spent")
                    .font(bold16Font)
                Spacer()
                Text("$\(dataModel.getTotalSpent())")
                    .font(bold14Font)
            }
            HStack {
                Rectangle()
                    .frame(width: 6, height: 20)
                    .cornerRadius(10) //overdone
                    .foregroundColor(unfilledChartColor)
                Text("Budget")
                    .font(bold16Font)
                Spacer()
                Text("$\(dataModel.getTotalBudget())")
                    .font(bold14Font)
            }
            
        }
        .padding(.horizontal, 32)
        .padding(.vertical, 16)
        .background(Color(.white))
    }
}


struct MonthlyView : View {
    
    @EnvironmentObject var dataModel: BudgetModel
    
    @State var selectedDonut: String = ""
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text("January Outlook")
                .font(bold18Font)
                .padding(.top, 16)
                .padding(.bottom, 16)
            
            ZStack {
                DonutChart(dataModel: ChartDataModel.init(dataModel: dataModel.getChartDataModel()), onTap: {
                    dataModel in
                    if let dataModel = dataModel {
                        self.selectedDonut = "Spending Type: \(dataModel.name)\nAmount: \(dataModel.value)"
                    } else {
                        self.selectedDonut = ""
                    }
                })
                .frame(width: 260, height: 260, alignment: .center)
                .padding()
                VStack {
                    Text("This month")
                        .font(bold14Font)
                    Text("$\(dataModel.getTotalSpent())")
                        .font(bold18Font)
                }
            }
            Spacer()
            VStack {
                ForEach(dataModel.getChartDataModel()) { dataSet in
                    HStack {
                        Rectangle()
                            .frame(width: 6, height: 20)
                            .cornerRadius(10) //overdone
                            .foregroundColor(dataSet.color)
                        Text(dataSet.name)
                            .font(bold16Font)
                        
                        Spacer()
                        Text("$\(Int(dataSet.value))")
                            .font(bold14Font)
                    }
                }
                .padding(.horizontal, 24)
            }
            
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 32)
        .background(Color(.white))
        
    }
}

//struct OverviewView_Previews: PreviewProvider {
//    static var previews: some View {
//        OverviewView()
//    }
//}
