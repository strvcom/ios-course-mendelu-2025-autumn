//
//  CityGuideSnapshotTests.swift
//  CityGuideTests
//
//  Created by Dominika Gajdová on 27.10.2025.
//

@testable import CityGuide
import CoreData
import SnapshotTesting
import SwiftUI
import XCTest

// https://swiftpackageindex.com/pointfreeco/swift-snapshot-testing/1.18.6/documentation/snapshottesting/integratingwithtestframeworks

final class CityGuideSnapshotTests: UnitTests {
    func testRowViewSnapshot() {
        let view = VStack(alignment: .leading, spacing: 16) {
            RowElement(
                translatedTitle: "Title",
                value: "City"
            )
            .frame(maxWidth: .infinity)
            .background(Color.white)
            
            RowElement(
                translatedTitle: "Title2",
                value: "City2"
            )
            .frame(maxWidth: .infinity)
            .background(Color.white)
        }
            .frame(width: 500, height: 500)
            .background(Color.contrast500)
        
        assertSnapshot(of: view, as: .image)
    }
    
    func testMapViewSnapshot() {
        let view = MapView(
            viewModel: MapPlacesViewModel(
                dataManager: container.resolve(),
                locationManager: container.resolve()
            ),
            connector: container.resolve()
        )

        assertSnapshot(
            of: view,
            as: .image(layout: .device(config: .iPhone13))
        )
    }
    
    func testListViewSnapshot() {
        let view = ListView(
            viewModel: MapPlacesViewModel(
                dataManager: container.resolve(),
                locationManager: container.resolve()
            )
        )
            .environmentObject(container)
        
        assertSnapshot(
            of: view,
            as: .image(
                precision: 0.95,
                layout: .device(config: .iPhone13)
            )
        )
    }
    
    func testDetailViewSnapshot() {
        let view = DetailView(
            viewModel: DetailViewModel(
                place: .sample1,
                dataManager: container.resolve(),
                apiManager: container.resolve()
            )
        )
        
        assertSnapshot(
            of: view,
            as: .image(layout: .device(config: .iPhone13))
        )
    }
}
