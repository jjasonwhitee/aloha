//
//  CircleNameIntroView.swift
//  aloha
//
//  Created by Jason White on 18/05/24.
//

import SwiftUI
import SwiftData

struct CircleNameIntroView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State private var circleName = ""
    @State private var isShowShareCodeIntroView: Bool = false
    
    @EnvironmentObject var sharedProfileData: SharedProfileData
    
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \CircleData.circleName, order: .forward, animation: .smooth) var Circles:[CircleData]
    
    @FocusState private var focus : Bool
    
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

                    
                VStack(spacing:0) {
                    Text("Give your Circle a name")
                        .font(.custom("Poppins-Bold", size: 32))
                        .foregroundColor(.alohaBlack)
                        .padding(.top, 152)
                    
                    ZStack {
                        Rectangle()
                            .frame(width: 414, height: 56)
                            .foregroundColor(.alohaWhite)
                            .cornerRadius(30)
                        
                        TextField("your circle name", text: $circleName)
                            .font(.custom("Poppins-Regular", size: 16))
                            .foregroundColor(.alohaBlack)
                            .frame(width: 347, height: 56)
                            .accentColor(.alohaYellow)
                        
                        
                            .focused($focus, equals: true)
                            .onAppear() {
                                focus = true
                            }
                            .disableAutocorrection(true)
                        
                    }
                    .padding(.top, 32)
                    
                    Spacer()
                    
                    Text("You can make additional Circles for any group in your life.")
                        .font(.custom("Poppins-Medium", size: 16))
                        .foregroundColor(.alohaBlack)
                        .padding(.bottom, 35)
                    
                    Button {
                        isShowShareCodeIntroView = true
                        sharedProfileData.circles.append(circleName)
                        
                        do {
                            try modelContext.save()
                        } catch {
                            print("error saving to swiftdata")
                        }
                        
                        print(sharedProfileData.circles)
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
            .navigationDestination(isPresented: $isShowShareCodeIntroView) {
                ShareCodeIntroView(name: $name)
            }
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
    struct PreviewWrapper: View {
        @State var name:String = "Your Name"
        var body: some View {
            CircleNameIntroView(name: $name)
        }
    }
    return PreviewWrapper()
}
