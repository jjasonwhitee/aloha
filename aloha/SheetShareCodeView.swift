//
//  SheetShareCodeView.swift
//  aloha
//
//  Created by Jason White on 21/05/24.
//

import SwiftUI

struct SheetShareCodeView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack{
            Color.alohaYellow
            
            VStack(spacing: 0) {
                Text("Share this invite code to your cherished ones")
                    .font(.custom("Poppins-Bold", size: 32))
                    .foregroundColor(.alohaBlack)
                    .padding()
                    .multilineTextAlignment(.center)
                
                ZStack {
                    Rectangle()
                        .frame(width: 414, height: 64)
                        .foregroundColor(.alohaWhite)
                        .cornerRadius(40)
                    
                    HStack(spacing: 66) {
                        Text("3")
                        Text("9")
                        Text("5")
                        Text("7")
                    }
                    .font(.custom("Poppins-Bold", size: 32))
                    .foregroundColor(.alohaBlue)
                }
                .padding()
                
                
                
//                Spacer()
                
                Button{
                    presentationMode.wrappedValue.dismiss()
                    
                } label: {
                    Text("I'm done sharing")
                        .font(.custom("Poppins-Bold", size: 16))
                        .frame(width: 270, height: 56)
                        .foregroundColor(.alohaWhite)
                        .background(.alohaDarkBlue)
                        .cornerRadius(30)
                }
                .padding(.top, 70)
                
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    SheetShareCodeView()
}
