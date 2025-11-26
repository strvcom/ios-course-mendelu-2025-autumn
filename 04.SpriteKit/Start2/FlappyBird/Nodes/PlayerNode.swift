//
//  PlayerNode.swift
//  FlappyBird
//
//  Created by Róbert Oravec on 13.11.25.
//

import SpriteKit

final class PlayerNode: SKSpriteNode {
    init() {
        let textureAtlas = SKTextureAtlas(named: Assets.Textures.bird)
        
        let textures = textureAtlas
            .textureNames
            .sorted()
            .map { textureAtlas.textureNamed($0) }
        
        super.init(
            texture: textures.first,
            color: .clear,
            size: textures.first?.size() ?? .zero
        )
        
        zPosition = Layer.player
        
        let animateAction = SKAction.animate(
            with: textures,
            timePerFrame: 0.13,
            resize: false,
            restore: true
        )
        
        let animateForeverAction = SKAction.repeatForever(animateAction)
        
        run(animateForeverAction)
        
        physicsBody = SKPhysicsBody(
            texture: texture ?? SKTexture(),
            size: texture?.size() ?? .zero
        )
        physicsBody?.categoryBitMask = Physics.CategoryBitMask.player
        physicsBody?.collisionBitMask = Physics.CollisionBitMask.player
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func flapWings() {
        physicsBody?.applyImpulse(
            CGVector(
                dx: 0,
                dy: size.height * 0.7
            )
        )
    }
    
    func updateRotation() {
        guard let velocity = physicsBody?.velocity.dy else {
            return
        }
        
        zRotation = velocity * 0.001
    }
}
