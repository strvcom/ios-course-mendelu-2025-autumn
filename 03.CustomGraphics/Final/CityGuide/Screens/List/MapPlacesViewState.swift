//
//  MapPlacesViewState.swift
//  CityGuide
//
//  Created by David Procházka on 19.03.2025.
//

import Observation
import MapKit
import SwiftUI

@Observable
final class MapPlacesViewState {
    var mapPlaces: [MapPlace] = []
    
    var selectedPlace: MapPlace?
    
    var currentLocation: CLLocationCoordinate2D?
    
    var mapCameraPosition: MapCameraPosition = .camera(
        .init(
            centerCoordinate: .init(
                latitude: 49.21044343932761,
                longitude: 16.6157301199077
            ),
            distance: 3000
        )
    )
}
