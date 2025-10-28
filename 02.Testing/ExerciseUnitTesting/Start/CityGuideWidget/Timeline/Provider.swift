//
//  Provider.swift
//  CityGuide
//
//  Created by David Prochazka on 25.04.2025.
//
import SwiftUI
import WidgetKit

struct Provider: AppIntentTimelineProvider {
    let locationManager = LocationManager()
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), coordinates: .init(latitude: 47.8, longitude: 17.7), configuration: ConfigurationAppIntent())
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        if let coords = locationManager.currentLocation {
            SimpleEntry(date: Date(), coordinates: coords,  configuration: configuration)
        } else {
            SimpleEntry(date: Date(), coordinates: .init(latitude: 47.8, longitude: 17.7),  configuration: configuration)
        }
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []
        var entry: SimpleEntry
        if let coords = locationManager.currentLocation {
            entry = SimpleEntry(date: Date(), coordinates: coords,  configuration: configuration)
        } else {
            entry = SimpleEntry(date: Date(), coordinates: .init(latitude: 47.8, longitude: 17.7),  configuration: configuration)
        }
        entries.append(entry)
        
        return Timeline(entries: entries, policy: .never)
    }

//    func relevances() async -> WidgetRelevances<ConfigurationAppIntent> {
//        // Generate a list containing the contexts this widget is relevant in.
//    }
}
