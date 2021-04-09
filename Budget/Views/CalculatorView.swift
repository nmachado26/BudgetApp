//
//  Calculator.swift
//  Budget
//
//  Created by Nicolas Machado on 4/2/21.
//

import SwiftUI

//sick demo: https://www.youtube.com/watch?v=fuTDDeKs_gc

//calculator code from https://kavsoft.dev/Swift/Custom%20NumberPad/

let calcMargin: CGFloat = 56

struct CalculatorView: View {
    
    @EnvironmentObject var dataModel: BudgetModel
    
    @State var selectedCategory : Budget = Budget(emojiString: "", title: "", budgetedValue: 0, spendType: "")
    @State private var showingCategoriesList = false
    @State private var categoryChosen = false
    
    @State var code: [String] = []
    //@State var code: String = " //for future when doing auto . for inputting number
    
    var body: some View {
        NavigationView {
            VStack {
                
                Group {
                    HStack(spacing: 5) {
                        Text("$")
                            .font(bold80Font)
                        Text(code.joined(separator:""))
                            .font(bold80Font)
                    }.padding(.bottom, 48)
                    
                    Button(action: {
                        self.showingCategoriesList = true
                    }, label: {
                        
                        VStack {
                            ZStack {
                                Rectangle()
                                    .frame(width: 80, height: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .foregroundColor(cellBackgroundColor)
                                    .cornerRadius(15)
                                if self.categoryChosen {
                                    Text(selectedCategory.emojiString)
                                        .font(emojiFont)
                                }
                                else {
                                    Image(systemName: "plus")
                                        .font(Font.system(size: 20, weight: .heavy))
                                        .foregroundColor(mediumGrayColor)
                                }
                                
                                if categoryChosen {
                                    deleteButton(on: $categoryChosen)
                                        .offset(x: 35, y: -35)
                                    Text(selectedCategory.title)
                                        .font(medium14Font)
                                        .foregroundColor(mediumGrayColor)
                                        .offset(y: 60)
                                }
                            }
                        }
                        
                    }).sheet(isPresented: $showingCategoriesList) {
                        CategoriesList(selectedCategory: $selectedCategory, isPresented: $showingCategoriesList, categoryChosen: $categoryChosen)
                    }
                    .padding(.bottom, 32)
                    .environmentObject(dataModel)
                }
                .offset(y: -24)
                
                NumberPad(codes: $code, selectedCategory: $selectedCategory, categoryChosen: $categoryChosen)
                    .padding(.horizontal, calcMargin)
                    .environmentObject(dataModel)
            }
        }
    }
}

struct NumberPad : View {
    
    @EnvironmentObject var dataModel: BudgetModel
    @Binding var codes : [String]
    @Binding var selectedCategory : Budget
    @Binding var categoryChosen: Bool
    
    @State private var currentString: String = ""
    
    
    var body : some View {
        
        VStack(alignment: .leading, spacing: 20) {
            ForEach(datas) { i in
                HStack(spacing: getSpacing()) {
                    ForEach(i.row) { j in
                        Button(action: {
                            if j.value == "chevron.backward" {
                                if !self.codes.isEmpty {
                                    self.codes.removeLast()
                                }
                            }
                            else if j.value == "checkmark.circle.fill" {
                                if !codes.isEmpty {
                                    let expenseStr = codes.joined(separator:"")
                                    dataModel.addExpense(budget: self.selectedCategory, expenseString: expenseStr)
                                    self.codes.removeAll()
                                    self.categoryChosen = false
                                }
                            }
                            else {
                                self.codes.append(j.value)
                            }
                        }) {
                            if j.value == "chevron.backward"{
                                Image(systemName: j.value)
                                    .font(Font.system(size: 20, weight: .heavy))
                                    .padding(.bottom, 76)
                                    .offset(x: 7, y: -3)
                            }
                            else if j.value == "checkmark.circle.fill" {
                                Image(systemName: j.value)
                                    .font(Font.system(size: 30))
                                    .foregroundColor(primaryColor)
                                    .padding(.bottom, 76)
                                    .offset(x: 3, y: -2)
                            }
                            else {
                                if j.value == "0" {
                                    Text(j.value)
                                        .font(bold28Font)
                                        .padding(.bottom, 76)
                                        .frame(maxWidth: .infinity, alignment: .center)
                                        .offset(x: 8)
                                }
                                else {
                                    Text(j.value)
                                        .font(bold28Font)
                                        .padding(.bottom, 46)
                                        .frame(maxWidth: .infinity, alignment: .center)
                                }
                            }
                        }
                    }
                }
            }
        }
        .foregroundColor(.black)
    }
    
    func getSpacing()->CGFloat {
        return (UIScreen.main.bounds.width - (calcMargin * 2)) / 3
    }
    
    func getCode()->String {
        var code = ""
        for i in self.codes {
            code += i
        }
        
        return code.replacingOccurrences(of: " ", with: "")
    }
}

struct type: Identifiable {
    
    var id: Int
    var row : [row]
}

struct row : Identifiable {
    
    var id: Int
    var value : String
}

var datas = [
    type(id: 0, row: [row(id: 0, value: "1"), row(id: 1, value: "2"), row(id: 2, value: "3")]),
    type(id: 1, row: [row(id: 0, value: "4"), row(id: 1, value: "5"), row(id: 2, value: "6")]),
    type(id: 2, row: [row(id: 0, value: "7"), row(id: 1, value: "8"), row(id: 2, value: "9")]),
    type(id: 3, row: [row(id: 0, value: "chevron.backward"), row(id: 1, value: "0"), row(id: 2, value: "checkmark.circle.fill")])
    
]


