//
//  TryAgainButton.swift
//  FlappyBird
//
//  Created by Róbert Oravec on 27.11.25.
//

import SpriteKit

final class TryAgainButton: SKLabelNode {
    // MARK: Properties
    let height: CGFloat = 36
    
    var onTap: () -> Void = {}
    
    // MARK: Init
    override init() {
        super.init()
        
        zPosition = Layer.score
        isUserInteractionEnabled = true
        
        attributedText = NSAttributedString(
            string: "Try again!",
            attributes: [
                NSAttributedString.Key.strokeColor: UIColor.black,
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.strokeWidth: -2.0,
                NSAttributedString.Key.font: UIFont(
                    name: Assets.Fonts.flappy,
                    size: height
                ) as Any
            ]
        )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        onTap()
    }
}
