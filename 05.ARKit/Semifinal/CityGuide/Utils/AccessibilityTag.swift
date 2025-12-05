//
//  AccessibilityTag.swift
//  CityGuide
//
//  Created by Dominika Gajdová on 27.10.2025.
//

import Foundation
import SwiftUI

enum AccessibilityTag: String {
    // Navigation
    case navMapTabButton
    
    // MapView
    case mapViewMap
    case mapViewAnnotationTitle
    case mapViewAnnotationContent
    
    // ListView
    case listViewAddNewPlaceButton
    
    // NewMapPlaceView
    case newMapPlacePlaceNameTextField
    case newMapPlaceCloseButton
    case newMapPlaceSaveButton
    
    // DetailView
    case detailViewTitle
    case rowElementTitle
}

extension View {
    func accessibilityIdentifier(_ tag: AccessibilityTag) -> some View {
        self.accessibilityIdentifier(tag.rawValue)
    }
}

extension TabContent {
    func accessibilityIdentifier(_ tag: AccessibilityTag) -> some TabContent<Self.TabValue> {
        self.accessibilityIdentifier(tag.rawValue)
    }
}
