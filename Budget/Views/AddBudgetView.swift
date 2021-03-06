//
//  AddBudgetView.swift
//  Budget
//
//  Created by Nicolas Machado on 4/2/21.
//

import SwiftUI

//https://stackoverflow.com/questions/11382753/change-the-ios-keyboard-layout-to-emoji/44753740#44753740

struct AddBudgetView: View {
    
    @EnvironmentObject var dataModel: BudgetModel
    @Binding var isPresented: Bool
    
    @State var emojiText: String = ""
    @State var titleText: String = ""
    @State var budgetText: String = ""
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
                    Text("New Budget")
                        .font(bold22Font)
                }
                .padding(.bottom, 20)
                .padding(.top, 36)
                .navigationBarTitle("New Budget", displayMode: .inline)
                .navigationBarHidden(true)
                
                CategoryButton(emojiText: $emojiText, emojiChosen: $emojiChosen)
                    .padding(.bottom, 48)
                
                TextInput(prompt: "Enter Title", text: $titleText)
                    .padding(.bottom, 20)
                    .foregroundColor(mediumGrayColor)
                TextInput(prompt: "Enter Budget", text: $budgetText)
                    .padding(.bottom, 20)
                    .foregroundColor(mediumGrayColor)
                SegmentedControlInput(prompt: "Choose type", selected: $selectedType)
                    .padding(.bottom, 60)
                    .foregroundColor(mediumGrayColor)
                
                Spacer()
                CreateButton(emojiText: $emojiText, titleText: $titleText, budgetText: $budgetText, selectedType: $selectedType, objectType: "budget", isPresented: $isPresented)
                    .environmentObject(dataModel)
                    .padding(.bottom, 60)
                
            }
        }
    }
    
}

struct TextInput: View {
    
    var prompt: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(prompt)
                .font(medium14Font)
                .foregroundColor(mediumGrayColor)
                .padding(.bottom, 10)
            CustomTextField(text: $text)
                .font(bold16Font)
                .foregroundColor(.black)
                .padding(.bottom, 5)
            Rectangle()
                .frame(height:1, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .opacity(0.2)
        }
        .padding(.horizontal, 24)
    }
}


//TextField("Some Text" , text: $someBinding).modifier(ClearButton(text: $someBinding))


struct CustomTextField : View {
    
    @State private var isEditing = false
    @Binding var text: String
    
    var body: some View {
        VStack {
            TextField(
                "",
                text: $text)
                .modifier(ClearButton(text: $text))
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
                .font(medium14Font)
                .foregroundColor(mediumGrayColor)
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
    @Binding var emojiChosen: Bool
    
    
    var body: some View {
        Button(action: {
            self.isFirstResponder = true
            print("button pressed")
        }) {
            ZStack {
                //so hacky :(
                EmojiTextField(emojiChosen: $emojiChosen, text: $emojiText, isFirstResponder: $isFirstResponder)
                    .frame(width: 1, height: 1, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                Rectangle()
                    .frame(width: 80, height: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .foregroundColor(cellBackgroundColor)
                    .cornerRadius(15)
                if emojiChosen {
                    Text(emojiText)
                        .font(emojiFont)
                    deleteButton(on: $emojiChosen)
                        .offset(x: 35, y: -35)
                }
                else {
                    //can do opacity change or hidden flag instead with binding value
                    Image(systemName: "face.smiling")
                        .font(Font.system(size: 45, weight: .medium))
                        .foregroundColor(mediumGrayColor)
                    Text("+ Add emoji")
                        .font(medium14Font)
                        .foregroundColor(mediumGrayColor)
                        .offset(y: 60)
                }
                
            }
        }
        .padding(.bottom, 8)
        
    }
    
    
    
}

struct CreateButton : View {
    
    @EnvironmentObject var dataModel: BudgetModel
    
    @Binding var emojiText: String
    @Binding var titleText: String
    @Binding var budgetText: String
    @Binding var selectedType : Int
    
    var objectType : String
    @Binding var isPresented: Bool
    
    var body: some View {
        
        Button(action: {
            print("button pressed")
            if self.objectType == "budget" {
                self.saveBudgetModel()
                // self.saveRecurringCostModel()
            }
            else {
                //self.saveBudgetModel()
                self.saveRecurringCostModel()
            }
            isPresented = false
        }) {
            ZStack {
                Rectangle()
                    .frame(width: 140, height: 40, alignment: .center)
                    .foregroundColor(.black)
                    .cornerRadius(15)
                Text("Create")
                    .font(bold16Font)
                    .foregroundColor(.white)
            }
        }
    }
    
    func saveBudgetModel() {
        var type = "want"
        if self.selectedType == 0 {
            type = "need"
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
    
    func saveRecurringCostModel() {
        var type = "want"
        if self.selectedType == 0 {
            type = "need"
        }
        if let budgetValue = Int(self.budgetText) {
            let viewModel = RecurringCost(emojiString: self.emojiText, title: self.titleText, value: budgetValue, spendType: type)
            self.dataModel.addRecurring(recurringItem: viewModel)
            print(viewModel)
        }
        else {
            print("ERROR saveRecurringCostModel() budgetValue can't be converted to Int")
        }
    }
}


//https://stackoverflow.com/questions/58200555/swiftui-add-clearbutton-to-textfield

struct ClearButton: ViewModifier
{
    @Binding var text: String
    
    public func body(content: Content) -> some View
    {
        ZStack(alignment: .trailing)
        {
            content
            
            if !text.isEmpty
            {
                Button(action:
                        {
                            self.text = ""
                        })
                {
                    ZStack {
                        Circle()
                            .frame(width: 17, height: 17, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .foregroundColor(cellBackgroundColor)
                        Image(systemName: "xmark")
                            .font(Font.system(size: 9, weight: .black))
                            .foregroundColor(mediumGrayColor)
                    }
                }
                .padding(.trailing, 8)
            }
        }
    }
}
