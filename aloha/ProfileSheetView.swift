//
//  ProfileSheetView.swift
//  aloha
//
//  Created by Jason White on 22/05/24.
//

import SwiftUI

struct ProfileSheetView<Content: View>: View {
    @Binding var isOpen: Bool
    let maxHeight: CGFloat
    let width: CGFloat
    let content: Content

    @GestureState private var translation: CGFloat = 0

    private var offset: CGFloat {
        isOpen ? 0 : maxHeight
    }

    private var indicator: some View {
        RoundedRectangle(cornerRadius: 5.0)
            .fill(Color.alohaGrey)
            .frame(
                width: 40,
                height: 6
            )
    }

    init(isOpen: Binding<Bool>, maxHeight: CGFloat, width: CGFloat, @ViewBuilder content: () -> Content) {
        self._isOpen = isOpen
        self.maxHeight = maxHeight
        self.width = width
        self.content = content()
    }

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                self.indicator
                    .padding(.top, 8)
                    .padding(.bottom, 8)
                self.content
            }
            .frame(width: self.width, height: self.maxHeight, alignment: .top)
            .background(Color.alohaWhite)
            .clipShape(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
            )
            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .bottomLeading)
            .offset(y: max(self.offset + self.translation, 0))
            .animation(.interactiveSpring(response: 0.5, dampingFraction: 0.75, blendDuration: 0.75), value: self.isOpen)
            .gesture(
                DragGesture().updating(self.$translation) { value, state, _ in
                    state = value.translation.height
                }.onEnded { value in
                    let snapDistance = self.maxHeight * 0.25
                    if value.translation.height > snapDistance {
                        withAnimation {
                            self.isOpen = false
                        }
                    } else {
                        withAnimation {
                            self.isOpen = true
                        }
                    }
                }
            )
        }
    }
}

//#Preview {
//    ProfileSheetView()
//}
