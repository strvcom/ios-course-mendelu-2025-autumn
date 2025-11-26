//
//  GameScene.swift
//  FlappyBird
//
//  Created by Róbert Oravec on 13.11.25.
//

import SpriteKit

final class GameScene: SKScene {
    private var playerNode: PlayerNode!
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        isPaused = true
        
        let backgroundNode = BackgroundNode()
        backgroundNode.anchorPoint = .zero
        
        let baseNode = BaseNode()
        baseNode.anchorPoint = .zero
        baseNode.position = CGPoint(
            x: 0,
            y: -baseNode.size.height * 0.3
        )
        
        playerNode = PlayerNode()
        playerNode.position = CGPoint(
            x: size.width * 0.5,
            y: size.height * 0.5
        )
        
        let topNode = TopNode(width: size.width)
        topNode.position = CGPoint(
            x: size.width * 0.5,
            y: size.height
        )
        
        let leftNode = SideNode(height: size.height)
        leftNode.position = CGPoint(
            x: 0,
            y: size.height * 0.5
        )
        
        let rightNode = SideNode(height: size.height)
        rightNode.position = CGPoint(
            x: size.width,
            y: size.height * 0.5
        )
        
        addChild(leftNode)
        addChild(rightNode)
        addChild(topNode)
        addChild(playerNode)
        addChild(backgroundNode)
        addChild(baseNode)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        if isPaused {
            isPaused = false
        } else {
            playerNode.flapWings()
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        
        playerNode.updateRotation()
    }
}
