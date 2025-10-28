//
//  WeatherData.swift
//  CityGuide
//
//  Created by Tomas Cejka on 23.04.2025.
//

import Foundation

struct WeatherData: Codable {
    let daily: Daily
}

struct Daily: Codable {
    let time: [String]
    let maxTemperatures: [Double]

    enum CodingKeys: String, CodingKey {
        case time
        case maxTemperatures = "temperature_2m_max"
    }
}
