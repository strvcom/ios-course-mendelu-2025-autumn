//
//  ButtonAppearance.swift
//  ArchitecturesApp
//
//  Created by Martin Vidovic on 05.10.2025.
//

import SwiftUI

protocol ButtonAppearance {
    func height(for style: ButtonStyle) -> CGFloat
    func width(for style: ButtonStyle) -> CGFloat
    func backgroundColor(for style: ButtonStyle) -> Color
    func font(for style: ButtonStyle) -> Font
}

enum Colors {
    static let primary = Color.black
    static let background = Color.black

    enum Contrast {
        public static let gray100 = Color.black
        public static let gray500 = Color.black
        public static let gray800 = Color.black
    }

    enum Functional {
        public static let error = Color.black
        public static let warning = Color.black
        public static let success = Color.black
        public static let info = Color.black
    }
}
enum Fonts {
    case body

    var font: Font {
        switch self {
        case .body:
            Font.body
        }
    }
}
enum ButtonStyle {
    case primary
    case secondary
    case tertiary
}
