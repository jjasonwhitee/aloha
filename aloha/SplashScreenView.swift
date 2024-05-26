//
//  SplashScreenView.swift
//  aloha
//
//  Created by Jason White on 17/05/24.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var showSplash = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        if showSplash {
            ContentView()
        } else {
            ZStack{
                Color.alohaWhite
                
                ZStack {
                    Image("Logo")
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear{
                    withAnimation(.easeIn(duration: 1.2)) {
                        self.size = 0.9
                        self.opacity = 1
                        
                    }
                    
                }
            }
            .ignoresSafeArea()
            
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        self.showSplash = true
                    }
                    
                }
            }
            
        }
        
        
    }
}

#Preview {
    SplashScreenView()
}
