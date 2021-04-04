//
//  Calculator.swift
//  Budget
//
//  Created by Nicolas Machado on 4/2/21.
//

import SwiftUI

//sick demo: https://www.youtube.com/watch?v=fuTDDeKs_gc

//calculator code from https://kavsoft.dev/Swift/Custom%20NumberPad/
struct CalculatorView: View {
    
    @EnvironmentObject var dataModel: BudgetModel
    
    @State var selectedCategory : Budget = Budget(emojiString: "", title: "", budgetedValue: 0, spendType: "")
    @State private var showingCategoriesList = false
    @State private var categoryChosen = false
    
    @State var code: [String] = []
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                HStack(spacing: 5) {
                    Text("$")
                        .font(bold80Font)
                    Text(code.joined(separator:""))
                        .font(bold80Font)
                }.padding(.vertical)
                
                Spacer()
                
                
                Button(action: {
                    self.showingCategoriesList = true
                }, label: {
                    
                    VStack {
                        ZStack {
                            Rectangle()
                                .frame(width: 80, height: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .foregroundColor(.black)
                                .opacity(0.1)
                                .cornerRadius(15)
                            if self.categoryChosen {
                                Text(selectedCategory.emojiString)
                                    .font(emojiFont)
                            }
                            else {
                                Image(systemName: "plus")
                            }
                            
                            if categoryChosen {
                                deleteButton(on: $categoryChosen)
                                    .offset(x: 35, y: -35)
                            }
                        }
                        if categoryChosen {
                            Text(selectedCategory.title)
                                .font(medium14Font)
                                .foregroundColor(mediumGrayColor)
                        }
                    }
                    
                }).sheet(isPresented: $showingCategoriesList) {
                    CategoriesList(selectedCategory: $selectedCategory, isPresented: $showingCategoriesList, categoryChosen: $categoryChosen)
                }
                .environmentObject(dataModel)
                
                Spacer()
                NumberPad(codes: $code, selectedCategory: $selectedCategory, categoryChosen: $categoryChosen)
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
                
                HStack(spacing: self.getSpacing()) {
                    
                    ForEach(i.row) { j in
                        
                        Button(action: {
                            if j.value == "delete.left.fill" {
                                if !self.codes.isEmpty {
                                    self.codes.removeLast()
                                    
                                }
                                //currentString = codes.joined(separator:"")
                                
                            }
                            else if j.value == "checkmark.circle.fill" {
                                
                                if !codes.isEmpty {
                                    
                                    let expenseStr = codes.joined(separator:"")
                                    
                                    dataModel.addExpense(budget: self.selectedCategory, expenseString: expenseStr)
                                    
                                    self.codes.removeAll()
                                    self.categoryChosen = false
                                    //currentString = ""
                                }
                            }
                            else {
                                self.codes.append(j.value)
                                //currentString = codes.joined(separator:"")
                            }
                        }) {
                            if j.value == "delete.left.fill"{
                                Image(systemName: j.value)
                            }
                            else if j.value == "checkmark.circle.fill" {
                                Image(systemName: j.value)
                                    .foregroundColor(primaryColor)
                            }
                            else {
                                Text(j.value)
                                    .font(bold28Font)
                                    .padding(.vertical)
                            }
                        }
                    }
                }
            }
        }.foregroundColor(.black)
    }
    
    func getSpacing()->CGFloat {
        return UIScreen.main.bounds.width / 3
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
    type(id: 3, row: [row(id: 0, value: "delete.left.fill"), row(id: 1, value: "0"), row(id: 2, value: "checkmark.circle.fill")])
    
]


