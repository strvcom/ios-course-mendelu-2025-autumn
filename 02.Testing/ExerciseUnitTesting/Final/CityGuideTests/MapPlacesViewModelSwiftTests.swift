//
//  MapPlacesViewModelSwiftTests.swift
//  CityGuideTests
//
//  Created by Dominika Gajdová on 22.10.2025.
//

import CoreData
import Testing
@testable import CityGuide

@Suite(.serialized) final class MapPlacesViewModelSwiftTests {
    private var persistantContainer: NSPersistentContainer!
    
    init() throws {
        persistantContainer = NSPersistentContainer(name: "CityGuide")
        let description = NSPersistentStoreDescription()
        // In memory setup
        description.url = URL(fileURLWithPath: "/dev/null")
        persistantContainer?.persistentStoreDescriptions = [description]
    }
    
    deinit {
        persistantContainer = nil
    }
    
    @Test
    func databaseIsEmpty() {
        let sut = createSUT()
        sut.fetchMapPlaces()
        
        #expect(sut.state.mapPlaces.isEmpty)
        #expect(sut.state.selectedPlace == nil)
    }
    
    @Test
    func databaseIsPopulated() {
        let sut = createSUT()
        sut.fetchSampleData()
        
        #expect(!sut.state.mapPlaces.isEmpty)
    }
    
    @Test
    func locationIsSynchronized() {
        let sut = createSUT()
        sut.syncLocation()
        
        #expect(sut.state.currentLocation != nil)
    }
    
    @Test
    func mapItemIsSuccessfullyRemoved() throws {
        let sut = createSUT()
        sut.fetchSampleData()
        
        let firstItem = try #require(
            sut.state.mapPlaces.first,
            "Expected first map place to not be nil"
        )
        
        sut.removePlace(place: firstItem)
        sut.fetchMapPlaces()
        
        let newFirstItem = sut.state.mapPlaces.first
        
        #expect(newFirstItem?.id != firstItem.id)
    }
    
    @Test("Map items insertion", arguments: [MapPlace.sample1, MapPlace.sample2])
    func mapItemsAreSuccessfullyAdded(_ mapPlace: MapPlace) throws {
        let sut = createSUT()
        sut.addNewPlace(place: mapPlace)
        sut.fetchMapPlaces()
        
        let firstItem = try #require(
            sut.state.mapPlaces.first,
            "Expected first map place to not be nil"
        )
        
        let newFirstItem = sut.state.mapPlaces.first
        
        #expect(newFirstItem?.id == firstItem.id)
    }
}

// MARK: - SUT
private extension MapPlacesViewModelSwiftTests {
    func createSUT() -> MapPlacesViewModel {
        MapPlacesViewModel(
            dataManager: CoreDataManager(container: persistantContainer),
            locationManager: LocationManagerMock()
        )
    }
}

