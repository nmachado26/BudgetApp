//
//  AddBudgetView.swift
//  Budget
//
//  Created by Nicolas Machado on 4/2/21.
//

import SwiftUI

//https://stackoverflow.com/questions/11382753/change-the-ios-keyboard-layout-to-emoji/44753740#44753740

struct AddBudgetView: View {
    
    var body: some View {
        NavigationView {
            VStack { //double V-stack :(
                
                VStack {
                    Text("New Budget")
                        .font(.title)
                        .padding(.bottom, 20)
                    CategoryButton()
                    
                }
                .padding(.bottom, 20)
                .navigationBarTitle("New Budget", displayMode: .inline)
                .navigationBarHidden(true)
                
                
                
                TextInput(prompt: "Enter Title")
                    .padding(.bottom, 20)
                TextInput(prompt: "Enter Budget")
                    .padding(.bottom, 20)
                SegmentedControlInput(prompt: "Choose type")
                    .padding(.bottom, 60)
                CreateButton()
                
                
            }
        }
    }
}

struct TextInput: View {
    
    var prompt: String
    @State private var givenName: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(prompt)
                .padding(.bottom, 10)
            CustomTextField()
                .padding(.bottom, 5)
            Rectangle()
                .frame(height:1, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .opacity(0.2)
        }
        .padding(.horizontal, 24)
    }
}

struct CustomTextField : View {
    @State private var username: String = ""
    @State private var isEditing = false
    
    @State private var givenName: String = ""
    @State private var familyName: String = ""
    
    var body: some View {
        TextField(
            "",
            text: $givenName)
            .disableAutocorrection(true)
            .textFieldStyle(PlainTextFieldStyle())
    }
}

struct SegmentedControlInput: View {
    
    @State var selected = 0 //changing each time selected
    @State private var favoriteColor = "Red"
    var colors = ["Red", "Green", "Blue"]
    
    var prompt: String
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
    
    @State var text = ""
    @State var isFirstResponder = false
    
    var body: some View {
        Button(action: {
            self.isFirstResponder = true
            print("button pressed")
        }) {
            ZStack {
                //so hacky :(
                EmojiTextField(text: $text, isFirstResponder: $isFirstResponder)
                    .frame(width: 1, height: 1, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                Rectangle()
                    .frame(width: 80, height: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.black)
                    .opacity(0.1)
                    .cornerRadius(15)
                Text("💗")
                    .font(.title)
                //Image(systemName: "face.smiling")
            }
        }
        .padding(.bottom, 8)
        Text("+ Add emoji")
    }
}

struct CreateButton : View {
    var body: some View {
        
        Button(action: {
            print("button pressed")
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
}


struct AddBudgetView_Previews: PreviewProvider {
    static var previews: some View {
        AddBudgetView()
    }
}
