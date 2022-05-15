//
//  TransmitionScene.swift
//  defensivePiano
//
//  Created by Maksim on 14.03.2022.
//

import SpriteKit

class TransitionScene: SKScene {
    func changeToSceneBy(nameScene: String, userData: NSMutableDictionary) {
        
        var scene: TransitionScene = TransitionScene()
        
        // Get scene to switch to
        switch nameScene {
        case "GameScene":
            scene = GameScene(size: self.size)
        case "MenuScene":
            scene = MenuScene(size: self.size)
            if userData.count != 0 {
                if userData["damage"] != nil {
                    let damage = userData["damage"] as! Int
                    if (scene as! MenuScene).highScore < damage {
                        (scene as! MenuScene).highScore = damage
                    }
                } else if userData["type"] != nil {
                    let type = userData["type"] as! Bool
                    (scene as! MenuScene).isSinglePlayer = type
                }
            }
        case "SettingsScene":
            scene = SettingsScene(size: self.size)
        case "MultiplayerGameScene":
            scene = MultiplayerGameScene(size: self.size)
        default:
            return
        }
        
        scene.scaleMode = .aspectFill
        scene.userData = userData
        
        let transition = SKTransition.fade(with: DesignManager.shared.backgroundColor, duration: 1.0)
        self.view?.presentScene(scene, transition: transition)
    }
    
}
