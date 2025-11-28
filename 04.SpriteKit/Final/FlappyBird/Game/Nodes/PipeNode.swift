//
//  PipeNode.swift
//  FlappyBird
//
//  Created by Róbert Oravec on 12.11.2023.
//

import SpriteKit

final class PipeNode: SKNode {
    // MARK: Properties
    private let spaceBetweenPipes: CGFloat
    
    let width: CGFloat
    
    // MARK: Init
    init(spaceBetweenPipes: CGFloat) {
        self.spaceBetweenPipes = spaceBetweenPipes
        
        let pipeTexture = SKTexture(imageNamed: Assets.Textures.pipe)
        
        let pipeTextureSize = pipeTexture.size()
        
        self.width = pipeTextureSize.width
        
        super.init()
        
        zPosition = Layer.pipe
        
        createUpPipe(texture: pipeTexture)
        
        createDownPipe(texture: pipeTexture)
        
        createSpaceBetweenPipes()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public API
extension PipeNode {
    func removeSpaceBetweenPipes() {
        guard let spaceNode = children.first(where: { $0.name == NodeName.spaceBetweenPipes }) else {
            return
        }
        
        spaceNode.removeFromParent()
    }
}

// MARK: Private API
private extension PipeNode {
    func createPipe(texture: SKTexture) -> SKSpriteNode {
        let pipe = SKSpriteNode(texture: texture)
        pipe.name = NodeName.pipe
        pipe.physicsBody = SKPhysicsBody(
            texture: texture,
            size: pipe.size
        )
        pipe.physicsBody?.categoryBitMask = Physics.CategoryBitMask.pipe
        pipe.physicsBody?.collisionBitMask = Physics.CollisionBitMask.pipe
        pipe.physicsBody?.contactTestBitMask = Physics.ContactTestBitMask.pipe
        pipe.physicsBody?.isDynamic = false
        return pipe
    }
    
    func createUpPipe(texture: SKTexture) {
        let pipe = createPipe(texture: texture)
        pipe.zRotation = .pi
        pipe.position = CGPoint(
            x: 0,
            y: pipe.size.height * 0.5 + spaceBetweenPipes * 0.5
        )
        
        addChild(pipe)
    }
    
    func createDownPipe(texture: SKTexture) {
        let pipe = createPipe(texture: texture)
        pipe.position = CGPoint(
            x: 0,
            y: -pipe.size.height * 0.5 - spaceBetweenPipes * 0.5
        )
        
        addChild(pipe)
    }
    
    func createSpaceBetweenPipes() {
        let spaceNode = SKNode()
        spaceNode.name = NodeName.spaceBetweenPipes
        spaceNode.physicsBody = SKPhysicsBody(
            rectangleOf: CGSize(
                width: 1,
                height: spaceBetweenPipes
            )
        )
        spaceNode.physicsBody?.categoryBitMask = Physics.CategoryBitMask.hole
        // Setting collisionbitmask to 0 means no collision with this physics body will happen.
        spaceNode.physicsBody?.collisionBitMask = 0
        spaceNode.physicsBody?.contactTestBitMask = Physics.ContactTestBitMask.hole
        spaceNode.physicsBody?.isDynamic = false
        
        addChild(spaceNode)
    }
}
