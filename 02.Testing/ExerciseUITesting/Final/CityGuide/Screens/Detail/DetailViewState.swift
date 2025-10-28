//
//  DetailViewState.swift
//  CityGuide
//
//  Created by David Procházka on 26.03.2025.
//

import Observation
import MapKit
import SwiftUI

@Observable
final class DetailViewState {
    var mapPlace: MapPlace
    var temperature: String = ""

    init(mapPlace: MapPlace) {
        self.mapPlace = mapPlace
    }
}
