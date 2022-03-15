//
//  ButtonNode.swift
//  defensivePiano
//
//  Created by Maksim on 13.03.2022.
//

import SpriteKit

class ButtonNode: SKSpriteNode {
    
    var originalXScale: CGFloat = 0
    var originalYScale: CGFloat = 0
    
    init(imageName: String, position: CGPoint, xScale: CGFloat, yScale: CGFloat) {
        let texture = SKTexture(imageNamed: imageName)
        super.init(texture: texture, color: .clear, size: texture.size())
        
        self.position = position
        self.xScale = xScale
        self.yScale = yScale
        self.originalXScale = xScale
        self.originalYScale = yScale
        
        buttonAnimation()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buttonAnimation() {
        let scaleDownAction = SKAction.scale(to: originalXScale / 1.3, duration: 1.5)
        let scaleUpAction = SKAction.scale(to: originalXScale, duration: 2.0)
        let sequence = SKAction.sequence([scaleDownAction, scaleUpAction])
        
        self.run(SKAction.repeatForever(sequence))
    }
    
}
