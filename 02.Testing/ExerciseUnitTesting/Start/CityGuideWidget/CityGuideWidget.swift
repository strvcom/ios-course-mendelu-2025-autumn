//
//  CityGuideWidget.swift
//  CityGuideWidget
//
//  Created by David Prochazka on 25.04.2025.
//

import WidgetKit
import SwiftUI

struct CityGuideWidget: Widget {
    let kind: String = "CityGuideWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            CityGuideWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
    }
}

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        intent.latitude = "49.135"
        intent.longitude = "16.543"
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        intent.latitude = "49.137"
        intent.longitude = "16.543"
        return intent
    }
}

#Preview(as: .systemMedium) {
    CityGuideWidget()
} timeline: {
    SimpleEntry(date: .now, coordinates: .init(latitude: 45.8, longitude: 17.7), configuration: .smiley)
    SimpleEntry(date: .now, coordinates: .init(latitude: 45.8, longitude: 17.7), configuration: .starEyes)
}
