//
//  SharedStoryData.swift
//  aloha
//
//  Created by Jason White on 23/05/24.
//

import SwiftUI
import Combine
import MapKit

class SharedStoryData: ObservableObject {
    @Published var sharedStory: String = ""
    @Published var chatLogs: [ChatLog] = []
    
    func addChatLog(name: String, message: String, locationManager: LocationManager) {
        let newChatLog = ChatLog(name: name, message: message, timestamp: Date(), location: locationManager.userAddress, city: locationManager.userCity/*, country: locationManager.userCountry*/)
            chatLogs.append(newChatLog)
        }
}

struct ChatLog: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let message: String
    let timestamp: Date
    let location: String
    let city: String
//    let country: String
}
