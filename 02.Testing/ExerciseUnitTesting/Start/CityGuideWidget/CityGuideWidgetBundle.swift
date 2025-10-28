//
//  CityGuideWidgetBundle.swift
//  CityGuideWidget
//
//  Created by David Prochazka on 25.04.2025.
//

import WidgetKit
import SwiftUI

@main
struct CityGuideWidgetBundle: WidgetBundle {
    var body: some Widget {
        CityGuideWidget()
        CityGuideWidgetControl()
    }
}
