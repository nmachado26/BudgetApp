//
//  AddBudgetView.swift
//  Budget
//
//  Created by Nicolas Machado on 4/2/21.
//

import SwiftUI

//https://stackoverflow.com/questions/11382753/change-the-ios-keyboard-layout-to-emoji/44753740#44753740

struct AddBudgetView: View {
    
    @Binding var dataModel: BudgetModel
    
    @State var emojiText: String = ""
    @State var titleText: String = ""
    @State var budgetText: String = ""
    @State var selectedType : Int = 0
    
    var body: some View {
        NavigationView {
            VStack { //double V-stack :(
                
                VStack {
                    Text("New Budget")
                        .font(.title)
                        .padding(.bottom, 20)
                    CategoryButton(emojiText: $emojiText)
                    
                }
                .padding(.bottom, 20)
                .navigationBarTitle("New Budget", displayMode: .inline)
                .navigationBarHidden(true)
                
                
                
                TextInput(prompt: "Enter Title", text: $titleText)
                    .padding(.bottom, 20)
                TextInput(prompt: "Enter Budget", text: $budgetText)
                    .padding(.bottom, 20)
                SegmentedControlInput(prompt: "Choose type", selected: $selectedType)
                    .padding(.bottom, 60)
                CreateButton(dataModel: $dataModel, emojiText: $emojiText, titleText: $titleText, budgetText: $budgetText, selectedType: $selectedType)
                
                
            }
        }
    }
    
    func saveModel() {
        print("pls")
    }
}

struct TextInput: View {
    
    var prompt: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(prompt)
                .padding(.bottom, 10)
            CustomTextField(text: $text)
                .padding(.bottom, 5)
            Rectangle()
                .frame(height:1, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .opacity(0.2)
        }
        .padding(.horizontal, 24)
    }
}

struct CustomTextField : View {
    
    @State private var isEditing = false
    @Binding var text: String
    
    var body: some View {
        VStack {
        TextField(
            "",
            text: $text)
            .disableAutocorrection(true)
            .textFieldStyle(PlainTextFieldStyle())
        }
    }
}

struct SegmentedControlInput: View {
    
    var prompt: String
    @Binding var selected: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(prompt)
                .padding(.bottom, 20)
            SegmentedControlView(selected: self.$selected, segments: [Segment(id: 0, segmentName: "Need"), Segment(id: 1, segmentName: "Want")])
                .padding(.bottom, 15)
            Rectangle()
                .frame(height:1, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .opacity(0.2)
        }
        .padding(.horizontal, 24)
    }
}

struct CategoryButton: View {
    
    @State var isFirstResponder = false
    
    @Binding var emojiText: String
    
    
    var body: some View {
        Button(action: {
            self.isFirstResponder = true
            print("button pressed")
        }) {
            ZStack {
                //so hacky :(
                EmojiTextField(text: $emojiText, isFirstResponder: $isFirstResponder)
                    .frame(width: 1, height: 1, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                Rectangle()
                    .frame(width: 80, height: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.black)
                    .opacity(0.1)
                    .cornerRadius(15)
                Text(self.emojiText)
                    .font(.title)
                //Image(systemName: "face.smiling")
            }
        }
        .padding(.bottom, 8)
        Text("+ Add emoji")
    }
    
}

struct CreateButton : View {
    
    @Binding var dataModel: BudgetModel
    
    @Binding var emojiText: String
    @Binding var titleText: String
    @Binding var budgetText: String
    @Binding var selectedType : Int
    
    var body: some View {
        
        Button(action: {
            print("button pressed")
            self.saveBudgetModel()
        }) {
            ZStack {
                Rectangle()
                    .frame(width: 140, height: 40, alignment: .center)
                    .foregroundColor(.black)
                    .cornerRadius(15)
                Text("Create")
                    .font(.headline)
                    .foregroundColor(.white)
            }
        }
    }
    
    func saveBudgetModel() {
        var type = "Want"
        if self.selectedType == 0 {
            type = "Need"
        }
        
        if let budgetValue = Int(self.budgetText) {
            let viewModel = Budget(emojiString: self.emojiText, title: self.titleText, budgetedValue: budgetValue, spendType: type)
            self.dataModel.addBudget(budget: viewModel)
            print(viewModel)
        }
        else {
            print("ERROR saveBudgetModel budgetValue can't be converted to Int")
        }
    }
}


//struct AddBudgetView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddBudgetView()
//    }
//}
