//
//  GameScene.swift
//  defensivePiano
//
//  Created by Maksim on 13.03.2022.
//

import SpriteKit

final class GameScene: TransitionScene {
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
    
    // Enemy piano nodes
    private var enemies: [EnemyNode] = []
    var givenDamage = 0
    
    override func didMove(to view: SKView) {
        setupUI()
        setupEnemy()
        DispatchQueue.global(qos: .background).async { [weak self] in
            Thread.sleep(forTimeInterval: 3)
            self?.setupEnemy()
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        if !UIScreen.main.bounds.contains(enemies[0].position) {
            enemies[0].removeFromParent()
            enemies.remove(at: 0)
        }
        if (enemies.count == 0) {
            changeToSceneBy(nameScene: "MenuScene", userData: ["damage": givenDamage])
        }
    }
    
    private func setupUI() {
        backgroundColor = DesignManager.shared.backgroundColor
        
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
        let start = LabelNode(text: "Start", fontSize: 20, position: startPoint, fontColor: .blue)
        addChild(start)
        self.start = start
        
        // Finish
        finishPoint = CGPoint(x: 55, y: frame.height - 125)
        let finish = LabelNode(text: "Finish", fontSize: 20, position: finishPoint, fontColor: .blue)
        addChild(finish)
        self.finish = finish
        
        // Enemy hp
        let enemyHP = LabelNode(text: "0", fontSize: 20, position: CGPoint(x: frame.maxX - 50, y: frame.maxY - 40), fontColor: .white)
        self.enemyHP = enemyHP
        addChild(enemyHP)
    }
    
    private func setupEnemy() {
        let enemy = EnemyNode(imageNamed: "badNote1.png")
        enemy.size.height = 64
        enemy.size.width = 64
        enemy.position = startPoint
        enemies.append(enemy)
        print("enemies appended.")
        print(enemies.count)
        addChild(enemy)
        
        let leftX = finishPoint.x
        let rightX = startPoint.x
        let bottomY = startPoint.y
        let topY = finishPoint.y
        
        var currentX = startPoint.x
        var currentY = startPoint.y
        
        var points: [CGPoint] = []
        
        // Enemy's path
        let repeats = 3
        for _ in 0..<repeats  {
            points.append(CGPoint(x: currentX, y: currentY))
            currentX = leftX
            points.append(CGPoint(x: currentX, y: currentY))
            currentY += (topY - bottomY) / 6
            points.append(CGPoint(x: currentX, y: currentY))
            currentX = rightX
            points.append(CGPoint(x: currentX, y: currentY))
            currentY += (topY - bottomY) / 6
        }
        points.append(CGPoint(x: currentX, y: currentY))
        points.append(CGPoint(x: leftX, y: currentY))
        
        var moves: [SKAction] = []
        
        var previousPoint = startPoint
        
        // Enemy's path action
        for point in points {
            moves.append(SKAction.move(to: point, duration: Double(distance(point, previousPoint)) / 100))
            previousPoint = point
        }
        
        let action = SKAction.repeatForever(SKAction.sequence(moves))
        enemy.run(action)
        enemyHP.text = String(enemy.hp)
    }
    
    // Evaluates distance between two points
    private func distance(_ a: CGPoint, _ b: CGPoint) -> CGFloat {
        let xDist = a.x - b.x
        let yDist = a.y - b.y
        return CGFloat(sqrt(xDist * xDist + yDist * yDist))
    }
    
    private func shoot(enemy: EnemyNode, shooter: PianoButtonNode) {
        // Create rocket
        let rocket = SKSpriteNode(imageNamed: "lighting.png")
        rocket.size.height = 35
        rocket.size.width = 35
        rocket.position = CGPoint(x: shooter.frame.midX, y: shooter.frame.midY)
        addChild(rocket)
        
        // Rocket flying action
        let fly = SKAction.move(to: enemy.position, duration: 0.1)
        let remove = SKAction.move(to: DesignManager.shared.diePoint, duration: 0)
        rocket.zPosition = 3
        
        // Rocket health effect
        if enemy.hp - shooter.attackPower >= 0 {
            givenDamage += shooter.attackPower
        } else {
            givenDamage += enemy.hp
        }
        
        enemy.hp -= shooter.attackPower
        enemyHP.text = String(enemy.hp)
        
        // Die action
        if enemy.hp <= 0 {
            let dieSound = SKAction.playSoundFileNamed("explosion.mp3", waitForCompletion: true)
            run(dieSound)
            let death = SKAction.move(to: DesignManager.shared.diePoint, duration: 0)
            rocket.run(SKAction.sequence([fly, remove]))
            enemy.run(death)
        } else {
            rocket.run(SKAction.sequence([fly, remove]))
        }
    }
    
    private func loseGame() {
        changeToSceneBy(nameScene: "MenuScene", userData: ["damage": givenDamage])
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            // To menu scene
            if (backButton.contains(location)) {
                changeToSceneBy(nameScene: "MenuScene", userData: NSMutableDictionary.init())
            }
            // First piano button
            if (firstPianoButton.contains(location)) {
                firstPianoButton.run(SKAction.playSoundFileNamed("do.mp3", waitForCompletion: true))
                shoot(enemy: enemies[0], shooter: firstPianoButton)
            }
            
            // Second piano button
            if (seccondPianoButton.contains(location)) {
                seccondPianoButton.run(SKAction.playSoundFileNamed("fa.mp3", waitForCompletion: true))
                shoot(enemy: enemies[0], shooter: seccondPianoButton)
            }
            
            // Third piano button
            if (thirdPianoButton.contains(location)) {
                thirdPianoButton.run(SKAction.playSoundFileNamed("la.mp3", waitForCompletion: true))
                shoot(enemy: enemies[0], shooter: thirdPianoButton)
            }
            
            // Forth piano button
            if (forthPianoButton.contains(location)) {
                forthPianoButton.run(SKAction.playSoundFileNamed("si.mp3", waitForCompletion: true))
                shoot(enemy: enemies[0], shooter: forthPianoButton)
            }
        }
    }
}
