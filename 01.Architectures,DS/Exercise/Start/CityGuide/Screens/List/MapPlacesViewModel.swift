//
//  MapPlacesViewModel.swift
//  CityGuide
//
//  Created by David Procházka on 19.03.2025.
//

import SwiftUI
import CoreLocation

@Observable
class MapPlacesViewModel: ObservableObject {
    var state: MapPlacesViewState = MapPlacesViewState()
    
    private var dataManager: DataManaging
    private var locationManager: LocationManaging
    private var periodicUpdatesRunning = false      // for periodic updates of location

    init() {
        dataManager = DIContainer.shared.resolve()
        locationManager = DIContainer.shared.resolve()
    }
}

extension MapPlacesViewModel {
    func addNewPlace(place: MapPlace) {
        let poi = PointOfInterest(context: dataManager.context)
        
        poi.id = place.id // id of the PoI and MapPlace must be the same!
        poi.name = place.name
        poi.style = place.style.rawValue
        poi.type = place.type.rawValue
        poi.image = place.image.jpegData(compressionQuality: 90)
        poi.latitude = place.coordinates.latitude
        poi.longitude = place.coordinates.longitude
        
        dataManager.savePlace(place: poi)
    }
    
    func fetchMapPlaces() {
        let pois: [PointOfInterest] = dataManager.fetchPlaces()
        
        state.mapPlaces = pois.map {
            let image: UIImage
            
            if let storedImageData = $0.image {
                image = UIImage(data: storedImageData) ?? UIImage()
            } else {
                image = UIImage()
            }
            
            return MapPlace(
                id: $0.id ?? UUID(),
                name: $0.name ?? "No name",
                style: ArchitecturalStyle(rawValue: $0.style) ?? .Baroque,
                type: LocationType(rawValue: $0.type) ?? .Historical,
                image: image,
                coordinates: .init(latitude: $0.latitude, longitude: $0.longitude ))
        }
    }
    
    func fetchSampleData() {
        dataManager.addSampleData()
        fetchMapPlaces()
    }
    
    func removePlace(place: MapPlace) {
        if let poi = dataManager.fetchPlaceWithId(id: place.id) {
            dataManager.removePlace(place: poi)
            fetchMapPlaces()
        } else {
            print("Cannot fetch PointOfInterest with given id")
        }
    }
    
    func syncLocation() {
        state.mapCameraPosition = locationManager.cameraPosition
        state.currentLocation = locationManager.currentLocation
    }

    func startPeriodicLocationUpdate() async {
        if !periodicUpdatesRunning {
            periodicUpdatesRunning.toggle()
            
            while true {
                try? await Task.sleep(nanoseconds: 4_000_000_000)
                syncLocation()
            }
        }
    }
}
