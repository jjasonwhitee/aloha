//
//  ShareCodeIntroView.swift
//  aloha
//
//  Created by Jason White on 18/05/24.
//

import SwiftUI

struct ShareCodeIntroView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @Binding var name:String
    
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
                    Text("Share this invite code to your cherished ones")
                        .font(.custom("Poppins-Bold", size: 32))
                        .foregroundColor(.alohaBlack)
                        .padding(.top, 152)
                    
                    ZStack {
                        Image("Cloud")
                        
                        HStack(spacing: 66) {
                            Text("3")
                            Text("9")
                            Text("5")
                            Text("7")
                        }
                        .font(.custom("Poppins-Bold", size: 32))
                        .foregroundColor(.alohaBlue)
                    }
                    .padding(.top, 32)
                    
                    Text("You can share this code any way you like by text it, email it, write it down, or say it.")
                        .font(.custom("Poppins-Medium", size: 16))
                        .foregroundColor(.alohaBlack)
                        .padding(.top, 32)
                    
                    Spacer()
            
                    NavigationLink(destination: AddProfilePictureView(name: $name)){
                        Text("I'm done sharing")
                            .font(.custom("Poppins-Bold", size: 16))
                            .frame(width: 270, height: 56)
                            .foregroundColor(.alohaWhite)
                            .background(.alohaDarkBlue)
                            .cornerRadius(30)
                    }
                    .padding(.bottom, 106)
                    
                }
            }
            .ignoresSafeArea()
        }
        
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    struct PreviewWrapper:View {
        @State var name:String = "Your name"
        var body: some View {
            ShareCodeIntroView(name: $name)
        }
    }
    return PreviewWrapper()
}
