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

    init(
        place: MapPlace,
        dataManager: DataManaging,
        apiManager: APIManaging
    ) {
        state = DetailViewState(mapPlace: place)
        self.dataManager = dataManager
        self.apiManager = apiManager
    }

    @MainActor
    func fetchWeatherData() {
        Task {
            do {
                state.isLoading = true
                
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
                state.isLoading = false
            } catch {
                print(error)
                state.isLoading = false
            }
        }
    }
}
