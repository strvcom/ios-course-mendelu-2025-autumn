//
//  PrimaryButtonStyle.swift
//  CityGuide
//
//  Created by Matej Molnár on 06.11.2025.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) var isEnabled

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .foregroundStyle(Color.white)
            .padding()
            .background(Color.blue)
            .clipShape(Capsule())
            .shadow(color: .black.opacity(0.4), radius: 2)
            .opacity(isEnabled ? 1 : 0.3)
            .opacity(configuration.isPressed ? 0.5 : 1)
    }
}

// Extension to simplify the usage of custom button styles.
// Enables using `.buttonStyle(.primaryButtonStyle)` directly, instead of `.buttonStyle(PrimaryButtonStyle())`.
extension ButtonStyle where Self == PrimaryButtonStyle {
    static var primary: PrimaryButtonStyle { PrimaryButtonStyle() }
}

#Preview {
    VStack {
        Button("Enabled") {

        }
        .buttonStyle(.primary)

        Button("Disabled") {

        }
        .buttonStyle(.primary)
        .disabled(true)
    }
    .padding()
}
