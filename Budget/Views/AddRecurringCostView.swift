//
//  AddRecurringCostView.swift
//  Budget
//
//  Created by Nicolas Machado on 4/3/21.
//

import SwiftUI

struct AddRecurringCostView: View {
    
    @EnvironmentObject var dataModel: BudgetModel
    @Binding var isPresented: Bool
    
    @State var emojiText: String = ""
    @State var titleText: String = ""
    @State var budgetText: String = ""
    @State var selectedFrequency : Int = 0
    @State var selectedType : Int = 0
    
    @State var emojiChosen: Bool = false
    
    
    var body: some View {
        
        NavigationView {
            VStack { //double V-stack :(
                
                
                ZStack {
                    HStack {
                        BackButton(on: $isPresented)
                            .padding(.leading, 16)
                        Spacer()
                    }
                    Text("New Recurring")
                        .font(bold22Font)
                }
                .padding(.bottom, 20)
                .padding(.top, 36)
                .navigationBarTitle("New Recurring", displayMode: .inline)
                .navigationBarHidden(true)
                
                CategoryButton(emojiText: $emojiText, emojiChosen: $emojiChosen)
                    .padding(.bottom, 48)
                
                TextInput(prompt: "Enter Title", text: $titleText)
                    .foregroundColor(mediumGrayColor)
                    .padding(.bottom, 20)
                TextInput(prompt: "Monthly Cost", text: $budgetText)
                    .foregroundColor(mediumGrayColor)
                    .padding(.bottom, 20)
                SegmentedControlInput(prompt: "Choose type", selected: $selectedType)
                    .foregroundColor(mediumGrayColor)
                    .padding(.bottom, 80)
                Spacer()
                CreateButton(emojiText: $emojiText, titleText: $titleText, budgetText: $budgetText, selectedType: $selectedType, objectType: "recurring", isPresented: $isPresented)
                    .environmentObject(dataModel)
                    .padding(.bottom, 100)
                Spacer()
                
                
            }
        }
    }
}
