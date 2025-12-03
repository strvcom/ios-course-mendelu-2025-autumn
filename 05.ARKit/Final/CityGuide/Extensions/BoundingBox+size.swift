//
//  BoundingBox+size.swift
//  CityGuide
//
//  Created by Arthur Nacar on 03.12.2025.
//

import RealityKit

extension BoundingBox {
    var size: SIMD3<Float> {
        let width = max.x - min.x
        let height = max.y - min.y
        let depth = max.z - min.z
        return [width, height, depth]
    }
}

