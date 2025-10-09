//
//  PhoneConnector.swift
//  CityGuideWatch Watch App
//
//  Created by David Procházka on 02.10.2025.
//

import Foundation
import WatchConnectivity
import UIKit

class PhoneConnector: NSObject, WCSessionDelegate, PhoneConnecting {
        
    private var session: WCSession
    private var dataManager: DataManaging
    
    init(session: WCSession = .default, dataManager: DataManaging) {
        self.session = session
        self.dataManager = dataManager
        super.init()
        self.session.delegate = self
        self.session.activate()
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: (any Error)?) {
        
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        let image: UIImage
        if let imageData = message["image"] as? Data {
            image = UIImage(data: imageData) ?? UIImage()
        } else {
            image = UIImage(named: "empty") ?? UIImage()
        }
        
        let mapPlace = MapPlace(
            id: message["id"] as? UUID ?? UUID(),
            name: message["name"] as? String ?? "No name",
            style: ArchitecturalStyle(rawValue: message["style"] as? Int16 ?? 0) ?? .Baroque,
            type: LocationType(rawValue: message["type"] as? Int16 ?? 0) ?? .Historical,
            image: image,
            coordinates: .init(
                latitude: message["lat"] as? Double ?? 0.0,
                longitude: message["lon"] as? Double ?? 0.0
            )
        )
        
        addNewPlace(place: mapPlace)
        
        DispatchQueue.main.async {
            //self.viewModel.fetchMapPlaces()
        }
    }
    
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
}
