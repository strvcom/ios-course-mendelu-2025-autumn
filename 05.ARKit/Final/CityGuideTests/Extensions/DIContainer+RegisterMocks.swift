//
//  DIContainer+RegisterMocks.swift
//  CityGuideTests
//
//  Created by Dominika Gajdová on 28.10.2025.
//

import CoreData
@testable import CityGuide

extension DIContainer {
    func registerMocks(persistantContainer: NSPersistentContainer) {
        register(APIManaging.self, cached: true) {
            let weatherData = WeatherData(daily: .init(time: [], maxTemperatures: [22.0]))
            return ApiManagerMock(toReturn: .success(weatherData))
        }
        
        register(DataManaging.self, cached: true) {
            CoreDataManager(container: persistantContainer)
        }
        
        register(LocationManaging.self, cached: true) {
            LocationManagerMock()
        }
        
        #if os(iOS)
        register(WatchConnecting.self, cached: false) {
            WatchConnectorMock()
        }
        #endif
    }
}
