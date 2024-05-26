//
//  MapView.swift
//  aloha
//
//  Created by Jason White on 19/05/24.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    var imageName: String
    
    @State var mapRegion:MapCameraPosition = MapCameraPosition.userLocation(fallback: .automatic)
    @StateObject var locationManager: LocationManager = .init()
    @State var showMap: Bool = false
    
    @State private var isBottomSideSheetOpen: Bool = false
    @State private var isProfileSheetOpen: Bool = false
    @State private var isShowingSheet = true
    
    @Binding var name: String
    
    @State private var showNewCircleSheet = false
    @State private var showShareCodeSheet = false
    
    @State private var chatBox = ""
    
    @FocusState private var focus : Bool
    @EnvironmentObject var sharedStoryData: SharedStoryData
    
    @State private var isShowingChatBox = false
    
    var body: some View {
        NavigationStack{
            ZStack{
                Map(position: $mapRegion){
                    UserAnnotation()
                    Annotation("\(name)'s Location", coordinate: CLLocationCoordinate2D(latitude: locationManager.userLocation.latitude, longitude: locationManager.userLocation.longitude)){
                        
                        CustomUserAnnotationView(imageName: imageName, isShowingChatBox: $isShowingChatBox, isProfileSheetOpen: $isProfileSheetOpen)
                            .offset(y: -70)
                    }
                    .annotationTitles(.hidden)
                    
                    Annotation("Additional Location", coordinate: CLLocationCoordinate2D(latitude: -6.3025, longitude: 106.6520)) {
                                            CustomUserAnnotationDummyView(imageName: "Girl 2")
                                        }
                                        .annotationTitles(.hidden)
                    
                }
                .mapControls{
                    MapUserLocationButton()
                        .mapControlVisibility(.automatic)
                    MapCompass()
                        .mapControlVisibility(.automatic)
                }
                .controlSize(.large)
                .tint(.alohaOrange)
                .onMapCameraChange(frequency: .onEnd) {
                    
                }
                
                VStack {
                    HStack {
                        BottomSideSheetView(
                            isOpen: $isBottomSideSheetOpen,
                            maxHeight: 800,
                            minHeight: 100,
                            width: 325
                        ) {
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("Hi! Aloha")
                                        .font(.custom("Poppins-Bold", size: 32))
                                        .foregroundColor(.alohaBlack)
                                    
                                    Image("Smile Landscape")
                                }
                                .padding(.top)
                                
                                HStack(alignment: .top) {
//                                                                        DropdownButtonView()
                                    
                                    Button{
                                        showNewCircleSheet = true
                                    } label: {
                                        ZStack {
                                            Circle()
                                                .frame(width: 40, height: 40)
                                                .foregroundColor(.alohaYellow)
                                            
                                            Image(systemName: "plus")
                                                .font(.system(size: 10))
                                                .fontWeight(.bold)
                                                .foregroundColor(.alohaBlack)
                                        }
                                        
                                    }
                                    
                                    .sheet(isPresented: $showNewCircleSheet) {
                                        SheetNewCircleView()
                                    }
                                }
                                
                                Text("People ")
                                    .font(.custom("Poppins-Bold", size: 24))
                                    .foregroundColor(.alohaBlack)
                                
                                
                                VStack(spacing: 15){
                                    Button{
                                        isProfileSheetOpen.toggle()
                                        
                                    } label: {
                                        PeopleLocationView(imageName: imageName, name: $name)
                                    }
                                    
                                    
                                    Button{
                                        
                                    } label: {
                                        PeopleLocationDummyView(imageName: "Girl 2", name: .constant("Jane Doe"))
                                    }
                                    
                                    
                                    Button{
                                        showShareCodeSheet = true
                                        
                                    } label: {
                                        HStack (spacing: 15){
                                            VStack {
                                                Image(systemName: "person.2.fill")
                                                    .font(.system(size: 24))
                                                    .foregroundColor(.alohaYellow)
                                            }
                                            .frame(width: 70, height: 70)
                                            .background(.alohaLightYellow)
                                            .cornerRadius(50)
                                            
                                            VStack(alignment: .leading, spacing: 0){
                                                
                                                Text("Add a Person")
                                                    .font(.custom("Poppins-Bold", size: 16))
                                                    .foregroundColor(.alohaBlue)
                                            }
                                            
                                            Spacer()
                                        }
                                    }
                                    .sheet(isPresented: $showShareCodeSheet) {
                                        SheetShareCodeView()
                                    }
                                }
                                .padding(.bottom)
                                
                                Text("Log")
                                    .font(.custom("Poppins-Bold", size: 24))
                                    .foregroundColor(.alohaBlack)
                                
                                ListChatLog(name: $name)
                                    .environmentObject(sharedStoryData)
                                    .padding(.bottom, 33)
                                
                            }
                            .padding(.horizontal, 26)
                        }
                        
                    }
                }
                .ignoresSafeArea()
                .padding(.leading, 32)
                .onAppear {
                    isBottomSideSheetOpen = true // Optionally open the sheet on launch
                }
                
                
                //              Content Sheet Button from People
                
                VStack {
                    HStack {
                        ProfileSheetView(
                            isOpen: $isProfileSheetOpen,
                            maxHeight: 800,
                            width: 325
                        ) {
                            VStack(alignment: .leading) {
                                
                                PeopleLocationView(imageName: imageName, name: $name)
                                    .padding(.top)
                                
                                Text("Share with your circle")
                                    .font(.custom("Poppins-Bold", size: 14))
                                    .foregroundColor(.alohaBlack)
                                    .padding(.top, 15)
                                
                                VStack{
                                    ZStack{
                                        Image("Type Chat Box")
                                        
                                        HStack{
                                            TextField("Share your stories", text: $chatBox)
                                                .font(.custom("Poppins-Regular", size: 12))
                                                .foregroundColor(.alohaBlack)
                                                .frame(width: 199, height: 40)
                                                .accentColor(.alohaYellow)
                                                .lineLimit(2)
                                                .focused($focus, equals: isProfileSheetOpen)
                                                .onAppear {
                                                    focus = isProfileSheetOpen // Focus when sheet is opened
                                                }
                                                .onDisappear {
                                                    focus = false // Unfocus when sheet is closed
                                                }
                                                .disableAutocorrection(true)
                                                .padding(.bottom, 5)
                                            Button{
                                                locationManager.reverseGeocode(location: CLLocation(latitude: locationManager.userLocation.latitude, longitude: locationManager.userLocation.longitude))
                                                
                                                sharedStoryData.addChatLog(name: name, message: chatBox, locationManager: locationManager)
                                                
                                                sharedStoryData.sharedStory = chatBox
                                                
                                                chatBox = ""
                                                isProfileSheetOpen = false
                                                isShowingChatBox = true
                                                focus = false
                                            } label: {
                                                Image(systemName: "paperplane.fill")
                                                    .font(.system(size: 12))
                                                    .foregroundColor(chatBox.isEmpty ? .alohaGrey : .alohaYellow)
                                                
                                            }
                                            .padding(.bottom, 3)
                                            .disabled(chatBox.isEmpty)
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal, 26)
                            
                        }
                        
                    }
                }
                .ignoresSafeArea()
                .padding(.leading, 32)
                .onAppear {
                    isProfileSheetOpen = false // Optionally open the sheet on launch
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State var name: String = "Your Name"
        @ObservedObject var sharedProfileData: SharedProfileData = SharedProfileData()
        @ObservedObject var sharedStoryData: SharedStoryData = SharedStoryData()
        
        var body: some View {
            MapView(imageName: "Boy 1", name: $name)
                .environmentObject(SharedProfileData())
                .environmentObject(sharedStoryData)
                .onAppear {
                    sharedProfileData.circles.append("Circle 1")
                }
        }
    }
    return PreviewWrapper()
}
