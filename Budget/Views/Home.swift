//
//  Home.swift
//  Budget
//
//  Created by Nicolas Machado on 4/2/21.
//

import SwiftUI

//calculator code from https://kavsoft.dev/Swift/Custom%20NumberPad/
struct Home: View {
    
    @State var code: [String] = []
    
    var body: some View {
        VStack {
            Spacer()
            Text("Enter Code").font(.title)

            HStack(spacing: 20) {
                ForEach(code, id: \.self){ i in
                    Text(i)
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                }
            }.padding(.vertical)
            
            Spacer()
            NumberPad(codes: $code)
        }
    }
}

struct NumberPad : View {
    
    @Binding var codes : [String]
    
    var body : some View {
        
        VStack(alignment: .leading, spacing: 20) {
            
            ForEach(datas) { i in
                
                HStack(spacing: self.getSpacing()) {
                    
                    ForEach(i.row) { j in
                        
                        Button(action: {
                            if j.value == "delete.left.fill" {
                                
                                self.codes.removeLast()
                                
                            }
                            else if j.value == "checkmark.circle.fill" {
                                print("done: \(self.getCode())")
                                self.codes.removeAll()
                            }
                            else {
                                self.codes.append(j.value)
                            }
                        }) {
                            if j.value == "delete.left.fill" || j.value == "checkmark.circle.fill" {
                                Image(systemName: j.value)
                            }
                            else {
                                Text(j.value)
                                    .font(.title)
                                    .fontWeight(.semibold)
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

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
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
    type(id: 1, row: [row(id: 0, value: "5"), row(id: 1, value: "5"), row(id: 2, value: "6")]),
    type(id: 2, row: [row(id: 0, value: "7"), row(id: 1, value: "8"), row(id: 2, value: "9")]),
    type(id: 3, row: [row(id: 0, value: "delete.left.fill"), row(id: 1, value: "0"), row(id: 2, value: "checkmark.circle.fill")])
    
]
