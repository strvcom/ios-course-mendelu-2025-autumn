//
//  WatchConnector.swift
//  CityGuide
//
//  Created by David Procházka on 02.10.2025.
//

import Foundation
import WatchConnectivity
import UIKit

class WatchConnector: NSObject, WCSessionDelegate, WatchConnecting {
    
    private var session: WCSession
    
    init(session: WCSession = .default) {
        self.session = session
        super.init()
        self.session.delegate = self
        self.session.activate()
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: (any Error)?) {
        
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        session.activate()
    }
    
    func sendMapPlace(mapPlace: MapPlace) {
        if session.isReachable {
            var message: [String: Any] = [
                "id": mapPlace.id.uuidString,
                "name": mapPlace.name,
                "latitude": mapPlace.coordinates.latitude,
                "longitude": mapPlace.coordinates.longitude,
                "type": mapPlace.type.rawValue,
                "style": mapPlace.style.rawValue
            ]
            
            let resizedImage = mapPlace.image.resized(to: CGSize(width: 160, height: 160))
            if let resizedImageData = resizedImage.jpegData(compressionQuality: 0.3) {
                message["image"] = resizedImageData
            }
            
            session.sendMessage(message, replyHandler: nil) { error in
                print("Sending error: \(error.localizedDescription)")
            }
        } else {
            print("Session is not reachable")
        }
    }
}

extension UIImage {
    /// Resizes the image to the given size, preserving orientation and scale.
    /// - Parameter newSize: Target size in points.
    /// - Returns: A new resized `UIImage`.
    func resized(to newSize: CGSize) -> UIImage {
        let format = UIGraphicsImageRendererFormat.default()
        format.scale = self.scale
        format.opaque = false

        let renderer = UIGraphicsImageRenderer(size: newSize, format: format)
        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: newSize))
        }
    }
}
