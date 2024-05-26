//
//  ConfirmationIntroView.swift
//  aloha
//
//  Created by Jason White on 18/05/24.
//

import SwiftUI

struct ConfirmationIntroView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
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
                    Text("Hello, \(name)!")
                        .font(.custom("Poppins-Bold", size: 32))
                        .foregroundColor(.alohaBlack)
                        .padding(.top, 136)
                    
                    Text("Create Your Circle, Share the Moment!")
                        .font(.custom("Poppins-Bold", size: 32))
                        .foregroundColor(.alohaBlack)
                        .padding(.top, 8)
                    
                    Spacer()
                    
                    Image("Planet")
                    
                    Spacer()
                    
                    NavigationLink(destination: JoinCircleIntroView(name: $name)){
                        Text("Continue")
                            .font(.custom("Poppins-Bold", size: 16))
                            .frame(width: 270, height: 56)
                            .foregroundColor(.alohaWhite)
                            .background(.alohaDarkBlue)
                            .cornerRadius(30)
                    }
                    .padding(.bottom, 14)
                    
                    HStack {
                        Text("Already have a Circle?")
                            .font(.custom("Poppins-Medium", size: 16))
                            .foregroundColor(.alohaBlack)
                        
                        NavigationLink(destination: CircleNameIntroView(name: $name)){
                            Text("Join Now")
                                .font(.custom("Poppins-Bold", size: 16))
                                .foregroundColor(.alohaDarkBlue)
                        }
                    }
                    .padding(.bottom, 100)
                    
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
}

#Preview {
    struct PreviewWrapper:View {
        @State var name:String = "your name"
        var body: some View {
            ConfirmationIntroView(name: $name)
        }
    }
    return PreviewWrapper()
}
