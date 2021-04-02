//
//  AddBudgetView.swift
//  Budget
//
//  Created by Nicolas Machado on 4/2/21.
//

import SwiftUI

struct AddBudgetView: View {
    
    var body: some View {
        NavigationView {
            VStack { //double V-stack :(
                
                VStack {
                    Text("New Budget")
                        .font(.title)
                    CategoryButton()
                    
                }
                .navigationBarTitle("New Budget", displayMode: .inline)
                .navigationBarHidden(true)
                
                
                
                TextInput(prompt: "Enter Title")
                TextInput(prompt: "Enter Budget")
                SegmentedControlInput(prompt: "Choose type")
                CreateButton()
                
                
            }
        }
    }
}

struct TextInput: View {
    var prompt: String
    var body: some View {
        VStack(alignment: .leading) {
            Text(prompt)
            Text("NAME")
            Rectangle()
                .frame(height:1, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .opacity(0.2)
        }
        .padding(.horizontal, 24)
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
            SegmentedControlView(selected: self.$selected, segments: [Segment(id: 0, segmentName: "Popular"), Segment(id: 1, segmentName: "New"), Segment(id: 2, segmentName: "Follow")])
            Rectangle()
                .frame(height:1, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .opacity(0.2)
        }
        .padding(.horizontal, 24)
    }
}

struct CategoryButton: View {
    var body: some View {
        Button(action: {
            print("button pressed")
        }) {
            ZStack {
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
                    .frame(width: 140, height: 84, alignment: .center)
                    .foregroundColor(.black)
                    .cornerRadius(15)
                Text("Create")
                    .font(.title)
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
