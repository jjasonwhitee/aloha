////
////  CodeInputView.swift
////  aloha
////
////  Created by Jason White on 18/05/24.
////

//import SwiftUI
//
//struct CodeInputView: View {
//    let numberOfFields: Int
//    
//    @State private var code: [String]
//    @FocusState private var focus : Bool
//    @FocusState private var fieldFocus: Int?
//    @State private var oldValue = ""
//    
//    init(numberOfFields: Int) {
//        self.numberOfFields = numberOfFields
//        self.code = Array(repeating: "", count: numberOfFields)
//
//    }
//    
//    var body: some View {
//            HStack(spacing: 66) {
//                ForEach(0..<numberOfFields, id: \.self) { index in
//                        
//                        TextField("", text: $code[index], onEditingChanged: { editing in
//                            
//                            if editing{
//                                oldValue = code[index]
//                            }
//                        })
//                            .keyboardType(.numberPad)
//                            .font(.custom("Poppins-Bold", size: 32))
//                            .foregroundColor(.alohaBlue)
//                            .frame(width: 77, height: 77)
//                            .background(.alohaWhite)
//                            .cornerRadius(50)
//                            .accentColor(.clear)
//                            .multilineTextAlignment(.center)
//                        
//                            .focused($focus, equals: true)
//                            .onAppear() {
//                                focus = true
//                            }
//                        
//                            .focused($fieldFocus, equals: index)
//                            .tag(index)
//                            .onChange(of: code[index]) { newValue in
//                                if code[index].count > 1 {
//                                    let currentValue = Array(code[index])
//                                    
//                                    if currentValue[0] == Character(oldValue) {
//                                        code[index] = String(code[index].suffix(1))
//                                    } else {
//                                        code[index] = String(code[index].prefix(1))
//                                        
//                                    }
//                                }
//                            
//                                if !newValue.isEmpty {
//                                    if index == numberOfFields - 1{
//                                        fieldFocus = nil
//                                    } else {
//                                        fieldFocus = (fieldFocus ?? 0) + 1
//                                    }
//                                } else {
//                                    fieldFocus = (fieldFocus ?? 0) - 1
//                                }
//                            }
//                }
//            }
//            .padding(.top, 57)
//        }
//    }
//
//
//#Preview {
//    CodeInputView(numberOfFields: 4)
//}

import SwiftUI

struct CodeInputView: View {
    let numberOfFields: Int = 4
    
    @Binding var code: [String]
    @FocusState private var fieldFocus: Int?
    @State private var oldValue = ""
    
    var body: some View {
        HStack(spacing: 66) {
            ForEach(0..<numberOfFields, id: \.self) { index in
                TextField("", text: $code[index], onEditingChanged: { editing in
                    if editing {
                        oldValue = code[index]
                    }
                })
                .keyboardType(.numberPad)
                .font(.custom("Poppins-Bold", size: 32))
                .foregroundColor(.alohaBlue)
                .frame(width: 77, height: 77)
                .background(Color.alohaWhite)
                .cornerRadius(50)
                .accentColor(.clear)
                .multilineTextAlignment(.center)
                .focused($fieldFocus, equals: index)
                .tag(index)
                .onChange(of: code[index]) { newValue in
                    if code[index].count > 1 {
                        let currentValue = Array(code[index])
                        
                        if currentValue[0] == Character(oldValue) {
                            code[index] = String(code[index].suffix(1))
                        } else {
                            code[index] = String(code[index].prefix(1))
                        }
                    }
                    
                    if !newValue.isEmpty {
                        if index == numberOfFields - 1 {
                            fieldFocus = nil
                        } else {
                            fieldFocus = (fieldFocus ?? 0) + 1
                        }
                    } else {
                        if index > 0 {
                            fieldFocus = (fieldFocus ?? 0) - 1
                        }
                    }
                }
                .onAppear {
                    if index == 0 {
                        fieldFocus = 0
                    }
                }
            }
        }
        .padding(.top, 57)
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State var code: [String] = ["","","",""]
        var body: some View {
            CodeInputView(code: $code)
        }
    }
    return PreviewWrapper()
}
