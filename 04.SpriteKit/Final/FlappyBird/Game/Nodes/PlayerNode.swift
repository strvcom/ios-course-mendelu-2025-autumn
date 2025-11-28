//
//  BirdNode.swift
//  FlappyBird
//
//  Created by Róbert Oravec on 12.11.2023.
//

import SpriteKit

final class PlayerNode: SKSpriteNode {
    // MARK: Properties
    private let wingFlapSound: SKAction
    
    var isDynamic: Bool {
        get { physicsBody?.isDynamic ?? false }
        set { physicsBody?.isDynamic = newValue }
    }
    
    // MARK: Init
    init() {
        let textureAtlas = SKTextureAtlas(named: Assets.Textures.player)
        
        let textures = textureAtlas
            .textureNames
            .sorted()
            .map { textureAtlas.textureNamed($0) }
        
        wingFlapSound = SKAction.playSoundFileNamed(
            Assets.Sounds.wing,
            waitForCompletion: false
        )
        
        super.init(
            texture: textures.first,
            color: .clear,
            size: textures.first?.size() ?? .zero
        )
        
        zPosition = Layer.bird
        name = NodeName.player
        
        physicsBody = SKPhysicsBody(
            texture: texture ?? SKTexture(),
            size: texture?.size() ?? .zero
        )
        physicsBody?.categoryBitMask = Physics.CategoryBitMask.player
        physicsBody?.collisionBitMask = Physics.CollisionBitMask.player
        physicsBody?.contactTestBitMask = Physics.ContactTestBitMask.player
        physicsBody?.friction = 0
        
        run(
            SKAction.repeatForever(
                SKAction.animate(
                    with: textures,
                    timePerFrame: 0.3,
                    resize: false,
                    restore: true
                )
            )
        )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public API
extension PlayerNode {
    func updateRotation() {
        guard let velocity = physicsBody?.velocity.dy else {
            return
        }
        
        zRotation = velocity * 0.001
    }
    
    func flapWings() {
        physicsBody?.applyImpulse(
            CGVector(
                dx: 0,
                dy: size.height * 0.5
            )
        )
        
        run(wingFlapSound)
    }
}
