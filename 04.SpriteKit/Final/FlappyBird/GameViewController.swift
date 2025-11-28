//
//  GameViewController.swift
//  FlappyBird
//
//  Created by Róbert Oravec on 14.11.2023.
//

import UIKit
import SpriteKit

final class GameViewController: UIViewController {
    // MARK: Properties
    private let size = BackgroundNode().size
    
    private var skView: SKView {
        view as! SKView
    }
    
    // MARK: Lifecycle
    override func loadView() {
        view = SKView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        openInitialScene()
    }
    
    // MARK: Overrides
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
    
        (skView.scene as? GameScene)?.onSafeAreaChange()
    }
}

// MARK: Public API
extension GameViewController {
    func openInitialScene() {
        let initialScene = GameInitialScene(size: size)
        initialScene.onOpenGameScene = { [weak self] in
            self?.openGameScene()
        }
        
        skView.presentScene(
            initialScene,
            transition: .crossFade(withDuration: 0.5)
        )
    }
    
    func openGameScene() {
        let gameScene = GameScene(size: size)
        gameScene.onOpenInitialScene = { [weak self] in
            self?.openInitialScene()
        }
        
        skView.presentScene(
            gameScene,
            transition: .crossFade(withDuration: 0.5)
        )
    }
}
