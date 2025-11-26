//
//  TopNode.swift
//  FlappyBird
//
//  Created by Róbert Oravec on 13.11.25.
//

import SpriteKit

final class TopNode: SKNode {
    init(width: CGFloat) {
        super.init()
        
        physicsBody = SKPhysicsBody(
            rectangleOf: CGSize(
                width: width,
                height: 1
            )
        )
        physicsBody?.categoryBitMask = Physics.CategoryBitMask.environment
        physicsBody?.collisionBitMask = Physics.CollisionBitMask.environment
        physicsBody?.isDynamic = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
