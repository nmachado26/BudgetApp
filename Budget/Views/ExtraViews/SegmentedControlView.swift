//
//  SegmentedControlView.swift
//  Budget
//
//  Created by Nicolas Machado on 4/2/21.
//d

import SwiftUI

struct Segment: Identifiable {
    var id: Int
    var segmentName: String
}

struct SegmentedControlView: View {
    @Binding var selected : Int
    var segments: [Segment]
    var body: some View {
        HStack {
            ForEach(segments) { segment in
                Button(action: {
                    self.selected = segment.id
                })
                {
                    VStack {
                        Text(segment.segmentName)
                            .padding(.horizontal, 5)
                            .padding(.vertical, 0)
                            .font(.custom("HelveticaNeue-Medium", size: 16))
                    }
                }.foregroundColor(self.selected == segment.id ? .black : .gray)
            }
        }
        .clipShape(Capsule())
        .animation(.default)
    }
}

//struct SegmentedControlView_Previews: PreviewProvider {
//    static var previews: some View {
//        SegmentedControlView()
//    }
//}



