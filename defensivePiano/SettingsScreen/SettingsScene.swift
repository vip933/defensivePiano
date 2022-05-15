//
//  SettingsScene.swift
//  defensivePiano
//
//  Created by Maksim on 14.03.2022.
//

import UIKit
import SpriteKit

class SettingsScene: TransitionScene {
    var backButton = SKSpriteNode()
    var yesButton = SKSpriteNode()
    var noButton = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        self.backgroundColor = DesignManager.shared.backgroundColor
        
        // Test label
        let settingsLabel = LabelNode(text: "Is singleplayer?", fontSize: 30, position: CGPoint(x: self.frame.midX, y: self.frame.midY), fontColor: .green)
        self.addChild(settingsLabel)
        
        let scale = CGFloat(0.35)
        let yesButton = SKSpriteNode(imageNamed: "yes.png")
        yesButton.position = CGPoint(x: self.frame.midX - 50, y: self.frame.midY - 50)
        yesButton.xScale = scale
        yesButton.yScale = scale
        self.yesButton = yesButton
        let noButton = SKSpriteNode(imageNamed: "no.png")
        noButton.position = CGPoint(x: self.frame.midX + 50, y: self.frame.midY - 50)
        noButton.xScale = scale
        noButton.yScale = scale
        self.noButton = noButton
        self.addChild(yesButton)
        self.addChild(noButton)
        
        
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
            
            if (yesButton.contains(location)) {
                self.changeToSceneBy(nameScene: "MenuScene", userData: ["type" : true])
            }
            
            if (noButton.contains(location)) {
                self.changeToSceneBy(nameScene: "MenuScene", userData: ["type" : false])
            }
        }
    }
}
