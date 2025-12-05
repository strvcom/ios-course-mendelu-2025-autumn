//
//  APIManagerMock.swift
//  CityGuideTests
//
//  Created by Dominika Gajdová on 22.10.2025.
//

import Foundation
@testable import CityGuide

final class ApiManagerMock: APIManaging {
    let toReturn: Result<Decodable, Error>

    init(toReturn: Result<Decodable, Error>) {
        self.toReturn = toReturn
    }

    func request<T>(_ endpoint: any Endpoint) async throws -> T where T : Decodable {
        switch toReturn {
        case .success(let decodable):
            // Try casting the Decodable result to the expected type
            guard let result = decodable as? T else {
                throw NSError(domain: "ApiManagerMockError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to cast to expected type \(T.self)"])
            }
            return result
        case .failure(let error):
            throw error
        }
    }
}
