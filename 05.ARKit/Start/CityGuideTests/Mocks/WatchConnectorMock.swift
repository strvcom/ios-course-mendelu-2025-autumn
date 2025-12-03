//
//  WatchConnectorMock.swift
//  CityGuideTests
//
//  Created by Dominika Gajdová on 28.10.2025.
//

@testable import CityGuide

final class WatchConnectorMock: WatchConnecting {
    func sendMapPlace(mapPlace: CityGuide.MapPlace) { }
}
