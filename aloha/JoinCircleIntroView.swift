//
//  JoinCircleIntroView.swift
//  aloha
//
//  Created by Jason White on 18/05/24.
//

import SwiftUI

struct JoinCircleIntroView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @State var code: [String] = ["","","",""]
    @Binding var name: String
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color.alohaYellow
                
                VStack {
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        Image("Smile")
                            .padding(.trailing, 100)
                            .padding(.bottom, 122)
                    }
                }
                
                VStack(spacing: 0) {
                    Text("Joining a Circle? Enter your Invite Code")
                        .font(.custom("Poppins-Bold", size: 32))
                        .foregroundColor(.alohaBlack)
                        .padding(.top, 152)
                    
                    HStack(spacing: 66) {
                        CodeInputView(code: $code)
                    }
                    
                    Text("You may need to ask the Circle creator for the code.")
                        .font(.custom("Poppins-Medium", size: 16))
                        .foregroundColor(.alohaBlack)
                        .padding(.top, 56)
                    
                    Spacer()
                    
                    NavigationLink(destination: AddProfilePictureView(name: $name)){
                        Text("Continue")
                            .font(.custom("Poppins-Bold", size: 16))
                            .frame(width: 270, height: 56)
                            .foregroundColor(.alohaWhite)
                            .background(isCodeNotEmpty() ? .alohaDarkBlue : .alohaGrey)
                            .cornerRadius(30)
                    }
                    .padding(.bottom, 106)
                    .disabled(!isCodeNotEmpty())
                    
                }
            }
            .ignoresSafeArea()
        }
        
        
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading, content: {
                Button {
                    mode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 24))
                        .fontWeight(.bold)
                        .foregroundColor(.alohaBlack)
                }
                
            })
        }
    }
    
    func isCodeNotEmpty() -> Bool {
        if code[0] == "" {
            return false
        } else {
            if code[1] == "" {
                return false
            } else {
                if code[2] == "" {
                    return false
                } else {
                    if code[3] == "" {
                        return false
                    } else {
                        return true
                    }
                }
            }
        }
    }
}

#Preview {
    struct PreviewWrapper:View {
        @State var name:String = "Your name"
        var body: some View {
            JoinCircleIntroView(name: $name)
        }
    }
    return PreviewWrapper()
}

