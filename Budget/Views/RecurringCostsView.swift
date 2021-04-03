//
//  RecurringCostsView.swift
//  Budget
//
//  Created by Nicolas Machado on 4/3/21.
//

import SwiftUI

struct RecurringCostsView: View {
    
    @Binding var dataModel: BudgetModel
    
    var body: some View {
        Text(dataModel.testStr)
    }
}

//struct RecurringCostsView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecurringCostsView()
//    }
//}
