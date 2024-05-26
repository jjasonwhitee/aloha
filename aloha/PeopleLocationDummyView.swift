//
//  PeopleLocationDummyView.swift
//  aloha
//
//  Created by Jason White on 24/05/24.
//

import SwiftUI
import MapKit

struct PeopleLocationDummyView: View {
    
    var imageName: String
    @Binding var name: String
    
    @State private var location: String = ""
    @State private var currentTime: String = DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .short)
    
    var body: some View {
        HStack (spacing: 15) {
            VStack {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .padding(13)
            }
            .frame(width: 70, height: 70)
            .background(Color.alohaLightYellow)
            .cornerRadius(50)
            
            VStack(alignment: .leading, spacing: 0) {
                Text("\(name)")
                    .font(.custom("Poppins-Bold", size: 16))
                    .foregroundColor(.alohaBlack)
                
                HStack {
                    Text("Near \(location)")
                        .font(.custom("Poppins-Regular", size: 14))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.alohaBlack)
                        .lineLimit(2)
                }
                
                Text("At \(currentTime)")
                    .font(.custom("Poppins-Regular", size: 12))
                    .foregroundColor(.alohaBlack)
            }
            
            Spacer()
        }
        .onAppear {
            updateLocation()
        }
    }
    
    private func updateLocation() {
        let fixedLatitude: CLLocationDegrees = -6.3025
        let fixedLongitude: CLLocationDegrees = 106.6520  // Adjusted to a more likely longitude value
        let coordinate = CLLocation(latitude: fixedLatitude, longitude: fixedLongitude)
        
        CLGeocoder().reverseGeocodeLocation(coordinate) { placemarks, error in
            if let error = error {
                print("Geocoding error: \(error.localizedDescription)")
                return
            }
            
            guard let placemark = placemarks?.first else {
                print("No placemarks found")
                return
            }
            
            let reversedGeoLocation = GeoLocation(with: placemark)
            location = reversedGeoLocation.name
            print("Resolved location name: \(location)")
        }
        
        currentTime = DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .short)
        
        print("Current Time: \(currentTime)")
    }
}

#Preview {
    PeopleLocationDummyView(imageName: "Boy 1", name: .constant("String"))
}
