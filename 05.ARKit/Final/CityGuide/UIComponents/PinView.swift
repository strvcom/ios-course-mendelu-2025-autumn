//
//  PinView.swift
//  CityGuide
//
//  Created by Matej Molnár on 06.11.2025.
//

import SwiftUI

struct PinView<Content: View>: View {
    var content: () -> Content

    var body: some View {
        PinShape()
            .fill(
                LinearGradient(
                    colors: [Color.clear, Color.blue],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .aspectRatio(0.6, contentMode: .fit)
            .overlay {
                GeometryReader { geometry in
                    content()
                        .position(
                            x: geometry.size.width / 2,
                            y: geometry.size.width / 2
                         )
                }
            }
            .shadow(radius: 5)
    }
}

#Preview {
    PinView { Text("🍐")}
        .frame(width: 50)
}
