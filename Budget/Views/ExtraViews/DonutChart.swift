//
//  DonutChart.swift
//  Budget
//
//  Created by Nicolas Machado on 4/3/21.
//

import SwiftUI

// https://prafullkumar77.medium.com/how-to-make-pie-and-donut-chart-using-swiftui-12e8ef916ce5

struct DonutChart: View {
    @State private var selectedCell: UUID = UUID()
    
    let dataModel: ChartDataModel
    let onTap: (ChartCellModel?) -> ()
    var body: some View {
            ZStack {
                PieChart(dataModel: dataModel, onTap: onTap)
                InnerCircle(ratio: 1/3).foregroundColor(.white)
            }
    }
}

struct PieChart: View {
    @State private var selectedCell: UUID = UUID()
    
    let dataModel: ChartDataModel
    let onTap: (ChartCellModel?) -> ()
    var body: some View {
            ZStack {
                ForEach(dataModel.chartCellModel) { dataSet in
                    PieChartCell(startAngle: self.dataModel.angle(for: dataSet.value), endAngle: self.dataModel.startingAngle)
                        .foregroundColor(dataSet.color)
                       .onTapGesture {
                         withAnimation {
                            if self.selectedCell == dataSet.id {
                                self.onTap(nil)
                                self.selectedCell = UUID()
                            } else {
                                self.selectedCell = dataSet.id
                                self.onTap(dataSet)
                            }
                        }
                    }.scaleEffect((self.selectedCell == dataSet.id) ? 1.05 : 1.0)
                }
            }
    }
}

struct PieChartCell: Shape {
    let startAngle: Angle
    let endAngle: Angle
   func path(in rect: CGRect) -> Path {
        let center = CGPoint.init(x: (rect.origin.x + rect.width)/2, y: (rect.origin.y + rect.height)/2)
    let radii = min(center.x, center.y)
        let path = Path { p in
            p.addArc(center: center,
                     radius: radii,
                     startAngle: startAngle,
                     endAngle: endAngle,
                     clockwise: true)
            p.addLine(to: center)
        }
        return path
   }
}

struct InnerCircle: Shape {
    let ratio: CGFloat
    func path(in rect: CGRect) -> Path {
         let center = CGPoint.init(x: (rect.origin.x + rect.width)/2, y: (rect.origin.y + rect.height)/2)
        let radii = min(center.x, center.y) * ratio
         let path = Path { p in
             p.addArc(center: center,
                      radius: radii,
                      startAngle: Angle(degrees: 0),
                      endAngle: Angle(degrees: 360),
                      clockwise: true)
             p.addLine(to: center)
         }
         return path
    }
}

struct ChartCellModel: Identifiable {
    let id = UUID()
    let color: Color
    let value: CGFloat
    let name: String
}

final class ChartDataModel: ObservableObject {
    var chartCellModel: [ChartCellModel]
    var startingAngle = Angle(degrees: 0)
    private var lastBarEndAngle = Angle(degrees: 0)
    
        
    init(dataModel: [ChartCellModel]) {
        chartCellModel = dataModel
    }
    
    var totalValue: CGFloat {
        chartCellModel.reduce(CGFloat(0)) { (result, data) -> CGFloat in
            result + data.value
        }
    }
    
    func angle(for value: CGFloat) -> Angle {
        if startingAngle != lastBarEndAngle {
            startingAngle = lastBarEndAngle
        }
        lastBarEndAngle += Angle(degrees: Double(value / totalValue) * 360 )
        print(lastBarEndAngle.degrees)
        return lastBarEndAngle
    }
}
