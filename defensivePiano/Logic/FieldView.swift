//
//  FieldView.swift
//  defensivePiano
//
//  Created by Maksim on 02.05.2022.
//

import UIKit
import SpriteKit

class FieldView: SKSpriteNode {
    private var gameLabel = SKLabelNode()
    private var enemyHP = SKLabelNode()
    private var backButton = SKSpriteNode()
    private var firstPianoButton = PianoButtonNode()
    private var seccondPianoButton = PianoButtonNode()
    private var thirdPianoButton = PianoButtonNode()
    private var forthPianoButton = PianoButtonNode()
    private var finish = LabelNode()
    private var start = LabelNode()
    
    private var startPoint = CGPoint.zero
    private var finishPoint = CGPoint.zero
    
    init(frame: CGRect) {
        super.init(texture: .none, color: DesignManager.shared.backgroundColor, size: frame.size)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        // Back button
        let backButton = SKSpriteNode(imageNamed: "backArrow")
        backButton.position = CGPoint(x: frame.minX + 50, y: frame.maxY - 40)
        backButton.xScale = 0.35
        backButton.yScale = 0.35
        self.backButton = backButton
        addChild(backButton)
        
        var x = CGFloat(54)
        let y = CGFloat(125)
        
        // Piano button first
        let firstPianoButton = PianoButtonNode(color: .white, size: CGSize(width: (frame.width - 20) / 4, height: frame.height / 3))
        firstPianoButton.attackPower = 10
        firstPianoButton.position = CGPoint(x: x, y: y)
        self.firstPianoButton = firstPianoButton
        addChild(firstPianoButton)
        
        x += (frame.width - 20) / 4 + 4
        
        // Piano button second
        let secondPianoButton = PianoButtonNode(color: .white, size: CGSize(width: (frame.width - 20) / 4, height: frame.height / 3))
        secondPianoButton.attackPower = 40
        secondPianoButton.position = CGPoint(x: x, y: y)
        self.seccondPianoButton = secondPianoButton
        addChild(secondPianoButton)
        
        x += (self.frame.width - 20) / 4 + 4
        
        // Piano button third
        let thirdPianoButton = PianoButtonNode(color: .white, size: CGSize(width: (frame.width - 20) / 4, height: frame.height / 3))
        thirdPianoButton.attackPower = 60
        thirdPianoButton.position = CGPoint(x: x, y: y)
        self.thirdPianoButton = thirdPianoButton
        addChild(thirdPianoButton)
        
        x += (frame.width - 20) / 4 + 4
        
        // Piano button forth
        let forthPianoButton = PianoButtonNode(color: .white, size: CGSize(width: (frame.width - 20) / 4, height: frame.height / 3))
        forthPianoButton.attackPower = 100
        forthPianoButton.position = CGPoint(x: x, y: y)
        self.forthPianoButton = forthPianoButton
        addChild(forthPianoButton)
        
        // Start
        startPoint = CGPoint(x: frame.width - 55, y: frame.height / 3 + 20)
        let start = LabelNode(text: "Start", fontSize: 20, position: startPoint, fontColor: .clear)
        addChild(start)
        self.start = start
        
        // Finish
        finishPoint = CGPoint(x: 55, y: frame.height - 125)
        let finish = LabelNode(text: "Finish", fontSize: 20, position: finishPoint, fontColor: .clear)
        addChild(finish)
        self.finish = finish
        
        // Enemy hp
        let enemyHP = LabelNode(text: "0", fontSize: 20, position: CGPoint(x: frame.maxX - 50, y: frame.maxY - 40), fontColor: .white)
        self.enemyHP = enemyHP
        addChild(enemyHP)
    }
}
