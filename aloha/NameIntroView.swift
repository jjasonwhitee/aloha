//
//  NameIntroView.swift
//  aloha
//
//  Created by Jason White on 17/05/24.
//

import SwiftUI

struct NameIntroView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>

    @State private var name = ""
    @FocusState private var focus : Bool
    
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
                    Text("What's Your Name")
                        .font(.custom("Poppins-Bold", size: 32))
                        .foregroundColor(.alohaBlack)
                        .padding(.top, 152)
                    
                    ZStack {
                        Rectangle()
                            .frame(width: 414, height: 56)
                            .foregroundColor(.alohaWhite)
                            .cornerRadius(30)
                        
                        TextField("your name", text: $name)
                            .font(.custom("Poppins-Reggular", size: 16))
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
                    
                    NavigationLink(destination: ConfirmationIntroView(name: $name)){
                        Text("Continue")
                            .font(.custom("Poppins-Bold", size: 16))
                            .frame(width: 270, height: 56)
                            .foregroundColor(.alohaWhite)
                            .background(name == "" ? .alohaGrey : .alohaDarkBlue)
                            .cornerRadius(30)
                    }
                    .disabled(name == "" ? true : false)
                    .padding(.bottom, 106)
                    
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
    NameIntroView()
}
