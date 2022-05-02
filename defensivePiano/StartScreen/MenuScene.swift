//
//  MenuScene.swift
//  defensivePiano
//
//  Created by Maksim on 13.03.2022.
//

import SpriteKit

class MenuScene: TransitionScene {
    var startButton = SKSpriteNode()
    var settingsButton = SKSpriteNode()
    
    var highScore = 0
    
    override func didMove(to view: SKView) {
        setupUI()
    }
    
    private func setupUI() {
        self.backgroundColor = DesignManager.shared.backgroundColor
        
        // Logo
        let logo = ButtonNode(imageName: DesignManager.shared.logoName, position: CGPoint(x: frame.midX, y: frame.midY), xScale: 0.35, yScale: 0.35)
        addChild(logo)
        
        let logoText = LabelNode(text: "Defensive Piano", fontSize: 30, position: CGPoint(x: frame.midX, y: logo.frame.maxY + 5), fontColor: #colorLiteral(red: 0.9254901961, green: 0.9215686275, blue: 0.9529411765, alpha: 1))
        addChild(logoText)
        
        // Best score
        let bestScoreLabel = LabelNode(text: "Best score", fontSize: 30, position: CGPoint(x: frame.midX, y: frame.maxY - 100), fontColor: #colorLiteral(red: 0.9254901961, green: 0.9215686275, blue: 0.9529411765, alpha: 1))
        addChild(bestScoreLabel)
        
        // Score points
        let score = LabelNode(text: String(highScore), fontSize: 30, position: CGPoint(x: frame.midX, y: frame.maxY - 150), fontColor: #colorLiteral(red: 0.9254901961, green: 0.9215686275, blue: 0.9529411765, alpha: 1))
        addChild(score)
        
        // Start button
        let startButton = SKSpriteNode(imageNamed: "startButton")
        startButton.position = CGPoint(x: frame.midX, y: frame.minY + 100)
        startButton.xScale = 0.35
        startButton.yScale = 0.35
        self.startButton = startButton
        addChild(startButton)
        
        // Settings button
        let settingsButton = SKSpriteNode(imageNamed: "settingsButton")
        settingsButton.position = CGPoint(x: frame.maxX - 50, y: frame.maxY - 40)
        settingsButton.xScale = 0.35
        settingsButton.yScale = 0.35
        self.settingsButton = settingsButton
        addChild(settingsButton)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            // To game scene
            if (startButton.contains(location)) {
                changeToSceneBy(nameScene: "GameScene", userData: NSMutableDictionary.init())
            }
            
//            // To settings scene
//            if (settingsButton.contains(location)) {
//                changeToSceneBy(nameScene: "SettingsScene", userData: NSMutableDictionary.init())
//            }
            if (settingsButton.contains(location)) {
                print("multiplayer")
                changeToSceneBy(nameScene: "MultiplayerGameScene", userData: NSMutableDictionary.init())
            }
        }
    }
}
