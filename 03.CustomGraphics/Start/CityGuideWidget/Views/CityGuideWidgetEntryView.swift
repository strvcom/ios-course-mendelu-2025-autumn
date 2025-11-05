//
//  CityGuideWidgetView.swift
//  CityGuide
//
//  Created by David Prochazka on 25.04.2025.
//

import SwiftUI
import WidgetKit

struct CityGuideWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text("Time:")
            Text(entry.date, style: .time)

            Text("Latitude:")
            Text(entry.coordinates.latitude.description)
            
            Text("Longitude:")
            Text(entry.coordinates.longitude.description)
        }
    }
}
