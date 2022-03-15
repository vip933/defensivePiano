//
//  SettingsScene.swift
//  defensivePiano
//
//  Created by Maksim on 14.03.2022.
//

import SpriteKit

class SettingsScene: TransitionScene {
    var backButton = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        self.backgroundColor = DesignManager.shared.backgroundColor
        
        // Test label
        let settingsLabel = LabelNode(text: "Settings screen to be done", fontSize: 30, position: CGPoint(x: self.frame.midX, y: self.frame.midY), fontColor: .green)
        self.addChild(settingsLabel)
        
        // Back button
        let backButton = SKSpriteNode(imageNamed: "backArrow")
        backButton.position = CGPoint(x: self.frame.minX + 50, y: self.frame.maxY - 40)
        backButton.xScale = 0.35
        backButton.yScale = 0.35
        self.backButton = backButton
        self.addChild(backButton)
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            // To menu scene
            if (backButton.contains(location)) {
                self.changeToSceneBy(nameScene: "MenuScene", userData: NSMutableDictionary.init())
            }
        }
    }
}
