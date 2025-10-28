//
//  LocationManagerMock.swift
//  CityGuideTests
//
//  Created by Dominika Gajdová on 22.10.2025.
//

import CoreLocation
import Foundation
import MapKit
import SwiftUI
@testable import CityGuide

final class LocationManagerMock: LocationManaging {
    var cameraPosition: MapCameraPosition
    
    var currentLocation: CLLocationCoordinate2D?
    
    init() {
        cameraPosition = .automatic
        currentLocation = CLLocationCoordinate2D(
            latitude: 49.21044343932761,
            longitude: 16.6157301199077
        )
    }
    
    func getCurrentDistance(to: CLLocationCoordinate2D) -> Double? {
        100
    }
}
