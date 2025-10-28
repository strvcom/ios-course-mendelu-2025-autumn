//
//  MapPlace.swift
//  CityGuide
//
//  Created by David Procházka on 19.03.2025.
//
import UIKit
import CoreLocation

enum ArchitecturalStyle: Int16, CaseIterable, Identifiable {
    var id: Self { self }
    
    case Baroque = 1
    case Modern = 2
    case Bauhaus = 3
    case Gothic = 4
    
    var name: String {
        let key = String(describing: self)

        // Compiler added all known keys
        // But this is unknown key -> it's string value but we don't know which one
        // Because the compiler can't determine the key at build time, it can't extract it into your .xcstrings catalog. The special localization mechanism fails.
        // That's we have to use old code -> NSLocalizedString
        return NSLocalizedString(
            key,
            comment: "The name of an architectural style"
        )
    }
}

enum LocationType: Int16, CaseIterable, Identifiable {
    var id: Self { self }
    
    case Industrial = 1
    case Historical = 2
    case House = 3
    
    var symbol: String {
        switch self {
        case .Industrial:
            "🏭"
        case .Historical:
            "🏰"
        case .House:
            "🏠"
        }
    }
    
    var name: String {
        let key = String(describing: self)

        // Compiler added all known keys
        // But this is unknown key -> it's string value but we don't know which one
        // Because the compiler can't determine the key at build time, it can't extract it into your .xcstrings catalog. The special localization mechanism fails.
        // That's we have to use old code -> NSLocalizedString
        return NSLocalizedString(
            key,
            comment: "The name of an LocationType"
        )
    }
}

struct MapPlace: Identifiable {
    var id: UUID
    var name: String
    var style: ArchitecturalStyle
    var type: LocationType
    var image: UIImage
    var coordinates: CLLocationCoordinate2D
    
    static let sample1 = MapPlace(
        id: UUID(),
        name: "Mendel University in Brno",
        style: .Baroque,
        type: .Historical,
        image: UIImage(named: "MENDELU") ?? UIImage(),
        coordinates: .init(latitude: 49.21044343932761, longitude: 16.61573011990775)
    )
    
    static let sample2 = MapPlace(
        id: UUID(),
        name: "Vila Tugendhat",
        style: .Bauhaus,
        type: .Historical,
        image: UIImage(named: "Tugendhat") ?? UIImage(),
        coordinates: .init(latitude: 49.20726827756502, longitude: 16.61617000220887)
    )
    
    static let samples = [sample1, sample2]
}
