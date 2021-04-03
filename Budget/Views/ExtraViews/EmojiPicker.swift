//
//  EmojiPicker.swift
//  Budget
//
//  Created by Nicolas Machado on 4/2/21.
//

import SwiftUI


//UNUSED

//https://stackoverflow.com/questions/44977646/emoji-picker-ios-swift/44983520
//https://developer.apple.com/forums/thread/110059
//https://stackoverflow.com/questions/53388260/how-to-get-all-available-emojis-in-an-array-in-swift
//https://stackoverflow.com/questions/37766611/how-to-replace-emoji-characters-with-their-descriptions-in-a-swift-string

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
                            if let emoji = item.image() {
                                Image(uiImage: emoji)
                                    .resizable()
                                    .frame(width: 50, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
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
        
        let final = [
            0x1F600...0x1F64F, // Emoticons
        ]
        
        let emojiRanges = [
//            0x1F600...0x1F64F, // Emoticons
//            0x2600...0x26FF,   // Misc symbols
//            0x1F300...0x1F5FF, // Misc Symbols and Pictographs
//            0x1F680...0x1F6FF, // Transport and Map
//            0x1F900...0x1F9FF,  // Supplemental Symbols and Pictographs
            
            0x1F600...0x1F64F, // Emoticons
                             0x1F300...0x1F5FF, // Misc Symbols and Pictographs
                             0x1F680...0x1F6FF, // Transport and Map
                             0x2600...0x26FF,   // Misc symbols
                             0x2700...0x27BF,   // Dingbats
                             0xFE00...0xFE0F,   // Variation Selectors
                             0x1F900...0x1F9FF, // Supplemental Symbols and Pictographs
                             0x1F1E6...0x1F1FF // Flags
        ]
        
        //            0x1F601...0x1F64F,
        //            0x2702...0x27B0,
        //            0x1F680...0x1F6C0,
        //            0x1F170...0x1F251
        
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
