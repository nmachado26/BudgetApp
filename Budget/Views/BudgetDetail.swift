//
//  BudgetDetail.swift
//  Budget
//
//  Created by Nicolas Machado on 4/4/21.
//

import SwiftUI

struct BudgetDetail: View {
    
    @EnvironmentObject var dataModel: BudgetModel
    @Binding var budget: Budget
    @State var circleColor = Color.yellow
    
    var body: some View {
        Text("Hello World")
    }
    
}



/*
 Gesture long press
 
 Circle()
         .foregroundColor(circleColor)
         .frame(width: 200, height: 200, alignment: .center)
         // 3.
         .gesture(LongPressGesture(minimumDuration: 2)
         .onEnded { _ in
             if self.circleColor == .yellow {
                 self.circleColor = .red
             } else {
                 self.circleColor = .yellow
             }
         })
 */
