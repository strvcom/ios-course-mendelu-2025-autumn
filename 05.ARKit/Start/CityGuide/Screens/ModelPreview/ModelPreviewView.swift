//
//  ModelPreviewView.swift
//  CityGuide
//
//  Created by Arthur Nacar on 03.12.2025.
//

import ARKit
import RealityKit
import SwiftUI

@MainActor
struct ModelPreviewView: UIViewRepresentable {
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero, cameraMode: .ar, automaticallyConfigureSession: true)
        context.coordinator.view = arView

        return arView
    }

    func updateUIView(_ arView: ARView, context: Context) {
        // Remove any existing anchor entities from the scene
        arView.scene.anchors.removeAll()
        // View with instructions to scan the area
        arView.addCoaching()
    }

    func makeCoordinator() -> ModelPreviewView.Coordinator {
        Coordinator()
    }

    @MainActor
    class Coordinator: NSObject, ARSessionDelegate {
        weak var view: ARView?
    }
}

extension ARView: ARCoachingOverlayViewDelegate {
    /// Adds a coaching overlay to guide the user in recognising horizontal planes in the AR environment.
    func addCoaching() {
        let coachingOverlay = ARCoachingOverlayView()

        coachingOverlay.goal = .horizontalPlane
        coachingOverlay.session = self.session
        coachingOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        self.addSubview(coachingOverlay)
    }
}
