//
//  SheetView.swift
//  aloha
//
//  Created by Jason White on 19/05/24.
//


import SwiftUI

struct BottomSideSheetView<Content: View>: View {
    @Binding var isOpen: Bool
    let maxHeight: CGFloat
    let minHeight: CGFloat
    let width: CGFloat
    let content: Content

    @GestureState private var translation: CGFloat = 0

    private var offset: CGFloat {
        isOpen ? 0 : maxHeight - minHeight
    }

    private var indicator: some View {
        RoundedRectangle(cornerRadius: 5.0)
            .fill(.alohaGrey)
            .frame(
                width: 40,
                height: 6
            )
    }

    init(isOpen: Binding<Bool>, maxHeight: CGFloat, minHeight: CGFloat, width: CGFloat, @ViewBuilder content: () -> Content) {
        self._isOpen = isOpen
        self.maxHeight = maxHeight
        self.minHeight = minHeight
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
            .background(Color(.alohaWhite))
            .clipShape(
                .rect(
                    topLeadingRadius: 20,
                    bottomLeadingRadius: 0,
                    bottomTrailingRadius: 0,
                    topTrailingRadius: 20
                )
            )
            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .bottomLeading)
            .offset(y: max(self.offset + self.translation, 0))
            .animation(.interactiveSpring())
            .gesture(
                DragGesture().updating(self.$translation) { value, state, _ in
                    state = value.translation.height
                }.onEnded { value in
                    let snapDistance = self.maxHeight * 0.25
                    guard abs(value.translation.height) > snapDistance else {
                        return
                    }
                    self.isOpen = value.translation.height < 0
                }
            )
        }
    }
}
//#Preview {
//    BottomSideSheetView(isOpen: .constant(true), maxHeight: 100, minHeight: 100, width: 100, content: {Text("Hello World")})
//}
