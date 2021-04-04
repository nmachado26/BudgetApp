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
                .font(.title3)
                .fontWeight(.semibold)
                .padding(.bottom, 8)
            HStack(spacing:5) {
                Text("$\(dataModel.getTotalBudget() - dataModel.getTotalSpent())")
                    .font(.title2)
                    .fontWeight(.semibold)
                Text("left to spend")
                    .font(.title3)
                    .fontWeight(.semibold)
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
                Text("Spent").font(.body)
                Spacer()
                Text("$\(dataModel.getTotalSpent())")
            }
            HStack {
                Rectangle()
                    .frame(width: 6, height: 20)
                    .cornerRadius(10) //overdone
                    .foregroundColor(backgroundGrayColor)
                Text("Budget").font(.body)
                Spacer()
                Text("$\(dataModel.getTotalBudget())")
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
                .font(.title3)
                .fontWeight(.semibold)
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
                        .font(.title3)
                        .fontWeight(.semibold)
                    Text("$\(dataModel.getTotalSpent())")
                        .font(.body)
                        .fontWeight(.semibold)
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
                        Text(dataSet.name).font(.body)
                        Spacer()
                        Text("$\(Int(dataSet.value))")
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
