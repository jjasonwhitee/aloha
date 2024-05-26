//
//  CustomUserAnnotation.swift
//  aloha
//
//  Created by Jason White on 21/05/24.
//

import SwiftUI

struct CustomUserAnnotationView: View {
    var imageName: String
    @Binding var isShowingChatBox: Bool
    @Binding var isProfileSheetOpen: Bool
    @EnvironmentObject var sharedStoryData: SharedStoryData


    var body: some View {
        VStack(spacing: 0) {
                ChatBoxView(isShowingChatBox: $isShowingChatBox)
                    .scaleEffect(isShowingChatBox ? 1 : 0.5) // Scale effect for the pop-up
                    .opacity(isShowingChatBox ? 1 : 0) // Fade effect
                    .animation(Animation.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0), value: isShowingChatBox)
            
            Button{
                isProfileSheetOpen.toggle()
            } label: {
                ZStack {
                    Image("Location Frame")
                        .shadow(color: .black, radius: 0, x: 0, y: 5)
                        .blur(radius: 5, opaque: false)
                        .opacity(0.15)
                    
                    Image("Location Frame")
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .padding(3)
                        .frame(width: 40, height: 40)
                        .padding(.bottom, 4)
                }
            }
            
        }
    }
}

struct ChatBoxView: View {
    @Binding var isShowingChatBox: Bool
    @EnvironmentObject var sharedStoryData: SharedStoryData

    var body: some View {
        ZStack {
            Image("Chat Box")
                .shadow(color: .black, radius: 0, x: 0, y: 5)
                .blur(radius: 5, opaque: false)
                .opacity(0.15)
            
            Image("Chat Box")
            
            HStack {
                Text(sharedStoryData.sharedStory.isEmpty ? "The Stories" : sharedStoryData.sharedStory)
                    .font(.custom("Poppins-Regular", size: 12))
                    .foregroundColor(.alohaBlack)
                    .frame(width: 199, height: 40, alignment: .center)
                    .accentColor(.alohaYellow)
                    .lineLimit(2)
                    .padding(.bottom, 20)
            }
        }
    }
}

#Preview {
    CustomUserAnnotationView(imageName: "Boy 1", isShowingChatBox: .constant(false), isProfileSheetOpen: .constant(false))
        .environmentObject(SharedStoryData())
}
