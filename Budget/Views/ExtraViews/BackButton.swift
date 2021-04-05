//
//  BackButton.swift
//  Budget
//
//  Created by Nicolas Machado on 4/4/21.
//

import SwiftUI

struct BackButton: View {

    @Binding var on: Bool

    var body: some View {
        Button(action: {
            print("pressed")
            self.on = false
        }, label: {
            ZStack {
                Circle()
                    .frame(width: 30, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .foregroundColor(cellBackgroundColor)
                Image(systemName: "chevron.backward")
                    .font(Font.system(size: 16, weight: .heavy))
                    .frame(width: 40, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .foregroundColor(mediumGrayColor)
            }
        })
    }
}
