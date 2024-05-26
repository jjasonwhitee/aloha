//
//  PeopleLocationView.swift
//  aloha
//
//  Created by Jason White on 20/05/24.


import SwiftUI
import MapKit

struct PeopleLocationView: View {
    
    var imageName: String
    @Binding var name: String
    
    @State var location : String = ""
    @State var locationManager = LocationManager()
    @State private var currentTime: String = DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .short)
    
    var body: some View {
            HStack (spacing: 15){
                VStack {
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .padding(13)
                }
                .frame(width: 70, height: 70)
                .background(.alohaLightYellow)
                .cornerRadius(50)
                
                
                VStack(alignment: .leading, spacing: 0){
                    Text("\(name)")
                        .font(.custom("Poppins-Bold", size: 16))
                        .foregroundColor(.alohaBlack)
                    
                    HStack {
                        Text("Near \(location)")
                            .font(.custom("Poppins-Regular", size: 14))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(.alohaBlack)
                        
                    }
                       
                    
                    Text("At \(currentTime)")
                        .font(.custom("Poppins-Regular", size: 12))
                        .foregroundColor(.alohaBlack)
                }
                
                Spacer()
            }
        
    
        
        
        //        .onAppear(){
        //            var userLocation = locationManager.userLocation
        //            var coordinate = CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude)
        //            CLGeocoder().reverseGeocodeLocation(coordinate) { placemarks, error in
        //                guard let placemark = placemarks?.first else { return }
        //                let reversedGeoLocation = GeoLocation(with: placemark)
        //                location = reversedGeoLocation.name
        //            }
        //
        //            print("Place Name: \(location)")
        //        }
        //    }
        //}
        
        .onAppear {
            locationManager.manager.startUpdatingLocation()
            updateLocation()
        }
        .onChange(of: locationManager.userLocation) { _ in
            updateLocation()
        }
    }
    
    private func updateLocation() {
        let userLocation = locationManager.userLocation
        let coordinate = CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude)
        CLGeocoder().reverseGeocodeLocation(coordinate) { placemarks, error in
            guard let placemark = placemarks?.first else { return }
            let reversedGeoLocation = GeoLocation(with: placemark)
            location = reversedGeoLocation.name
        }
        
        currentTime = DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .short)
        
        print("Place Name: \(location)")
        print("Current Time: \(currentTime)")
    }
}

#Preview {
    PeopleLocationView(imageName: "Boy 1", name: .constant("String"))
}
