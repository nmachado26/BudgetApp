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
        VStack {
            StatusView()
            MonthlyView()
        }
    }
}

struct StatusView: View {
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Status")
            ProgressBar(value: 0.7)
                .cornerRadius(10)
                .frame(height: 20)
                .padding(.horizontal, 30)
        }
    }
}

let sample = [ ChartCellModel(color: Color.red, value: 2000, name: "Wants"),
               ChartCellModel(color: Color.yellow, value: 3000, name: "Needs"),
               ChartCellModel(color: Color.gray, value: 1000, name: "Saved"),]

struct MonthlyView : View {
    
    @State var selectedDonut: String = ""
    
    var body: some View {
        
        ScrollView {
            VStack {
                HStack(spacing: 20) {
                    DonutChart(dataModel: ChartDataModel.init(dataModel: sample), onTap: {
                        dataModel in
                        if let dataModel = dataModel {
                            self.selectedDonut = "Spending Type: \(dataModel.name)\nAmount: \(dataModel.value)"
                        } else {
                            self.selectedDonut = ""
                        }
                    })
                    .frame(width: 150, height: 150, alignment: .center)
                    .padding()
                    Text(selectedDonut)
                        .font(.footnote)
                        .multilineTextAlignment(.leading)
                    Spacer()
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
        }
        
    }
}

//struct OverviewView_Previews: PreviewProvider {
//    static var previews: some View {
//        OverviewView()
//    }
//}
