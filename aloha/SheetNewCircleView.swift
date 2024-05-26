//
//  SheetNewCircleView.swift
//  aloha
//
//  Created by Jason White on 21/05/24.
//

import SwiftUI

struct SheetNewCircleView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var circleName = ""
    @FocusState private var focus : Bool
    @EnvironmentObject var sharedProfileData: SharedProfileData
    
    var body: some View {
        ZStack{
            Color.alohaYellow
            
            VStack{
                HStack{
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 24))
                            .fontWeight(.bold)
                            .foregroundColor(.alohaBlack)
                            .opacity(focus ? 0 : 1)
                    }
                    .padding(.top, 32)
                    .padding(.leading, 25)
                    
                    Spacer()
                }
                
                Spacer()
            }
            
            
            VStack(spacing:0) {
                Text("Make a New Circle")
                    .font(.custom("Poppins-Bold", size: 32))
                    .foregroundColor(.alohaBlack)
                    .padding(.top, 152)
                
                ZStack {
                    Rectangle()
                        .frame(width: 414, height: 56)
                        .foregroundColor(.alohaWhite)
                        .cornerRadius(30)
                    
                    TextField("your circle name", text: $circleName)
                        .font(.custom("Poppins-Reggular", size: 16))
                        .foregroundColor(.alohaBlack)
                        .frame(width: 347, height: 56)
                        .accentColor(.alohaYellow)
                        .focused($focus, equals: true)
                        .onAppear() {
                            focus = true
                        }
                        .onDisappear() {
                            focus = false
                        }
                        .disableAutocorrection(true)
                    
                }
                .padding(.top, 32)
                
                Spacer()
                
                Button{
                    presentationMode.wrappedValue.dismiss()
                    sharedProfileData.circles.append(circleName)
                } label: {
                    Text("Continue")
                        .font(.custom("Poppins-Bold", size: 16))
                        .frame(width: 270, height: 56)
                        .foregroundColor(.alohaWhite)
                        .background(circleName == "" ? .alohaGrey : .alohaDarkBlue)
                        .cornerRadius(30)
                }
                .disabled(circleName == "" ? true : false)
                .padding(.bottom, 106)
            }
            
        }
        .ignoresSafeArea()
        

    }
        
}

#Preview {
    SheetNewCircleView()
}
