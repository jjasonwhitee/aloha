//
//  alohaApp.swift
//  aloha
//
//  Created by Jason White on 17/05/24.
//

import SwiftUI
import SwiftData

@main
struct alohaApp: App {
    var body: some Scene {
        @ObservedObject var sharedProfileData: SharedProfileData = SharedProfileData()
        
        WindowGroup {
            SplashScreenView()
        }
        .environmentObject(sharedProfileData)
        .environmentObject(SharedStoryData())
    }
}
