//
//  MyButton.swift
//  ArchitecturesApp
//
//  Created by Martin Vidovic on 05.10.2025.
//

import SwiftUI

struct MyButton: View {
    let appearance: ButtonAppearance
    let buttonStyle: ButtonStyle
    init(appearance: ButtonAppearance, buttonStyle: ButtonStyle) {
        self.appearance = appearance
        self.buttonStyle = buttonStyle
    }

    var body: some View {
        Button(action: {}) {
            Text("Button")
                .background(
                    appearance.backgroundColor(for: buttonStyle)
                )
                .font(
                    appearance.font(for: buttonStyle)
                )
                .frame(
                    width: appearance.width(for: buttonStyle),
                    height: appearance.height(for: buttonStyle)
                )
        }
    }
}
