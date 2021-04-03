//
//  AddRecurringCostView.swift
//  Budget
//
//  Created by Nicolas Machado on 4/3/21.
//

import SwiftUI

struct AddRecurringCostView: View {
    
    @Binding var dataModel: BudgetModel
    @Binding var isPresented: Bool

    @State var emojiText: String = ""
    @State var titleText: String = ""
    @State var budgetText: String = ""
    @State var selectedFrequency : Int = 0
    @State var selectedType : Int = 0

    
    var body: some View {
        
        NavigationView {
            VStack { //double V-stack :(

                VStack {
                    Text("New Recurring")
                        .font(.title)
                        .padding(.bottom, 20)
                    CategoryButton(emojiText: $emojiText)

                }
                .padding(.bottom, 20)
                .navigationBarTitle("New Budget", displayMode: .inline)
                .navigationBarHidden(true)



                TextInput(prompt: "Enter Title", text: $titleText)
                    .padding(.bottom, 20)
                TextInput(prompt: "Monthly Cost", text: $budgetText)
                    .padding(.bottom, 20)
                SegmentedControlInput(prompt: "Choose type", selected: $selectedType)
                    .padding(.bottom, 60)
                CreateButton(dataModel: $dataModel, emojiText: $emojiText, titleText: $titleText, budgetText: $budgetText, selectedType: $selectedType, objectType: "recurring", isPresented: $isPresented)


            }
        }
    }
}

//struct AddRecurringCostView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddRecurringCostView()
//    }
//}
