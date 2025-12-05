//
//  PinShape.swift
//  CityGuide
//
//  Created by Matej Molnár on 06.11.2025.
//

import SwiftUI

struct PinShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        // Dimensions
        let circleRadius = min(rect.width, rect.height) / 2
        let circleCenter = CGPoint(x: rect.midX, y: rect.minY + circleRadius)
        let pointerBottom = CGPoint(x: rect.midX, y: rect.maxY)

        // Draw head of the pin (semi-circle
        path.addArc(
            center: circleCenter,
            radius: circleRadius,
            startAngle: .degrees(30),
            endAngle: .degrees(150),
            clockwise: true
        )

        // Draw Triangle (Pointer)
        path.addLine(to: pointerBottom)
        path.closeSubpath()

        return path
    }
}

#Preview {
    PinShape()
        .fill(Color.red)
}
