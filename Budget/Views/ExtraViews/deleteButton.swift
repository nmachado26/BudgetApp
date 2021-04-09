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
                    .stroke(Color.white, lineWidth: 2)
                    .frame(width: 30, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .foregroundColor(cellBackgroundColor)
                Image(systemName: "xmark")
                    .font(Font.system(size: 14, weight: .black))
                    .frame(width: 40, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .foregroundColor(mediumGrayColor)
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
