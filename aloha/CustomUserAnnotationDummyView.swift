//
//  CustomUserAnnotationDummyView.swift
//  aloha
//
//  Created by Jason White on 25/05/24.
//

import SwiftUI

struct CustomUserAnnotationDummyView: View {
    var imageName: String
    
    var body: some View {
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



#Preview {
    CustomUserAnnotationDummyView(imageName: "Boy 1")
}
