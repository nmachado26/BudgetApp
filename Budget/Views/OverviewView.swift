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

let sample = [ ChartCellModel(color: Color.red, value: 123, name: "Math"),
               ChartCellModel(color: Color.yellow, value: 233, name: "Physics"),
               ChartCellModel(color: Color.pink, value: 73, name: "Chemistry"),
               ChartCellModel(color: Color.blue, value: 731, name: "Litrature"),
               ChartCellModel(color: Color.green, value: 51, name: "Art")]

struct MonthlyView : View {
    
    @State var selectedDonut: String = ""
    
    var body: some View {
        
        ScrollView {
            VStack {
                HStack(spacing: 20) {
                    DonutChart(dataModel: ChartDataModel.init(dataModel: sample), onTap: {
                        dataModel in
                        if let dataModel = dataModel {
                            self.selectedDonut = "Subject: \(dataModel.name)\nPointes: \(dataModel.value)"
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
                HStack {
                    ForEach(sample) { dataSet in
                        VStack {
                            Circle().foregroundColor(dataSet.color)
                            Text(dataSet.name).font(.footnote)
                        }
                    }
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
