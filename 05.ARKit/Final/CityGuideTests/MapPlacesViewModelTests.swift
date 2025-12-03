//
//  MapPlacesViewModelTests.swift
//  CityGuideTests
//
//  Created by Dominika Gajdová on 22.10.2025.
//

import CoreData
import XCTest
@testable import CityGuide

final class MapPlacesViewModelTests: UnitTests {            
    
    func testDatabaseIsEmpty() {
        let sut = createSUT()
        sut.fetchMapPlaces()

        XCTAssertTrue(sut.state.mapPlaces.isEmpty)
        XCTAssertNil(sut.state.selectedPlace)
    }
    
    func testDatabaseIsPopulated() {
        let sut = createSUT()
        sut.fetchSampleData()
        
        XCTAssertFalse(sut.state.mapPlaces.isEmpty)
    }
    
    func testLocationIsSynchronized() {
        let sut = createSUT()
        sut.syncLocation()
        
        XCTAssertNotNil(sut.state.currentLocation)
    }
    
    func testMapItemIsSuccessfulyRemoved() throws {
        let sut = createSUT()
        sut.fetchSampleData()
        
        let firstItem = try XCTUnwrap(
            sut.state.mapPlaces.first,
            "Expected first map place to not be nil"
        )
        
        sut.removePlace(place: firstItem)
        sut.fetchMapPlaces()
        
        let newFirstItem = sut.state.mapPlaces.first
        
        XCTAssertNotEqual(newFirstItem?.id, firstItem.id)
    }
}

// MARK: SUT
private extension MapPlacesViewModelTests {
    func createSUT() -> MapPlacesViewModel {
        MapPlacesViewModel(
            dataManager: CoreDataManager(container: persistantContainer),
            locationManager: LocationManagerMock()
        )
    }
}
