//
//  UnitTests.swift
//  CityGuideTests
//
//  Created by Dominika Gajdová on 28.10.2025.
//

import CoreData
import XCTest
@testable import CityGuide

class UnitTests: XCTestCase {
    var persistantContainer: NSPersistentContainer!
    var container: DIContainer!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        persistantContainer = NSPersistentContainer(name: "CityGuide")
        let description = NSPersistentStoreDescription()
        // In memory setup
        description.url = URL(fileURLWithPath: "/dev/null")
        persistantContainer.persistentStoreDescriptions = [description]
        
        container = DIContainer()
        container.registerMocks(persistantContainer: persistantContainer)
    }
    
    override func tearDownWithError() throws {
        persistantContainer = nil
        container = nil
        try super.tearDownWithError()
    }
}
