//
//  DropdownButtonView.swift
//  aloha
//
//  Created by Jason White on 20/05/24.
//


import SwiftUI

struct DropdownButtonView: View {
    @State var selection1: String? = nil
    @EnvironmentObject var sharedProfileData: SharedProfileData
    
    var body: some View {
        DropDownPicker(
            selection: $selection1,
            options: sharedProfileData.circles
        )
    }
}

enum DropDownPickerState {
    case top
    case bottom
}

struct DropDownPicker: View {
    
    @Binding var selection: String?
    var state: DropDownPickerState = .bottom
    var options: [String]
//    var maxWidth: CGFloat = 180
    
    @State var showDropdown = false
    
    @SceneStorage("drop_down_zindex") private var index = 1000.0
    @State var zindex = 1000.0
    
    var body: some View {
        VStack {
            GeometryReader {
                let size = $0.size
                
                VStack(spacing: 0) {
                    
                    
                    if state == .top && showDropdown {
                        OptionsView()
                    }
                    
                    HStack {
                        Text((selection == nil ? options.first : selection!) ??  "-")
                            .font(.custom("Poppins-Bold", size: 12))
                            .foregroundColor(.alohaBlack)
                           
                        
                        
                        Spacer(minLength: 0)
                        
                        Image(systemName: state == .top ? "chevron.up" : "chevron.down")
                            .font(.system(size: 12))
                            .fontWeight(.bold)
                            .foregroundColor(.alohaBlack)
                            .rotationEffect(.degrees((showDropdown ? -180 : 0)))
                    }
                    .padding(.horizontal, 15)
                    .frame(maxWidth: .infinity, maxHeight: 40)
                    .frame(height: 40)
                    .background(.alohaYellow)
                    .contentShape(.rect)
                    .onTapGesture {
                        index += 1
                        zindex = index
                        withAnimation(.snappy) {
                            showDropdown.toggle()
                        }
                    }
                    .zIndex(10)
                    
                    if state == .bottom && showDropdown {
                        OptionsView()
                    }
                }
                .clipped()
                .background(.alohaWhite)
                .cornerRadius(30)
                .overlay {
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(.alohaYellow)
                }
                .frame(height: size.height, alignment: state == .top ? .bottom : .top)
                
            }
            .frame(maxWidth: .infinity, maxHeight: 50)
            .zIndex(zindex)
            .onAppear {
                selection = options[0]
            }
            VStack {
                
            }
            .frame(maxWidth: .infinity, maxHeight: showDropdown ? CGFloat(options.count) * 40 : 0)
        }
    }
    
    
    func OptionsView() -> some View {
        VStack(spacing: 0) {
            ForEach(options, id: \.self) { option in
                HStack {
                    Text(option)
                        .font(.custom("Poppins-Bold", size: 12))
                        .foregroundColor(selection == option ? .alohaBlack : .alohaGrey)
                    Spacer()
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.alohaYellow)
                        .opacity(selection == option ? 1 : 0)
                }
                .animation(.none, value: selection)
                .frame(height: 40)
                .contentShape(.rect)
                .padding(.horizontal, 15)
                .onTapGesture {
                    withAnimation(.snappy) {
                        selection = option
                        showDropdown.toggle()
                    }
                }
            }
        }
        .transition(.move(edge: state == .top ? .bottom : .top))
        .zIndex(1)
    }
}

struct DropdownButtonView_Previews: PreviewProvider {
    static var sharedProfileData: SharedProfileData = {
        let data = SharedProfileData()
        data.circles = ["Circle 1", "Circle 2", "Circle 3"]
        return data
    }()
    
    static var previews: some View {
        DropdownButtonView()
            .environmentObject(sharedProfileData)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
