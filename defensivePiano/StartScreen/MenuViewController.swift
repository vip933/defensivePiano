//
//  GameViewController.swift
//  defensivePiano
//
//  Created by Maksim on 13.03.2022.
//

import UIKit
import SpriteKit
import GameplayKit

class MenuViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.global(qos: .background).async {
            Thread.sleep(forTimeInterval: 2)
            SKNode().run(SKAction.playSoundFileNamed("silent.mp3", waitForCompletion: true))
            print("start sound")
        }
        
        if let view = self.view as! SKView? {
            
            if let scene = MenuScene(fileNamed: "MenuScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .resizeFill
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
        }
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        }
        return .all
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
