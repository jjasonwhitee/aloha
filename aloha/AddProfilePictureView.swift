//
//  AddProfilePictureView.swift
//  aloha
//
//  Created by Jason White on 18/05/24.
//

import SwiftUI

enum Avatar: CaseIterable {
    case girl1
    case boy1
    case girl2
    case boy2
    
    var imageName: String {
        switch self {
        case .girl1:
            "Girl 1"
        case .boy1:
            "Boy 1"
        case .girl2:
            "Girl 2"
        case .boy2:
            "Boy 2"
        }
    }
}

struct AddProfilePictureView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @State var imageName : String?
    @State var selectedAvatarImage: String?
    
    @Binding var name: String
//    @State private var isSelected: Bool = false
    
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
                    Text("Select your Avatar")
                        .font(.custom("Poppins-Bold", size: 32))
                        .foregroundColor(.alohaBlack)
                        .padding(.top, 152)
                    
                    Image("Map Illust")
                        .padding(.top, 19)
                    
                    Text("Help your loved ones to find you!")
                        .font(.custom("Poppins-Medium", size: 16))
                        .foregroundColor(.alohaBlack)
                        .padding(.top, 32)
                    
                    HStack(spacing: 36) {
                        ForEach(Avatar.allCases, id: \.self) { avatar in
                            Button {
                                selectedAvatarImage = avatar.imageName
                            } label: {
                                AvatarView(characaterAvatar: avatar.imageName)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 50)
                                            .stroke(avatar.imageName == selectedAvatarImage ? Color.alohaBlue : Color.clear, lineWidth: 4)
                                    )
                            }
                            
                        }
                    }
                    .padding(.top)
                    
                    Spacer()
                    
                    NavigationLink(destination: MapView(imageName: selectedAvatarImage ?? "-", name: $name)){
                        Text("Done")
                            .font(.custom("Poppins-Bold", size: 16))
                            .frame(width: 270, height: 56)
                            .foregroundColor(.alohaWhite)
                            .background(imageName == selectedAvatarImage ? .alohaGrey : .alohaDarkBlue)
                            .cornerRadius(30)
                    }
                    .disabled(imageName == selectedAvatarImage ? true : false)
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
            AddProfilePictureView(name: $name)
        }
    }
    return PreviewWrapper()
}

struct AvatarView: View {
    var characaterAvatar: String
    
    var body: some View {
        Image(characaterAvatar)
            .frame(width: 88, height: 88)
            .background(.alohaWhite)
            .cornerRadius(50)
    }
}

