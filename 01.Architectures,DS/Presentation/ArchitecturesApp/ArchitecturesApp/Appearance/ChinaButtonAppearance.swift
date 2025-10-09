//
//  ChinaButtonAppearance.swift
//  ArchitecturesApp
//
//  Created by Martin Vidovic on 05.10.2025.
//

import SwiftUI

protocol ChinaButtonAppearance: ButtonAppearance {}
extension ChinaButtonAppearance {
    func height(for style: ButtonStyle) -> CGFloat {
        switch style {
        case .primary:
            60
        case .secondary:
            50
        case .tertiary:
            40
        }
    }
    func width(for style: ButtonStyle) -> CGFloat {
        .infinity // (for full width)
    }
    func backgroundColor(for style: ButtonStyle) -> Color {
        Colors.Contrast.gray800
    }
    func font(for style: ButtonStyle) -> Font {
        Fonts.body.font
    }
}
