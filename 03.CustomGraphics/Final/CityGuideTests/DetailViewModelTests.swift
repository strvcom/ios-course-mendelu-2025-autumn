//
//  DetailViewModelTests.swift
//  CityGuideTests
//
//  Created by Dominika Gajdová on 22.10.2025.
//

import CoreData
import XCTest
@testable import CityGuide

final class DetailViewModelTests: UnitTests {
    func testLoadingThrowsErrorDataIsEmpty() async {
        let sut = createSUT(toReturn: .failure(APIError.noResponse))
        await sut.fetchWeatherData()
        // No new data -> no new temperature
        XCTAssertEqual(sut.state.temperature, "")
    }

    func testTemperatureLoadedSuccessfully() async {
        let weatherData = WeatherData(daily: .init(time: [], maxTemperatures: [22.0]))
        let sut = createSUT(toReturn: .success(weatherData))
        
        // Setup expectation
        let expectation = XCTestExpectation(description: "Get right value of temperature")

        withObservationTracking(of: sut.state.temperature) { value in
            if !value.isEmpty {
                XCTAssertEqual(value, "22°C")
                expectation.fulfill()
            }
        }
        
        await sut.fetchWeatherData()

        // Wait for expectation fulfillment with timeout
        await fulfillment(of: [expectation], timeout: 100.0)
    }
}

// MARK: SUT
private extension DetailViewModelTests {
    func createSUT(
        toReturn: Result<Decodable, Error>
    ) -> DetailViewModel {
        return DetailViewModel(
            place: .sample1,
            dataManager: CoreDataManager(container: persistantContainer),
            apiManager: ApiManagerMock(toReturn: toReturn)
        )
    }
}

/// Allows observation of property when using @Observable macro
func withObservationTracking<T: Sendable>(
    of value: @Sendable @escaping @autoclosure () -> T,
    execute: @Sendable @escaping (T) -> Void
) {
    Observation.withObservationTracking {
        execute(value())
    } onChange: {
        RunLoop.current.perform {
            withObservationTracking(of: value(), execute: execute)
        }
    }
}
