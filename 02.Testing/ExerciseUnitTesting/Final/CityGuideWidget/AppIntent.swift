//
//  AppIntent.swift
//  CityGuideWidget
//
//  Created by David Prochazka on 25.04.2025.
//

import WidgetKit
import AppIntents

struct ConfigurationAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource { "Configuration" }
    static var description: IntentDescription { "This is an example widget." }

    // An example configurable parameter.
    @Parameter(title: "Favorite Emoji", default: "😃")
    var favoriteEmoji: String
    
    @Parameter(title: "Lattitude", default: "49.2")
    var latitude: String
    
    @Parameter(title: "Longitude", default: "17.7")
    var longitude: String
}
