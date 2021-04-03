//
//  EmojiPicker.swift
//  Budget
//
//  Created by Nicolas Machado on 4/2/21.
//

import SwiftUI


//https://stackoverflow.com/questions/44977646/emoji-picker-ios-swift/44983520

struct EmojiPicker: View {
    
    var emojiList: [[String]] = []
    let sectionTitle: [String] = ["Emoticons", "Dingbats", "Transport and map symbols", "Enclosed Characters"]
    let imageBackup = Image(systemName: "house")
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    init() {
        self.fetchEmojis()
    }
    
    var body: some View {
        VStack {
            Text("Hi")
            ScrollView {
                Text("Hi2")
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(emojiList, id: \.self) { sublist in
                        ForEach(sublist, id: \.self) { item in
                            //Text("Hi")
//                            Image(systemName: "house")
                            if let emoji = item.image() {
                                Image(uiImage: emoji)
                            }
                            else {
                                Image(systemName: "house")
                            }
                        }
                    }
                    .padding(.horizontal, 0)
                    .padding(.top, 20)
                }
            }
        }
    }
    
    mutating func fetchEmojis() {
        
        let emojiRanges = [
            0x1F601...0x1F64F,
            0x2702...0x27B0,
            0x1F680...0x1F6C0,
            0x1F170...0x1F251
        ]
        
        for range in emojiRanges {
            var array: [String] = []
            for i in range {
                if let unicodeScalar = UnicodeScalar(i){
                    array.append(String(describing: unicodeScalar))
                }
            }
            
            emojiList.append(array)
        }
    }
}

struct EmojiPicker_Previews: PreviewProvider {
    static var previews: some View {
        EmojiPicker()
    }
}
