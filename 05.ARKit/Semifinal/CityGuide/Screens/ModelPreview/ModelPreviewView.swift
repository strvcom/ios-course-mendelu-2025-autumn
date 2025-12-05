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
    let rootAnchor = AnchorEntity()

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

        let horizontalPlane = AnchorEntity(.plane(.horizontal, classification: .any, minimumBounds: [0.1, 0.1]))
        // Set the position of the anchor entity to 1 meter in front of the camera
        horizontalPlane.position = [0, 0, -0.5]

        if let house = makeHouse() {
            horizontalPlane.addChild(house)
        }

        rootAnchor.addChild(horizontalPlane)

        // Add the anchor entity to the scene
        arView.scene.addAnchor(rootAnchor)
    }

    func makeHouse() -> ModelEntity? {
        let house = ModelEntity()

        guard
            let base = makeBase(),
            let roof = makeRoof()
        else {
            return nil
        }

        roof.position = [0, base.visualBounds(relativeTo: nil).size.y / 2, 0]
        house.addChild(base)
        house.addChild(roof)

        // Add pin
        if let pin = makePin() {
            pin.position = [0, 0.3, 0]
            house.addChild(pin)
        }
        return house
    }

    func makeBase() -> ModelEntity? {
        var material = UnlitMaterial()
        guard let texture = try? TextureResource.load(named: "stone-texture") else {
            return nil
        }

        material.color = PhysicallyBasedMaterial.BaseColor(texture: .init(texture))
        let mesh = MeshResource.generateBox(size: [0.2, 0.15, 0.3])
        let base = ModelEntity(mesh: mesh, materials: [material])

        return base
    }

    func makeRoof() -> ModelEntity? {
        try? ModelEntity.loadModel(named: "roof")
    }

    func makePin() -> ModelEntity? {
        // Create pin head
        let headMaterial = SimpleMaterial(color: .red, isMetallic: true)
        let pinHead = ModelEntity(
            mesh: .generateSphere(radius: 0.02),
            materials: [headMaterial]
        )

        // Create pin body
        let pin = ModelEntity(
            mesh: .generateCylinder(height: 0.1, radius: 0.005)
            materials: [SimpleMaterial(
                color: .gray,
                isMetallic: true
            )]
        )

        // Offset the head from the body center
        pinHead.position = [0, 0.05, 0]
        pin.addChild(pinHead)
        return pin
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
