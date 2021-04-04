//
//  OverviewView.swift
//  Budget
//
//  Created by Nicolas Machado on 4/2/21.
//

import SwiftUI

struct OverviewView: View {
    
    @Binding var dataModel: BudgetModel
    
    var body: some View {
        
        backgroundGray
            .ignoresSafeArea(.all) // Ignore just for the color
            .overlay(
                VStack(spacing: 24) {
                    StatusView()
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                        .padding(.top, 200)
                    MonthlyView()
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 200)
                }
            
            )
    
    }
}

struct StatusView: View {
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Status")
                .font(.title3)
                .fontWeight(.semibold)
                .padding(.bottom, 8)
            HStack(spacing:5) {
                Text("$\(5000)")
                    .font(.title2)
                    .fontWeight(.semibold)
                Text("left to spend")
                    .font(.title3)
                    .fontWeight(.semibold)
            }
            ProgressBar(value: 0.7)
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
                Text("$\(2000)")
            }
            HStack {
                Rectangle()
                    .frame(width: 6, height: 20)
                    .cornerRadius(10) //overdone
                    .foregroundColor(backgroundGray)
                Text("Budget").font(.body)
                Spacer()
                Text("$\(7000)")
            }
            
        }
        .padding(.horizontal, 32)
        .padding(.vertical, 16)
        .background(Color(.white))
    }
}

let sample = [ ChartCellModel(color: turquoiseColor, value: 2000, name: "Wants"),
               ChartCellModel(color: orangeColor, value: 3000, name: "Needs"),
               ChartCellModel(color: unfilledChartColor, value: 1000, name: "Saved"),]

struct MonthlyView : View {
    
    @State var selectedDonut: String = ""
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text("January Outlook")
                .font(.title3)
                .fontWeight(.semibold)
                .padding(.top, 16)
                .padding(.bottom, 16)
            
            ZStack {
                DonutChart(dataModel: ChartDataModel.init(dataModel: sample), onTap: {
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
                    Text("$3000")
                        .font(.body)
                        .fontWeight(.semibold)
                }
            }
            Spacer()
            VStack {
                ForEach(sample) { dataSet in
                    HStack {
                        Rectangle()
                            .frame(width: 6, height: 20)
                            .cornerRadius(10) //overdone
                            .foregroundColor(dataSet.color)
                        Text(dataSet.name).font(.body)
                        Spacer()
                        Text("$\(dataSet.value)")
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
