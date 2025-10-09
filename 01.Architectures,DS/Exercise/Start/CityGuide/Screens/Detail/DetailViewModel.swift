//
//  DetailViewModel.swift
//  CityGuide
//
//  Created by David Procházka on 26.03.2025.
//

import SwiftUI
import CoreLocation

@Observable
class DetailViewModel: ObservableObject {
    var state: DetailViewState
    private var dataManager: DataManaging
    private let apiManager: APIManaging

    init(place: MapPlace) {
        dataManager = DIContainer.shared.resolve()
        apiManager = DIContainer.shared.resolve()
        state = DetailViewState(mapPlace: place)
    }

    @MainActor
    func fetchWeatherData() {
        Task {
            do {

                let weatherData: WeatherData = try await apiManager.request(
                    WeatherDataRouter.dailyMaxTemperature(
                        long: state.mapPlace.coordinates.longitude,
                        lat: state.mapPlace.coordinates.latitude
                    )
                )

                guard let temperature = weatherData.daily.maxTemperatures.first else {
                    return
                }

                let measurement = Measurement(value: temperature, unit: UnitTemperature.celsius)
                let measurementFormatter = MeasurementFormatter()

                state.temperature = measurementFormatter.string(from: measurement)

            } catch {
                print(error)
            }
        }
    }
}
