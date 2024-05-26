//
//  GetStartedView.swift
//  aloha
//
//  Created by Jason White on 17/05/24.
//

import SwiftUI

struct GetStartedView: View {
    @StateObject var sharedProfileData = SharedProfileData()
    var body: some View {
        NavigationStack{
        ZStack{
            Color.alohaWhite
            
            VStack(spacing: 0) {
                Image("Logo")
                    .padding(.top, 96)
                
                Spacer()
                
                Image("Get Started")
                
                Spacer()
                
                Text("\"Circle Up, Snap Your Location, Share Your Story!\"")
                    .font(.custom("Poppins-Medium", size: 16))
                    .foregroundColor(Color.alohaBlack)
                    .padding(.bottom, 32)
                
                NavigationLink(destination: NameIntroView()        .environmentObject(sharedProfileData)
){
                    Text("Get Started")
                        .font(.custom("Poppins-Bold", size: 16))
                        .frame(width: 270, height: 56)
                        .foregroundColor(Color.alohaBlack)
                        .background(Color.alohaYellow)
                        .cornerRadius(30)
                }
                .padding(.bottom, 106)
                
            }
        }
        .ignoresSafeArea()
            
        }
    }
}

#Preview {
    GetStartedView()
        .environmentObject(SharedProfileData())
        .environmentObject(SharedStoryData())
}
