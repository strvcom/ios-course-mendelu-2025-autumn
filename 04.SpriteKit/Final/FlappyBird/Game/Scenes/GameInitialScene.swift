//
//  GameInitialScene.swift
//  FlappyBird
//
//  Created by Róbert Oravec on 14.11.2023.
//

import SpriteKit

final class GameInitialScene: SKScene {
    // MARK: Properties
    var onOpenGameScene: () -> Void = {}
    
    // MARK: Overrides
    override func willMove(from view: SKView) {
        super.willMove(from: view)
        
        scaleMode = .aspectFill
    }
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        let getReadyNode = GetReadyNode()
        
        addChild(BackgroundNode())
        addChild(BaseNode())
        addChild(getReadyNode)
        
        getReadyNode.position = center
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        onOpenGameScene()
    }
}
