//
//  GameScene.swift
//  FlappyBird
//
//  Created by Róbert Oravec on 12.11.2023.
//

import SpriteKit
import SwiftUI
import AVFoundation

final class GameScene: SKScene {
    // MARK: Properties
    private var player: PlayerNode!
    private var base: BaseNode!
    private var scoreNode: ScoreNode!
    private var pointSound: SKAction!
    private var hitSound: SKAction!
    private var gameState: GameState = .initial
    private var score = 0
    
    private var pipes: [PipeNode] {
        children.compactMap { $0 as? PipeNode }
    }
    
    var onOpenInitialScene: () -> Void = {}
    
    // MARK: Overrides
    override func willMove(from view: SKView) {
        super.willMove(from: view)
        
        scaleMode = .aspectFill
    }
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        // MARK: Create children
        let topBoundaryNode = TopBoundaryNode(width: size.width)
        
        player = PlayerNode()
        player.isDynamic = false
        
        base = BaseNode()
        
        scoreNode = ScoreNode()
        
        // MARK: Add children into the scene
        addChild(BackgroundNode())
        addChild(base)
        addChild(player)
        addChild(scoreNode)
        addChild(topBoundaryNode)
        
        // MARK: Position children on the scene
        topBoundaryNode.position = CGPoint(
            x: 0,
            y: size.height
        )
        
        player.position = CGPoint(
            x: size.width * 0.3,
            y: center.y + base.size.height
        )
        
        positionScoreNode()
        
        // MARK: Physics setup
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(
            dx: 0,
            dy: -5
        )
        
        // MARK: Sounds setup
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("AVAudioSession setup error \(error)")
        }
        
        pointSound = SKAction.playSoundFileNamed(
            Assets.Sounds.point,
            waitForCompletion: false
        )
        
        hitSound = SKAction.playSoundFileNamed(
            Assets.Sounds.hit,
            waitForCompletion: false
        )
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        
        player.updateRotation()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        switch gameState {
        case .initial:
            startGame()
        case .running:
            player.flapWings()
        case .ended:
            break
        }
    }
}

// MARK: SKPhysicsContactDelegate
extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        guard gameState == .running else {
            return
        }
        
        let noPlayerContactBody = if contact.bodyA.node?.name == NodeName.player {
            contact.bodyB
        } else {
            contact.bodyA
        }
        
        switch noPlayerContactBody.node?.name {
        case NodeName.pipe, NodeName.base:
            endGame()
        case NodeName.spaceBetweenPipes:
            increaseScore(node: noPlayerContactBody.node)
        default:
            break
        }
    }
}

// MARK: Public API
extension GameScene {
    func onSafeAreaChange() {
        positionScoreNode()
    }
}

// MARK: Private API
private extension GameScene {
    func spawnPipe() {
        let spaceBetweenPipes = player.size.height * 4
        
        let lastPipeYPosition = pipes.last?.position.y ?? center.y
        
        let randomOffset = CGFloat.random(in: -150 ... 150)
        
        let topYOffsetTreshold = size.height - spaceBetweenPipes * 0.5
        
        let bottomYOffsetTreshold = base.position.y + base.size.height + spaceBetweenPipes * 0.5
        
        let pipeYPosition: CGFloat = {
            let pipeYPosition = lastPipeYPosition + randomOffset
            // If newly calculated y position is above the screen or bellow
            // the base, then instead of adding value to lastPipeYPosition
            // we substract it to move the pipe to other direction.
            if pipeYPosition > topYOffsetTreshold
                || pipeYPosition < bottomYOffsetTreshold {
                return lastPipeYPosition - randomOffset
            } else {
                return pipeYPosition
            }
        }()
        
        let pipe = PipeNode(spaceBetweenPipes: spaceBetweenPipes)
        pipe.position = CGPoint(
            x: size.width + pipe.width * 0.5,
            y: pipeYPosition
        )
        
        addChild(pipe)
        
        pipe.run(
            .group([
                .sequence([
                    .move(
                        to: CGPoint(
                            x: -pipe.width * 0.5,
                            y: pipeYPosition
                        ),
                        duration: 5
                    ),
                    .removeFromParent()
                ]),
                .sequence([
                    .wait(forDuration: 2.5),
                    .run { [weak self] in
                        self?.spawnPipe()
                    }
                ])
            ])
        )
    }
    
    func startGame() {
        spawnPipe()
        
        player.isDynamic = true
        
        gameState = .running
    }
    
    func endGame() {
        gameState = .ended
        
        pipes.forEach { $0.removeAllActions() }
        
        run(hitSound)
        
        showTryAgainButton()
    }
    
    func increaseScore(node: SKNode?) {
        guard let pipe = node?.parent as? PipeNode else {
            return
        }
        
        score += 1
        
        scoreNode.updateText(score: score)
        
        pipe.removeSpaceBetweenPipes()
        
        run(pointSound)
    }
    
    func positionScoreNode() {
        scoreNode.position = CGPoint(
            x: center.x,
            y: size.height - safeAreaInsets.top - scoreNode.height * 0.5
        )
    }
    
    func showTryAgainButton() {
        let button = TryAgainButton()
        button.onTap = { [weak self] in
            self?.onOpenInitialScene()
        }
        
        addChild(button)
        
        button.position = center
    }
}
