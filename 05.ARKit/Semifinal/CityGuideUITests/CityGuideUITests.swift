//
//  CityGuideUITests.swift
//  CityGuideUITests
//
//  Created by Dominika Gajdová on 27.10.2025.
//

@testable import CityGuide
import XCTest

final class CityGuideUITests: XCTestCase {
    override func setUpWithError() throws {
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
    }
    
    func testMapViewIsLoaded() {
        let app = XCUIApplication()
        app.launch()
        
        let mapTabButton = app.buttons[.navMapTabButton]
        mapTabButton.tap()
        
        XCTAssertTrue(app.otherElements[.mapViewMap].exists)
    }
    
    func testNewPlaceViewIsOpened() {
        let app = XCUIApplication()
        app.launch()
        app.buttons[.listViewAddNewPlaceButton].tap()

        let textField = app.textFields[.newMapPlacePlaceNameTextField]
        textField.tap()
        textField.typeText("Kentucky")

        let closeButton = app.buttons[.newMapPlaceCloseButton]
        closeButton.tap()
    }
    
    func testSaveButtonDisabledIfNoTitle() {
        let app = XCUIApplication()
        app.launch()
        app.buttons[.listViewAddNewPlaceButton].tap()

        let saveButton = app.buttons[.newMapPlaceSaveButton]
        XCTAssertTrue(!saveButton.isEnabled)

        let textField = app.textFields[.newMapPlacePlaceNameTextField]
        textField.tap()
        textField.typeText("Kentucky")

        XCTAssertTrue(saveButton.isEnabled)
    }
    
    func test_detailMatchesMapMarkerData() {
        let app = XCUIApplication()
        app.launch()
        app.buttons[.navMapTabButton].tap()

        let annotationContent = app.otherElements[.mapViewAnnotationContent]
        XCTAssertTrue(annotationContent.waitForExistence(timeout: 3))

        let titleText = annotationContent.staticTexts[.mapViewAnnotationTitle]
        XCTAssertTrue(titleText.exists)

        annotationContent.tap()

        let detailTitleText = app.otherElements[.detailViewTitle].staticTexts[.rowElementTitle]
        let text = titleText.label
        let detailText = detailTitleText.label
        XCTAssertEqual(text, detailText)
    }
}

extension XCUIElementQuery {
    subscript(_ tag: AccessibilityTag) -> XCUIElement {
        self[tag.rawValue]
    }
}
