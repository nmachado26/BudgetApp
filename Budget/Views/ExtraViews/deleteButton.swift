//
//  deleteButton.swift
//  Budget
//
//  Created by Nicolas Machado on 4/3/21.
//

import SwiftUI

struct deleteButton: View {
    
    @Binding var on: Bool
    
    var body: some View {
        Button(action: {
            print("pressed")
            self.on = false
        }, label: {
            ZStack {
                Circle()
                    .frame(width: 30, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.gray)
                Image(systemName: "xmark")
                    .frame(width: 40, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.black)
            }
        })
    }
}
//
//struct deleteButton_Previews: PreviewProvider {
//    static var previews: some View {
//        deleteButton()
//    }
//}
