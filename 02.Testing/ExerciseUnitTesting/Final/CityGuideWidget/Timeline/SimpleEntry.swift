//
//  SimpleEntry.swift
//  CityGuide
//
//  Created by David Prochazka on 25.04.2025.
//

import SwiftUI
import WidgetKit
import CoreLocation

struct SimpleEntry: TimelineEntry {
    let date: Date
    let coordinates: CLLocationCoordinate2D
    let configuration: ConfigurationAppIntent
}
