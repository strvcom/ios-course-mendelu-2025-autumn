//
//  SideNode.swift
//  FlappyBird
//
//  Created by Róbert Oravec on 13.11.25.
//

import SpriteKit

final class SideNode: SKNode {
    init(height: CGFloat) {
        super.init()
        
        name = NodeName.sceneBorder
        
        physicsBody = SKPhysicsBody(
            rectangleOf: CGSize(
                width: 1,
                height: height
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
