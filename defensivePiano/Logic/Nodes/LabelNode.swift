//
//  LabelNode.swift
//  defensivePiano
//
//  Created by Maksim on 13.03.2022.
//

import SpriteKit

class LabelNode: SKLabelNode {
    
    convenience init(text: String, fontSize: CGFloat, position: CGPoint, fontColor: UIColor) {
        self.init(fontNamed: DesignManager.shared.font)
        
        self.text = text
        self.fontSize = fontSize
        self.position = position
        self.fontColor = fontColor
    }
}
