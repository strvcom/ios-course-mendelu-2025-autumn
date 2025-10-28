//
//  RowElement.swift
//  CityGuide
//
//  Created by David Procházka on 26.03.2025.
//
import SwiftUI

struct RowElement: View {
    var translatedTitle: LocalizedStringResource
    var value: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(String(localized: translatedTitle))
                .font(.caption)
                .foregroundColor(Colors.Contrast.gray500)
            
            Text(value)
                .font(.headline)
                .foregroundColor(Colors.primary)
                .accessibilityIdentifier(.rowElementTitle)
        }
        .accessibilityElement(children: .contain)
    }
}

#Preview {
    RowElement(
        translatedTitle: "Label text",
        value: "Value text"
    )
}
