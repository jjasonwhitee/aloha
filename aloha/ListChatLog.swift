//
//  ListContentView.swift
//  aloha
//
//  Created by Jason White on 22/05/24.
//

import SwiftUI
import MapKit

struct ListChatLog: View {
    @Binding var name: String
    @EnvironmentObject var sharedStoryData: SharedStoryData
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading, spacing: 8) {
                if sharedStoryData.chatLogs.isEmpty {
                    VStack {
                        Text("No stories from your Circle yet")
                            .font(.custom("Poppins-Regular", size: 12))
                            .foregroundColor(.alohaBlack)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .padding()
                    .background(.alohaLightYellow)
                    .cornerRadius(15)
                } else {
                    ForEach(sharedStoryData.chatLogs) { log in
                        ChatLogItemView(log: log)
                    }
                }
            }
        }
    }
}
    
struct ChatLogItemView: View {
    var log: ChatLog
    
    @State private var currentDate = Date()
    private let timer = Timer.publish(every: 60, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            HStack {
                Text(log.name)
                    .font(.custom("Poppins-SemiBold", size: 14))
                    .foregroundColor(.alohaDarkBlue)
                
                Text(timeAgoSinceDate(log.timestamp))
                    .font(.custom("Poppins-SemiBold", size: 8))
                    .foregroundColor(.alohaOrange)
            }
            
            HStack(spacing: 5) {
                Image(systemName: "mappin.and.ellipse.circle.fill")
                    .font(.system(size: 12))
                    .foregroundColor(.alohaDarkGreen)
                
                Text("Near \(log.location), \(log.city)")
                    .font(.custom("Poppins-Regular", size: 10))
                    .foregroundColor(.alohaDarkGrey)
            }
            
            Text(log.message)
                .font(.custom("Poppins-Regular", size: 12))
                .foregroundColor(.alohaBlack)
                .frame(maxWidth: .infinity, alignment: .leading)
                .accentColor(.alohaYellow)
                .lineLimit(2)
                .padding(.top, 5)
        }
        .padding()
        .background(.alohaLightYellow)
        .cornerRadius(15)
        .onReceive(timer) { input in
            currentDate = input
        }
    }
    
    private func timeAgoSinceDate(_ date: Date) -> String {
            let formatter = RelativeDateTimeFormatter()
            formatter.unitsStyle = .short
            return formatter.localizedString(for: date, relativeTo: currentDate)
        }
}

struct ListChatLog_Previews: PreviewProvider {
    @State static var name = "Sample Name"
    
    static var sharedStoryData: SharedStoryData = {
        let data = SharedStoryData()
        data.chatLogs = [
            ChatLog(name: "Alice", message: "Hello, this is a test message.", timestamp: Date().addingTimeInterval(-300), location: "New York", city: "New York City"), // 5 minutes ago
            ChatLog(name: "Bob", message: "Another test message for the chat log.", timestamp: Date().addingTimeInterval(-3600), location: "San Francisco", city: "San Francisco") // 1 hour ago
        ]
        return data
    }()
    
    static var previews: some View {
        ListChatLog(name: $name)
            .environmentObject(sharedStoryData)
            .previewLayout(.sizeThatFits)
    }
}
