//
//  WorldButtonAppearance.swift
//  ArchitecturesApp
//
//  Created by Martin Vidovic on 05.10.2025.
//

import SwiftUI

protocol WorldButtonAppearance: ButtonAppearance {}

extension WorldButtonAppearance {
    func height(for style: ButtonStyle) -> CGFloat {
        40
    }
    func width(for style: ButtonStyle) -> CGFloat {
        .infinity // (for full width)
    }
    func backgroundColor(for style: ButtonStyle) -> Color {
        Colors.Contrast.gray100
    }
    func font(for style: ButtonStyle) -> Font {
        Fonts.body.font
    }
}
