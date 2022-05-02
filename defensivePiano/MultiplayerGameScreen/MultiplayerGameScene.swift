//
//  MultiplayerGameScene.swift
//  defensivePiano
//
//  Created by Maksim on 02.05.2022.
//

import SpriteKit

final class MultiplayerGameScene: TransitionScene, SKPhysicsContactDelegate {
    private var gameLabel = SKLabelNode()
    private var enemyHP = SKLabelNode()
    private var backButton = SKSpriteNode()
    private var firstPianoButton1 = PianoButtonNode()
    private var seccondPianoButton1 = PianoButtonNode()
    private var thirdPianoButton1 = PianoButtonNode()
    private var forthPianoButton1 = PianoButtonNode()
    
    private var firstPianoButton2 = PianoButtonNode()
    private var seccondPianoButton2 = PianoButtonNode()
    private var thirdPianoButton2 = PianoButtonNode()
    private var forthPianoButton2 = PianoButtonNode()
    
    private var finish = LabelNode()
    private var start1 = LabelNode()
    private var start2 = LabelNode()
    
    private var startPoint1 = CGPoint.zero
    private var startPoint2 = CGPoint.zero
    private var finishPoint = CGPoint.zero
    
    // Enemy piano nodes
    private var enemies1: [EnemyNode] = []
    private var enemies2: [EnemyNode] = []
    var givenDamage1 = 0
    var givenDamaga2 = 0
    
    private let finishMask: UInt32 = 0x1 << 0
    private let enemyMask: UInt32 = 0x1 << 1
    private let enemy2Mask: UInt32 = 0x1 << 2
    private var timer1: Timer?
    private var timer2: Timer?
    
    override func didMove(to view: SKView) {
        view.showsPhysics = true
        setupUI()
        setupSpawner()
        setupPhysics()
    }
    
    override func update(_ currentTime: TimeInterval) {
        if (enemies1.count != 0 ) {
            if !UIScreen.main.bounds.contains(enemies1[0].position) {
                enemies1[0].removeFromParent()
                enemies1.remove(at: 0)
            }
        }
        if (enemies2.count != 0 ) {
            if !UIScreen.main.bounds.contains(enemies2[0].position) {
                enemies2[0].removeFromParent()
                enemies2.remove(at: 0)
            }
        }
        
    }
    
    private func setupPhysics() {
        self.physicsWorld.contactDelegate = self
        
        finish.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: finish.frame.height, height: finish.frame.width))
        finish.physicsBody?.isDynamic = true
        finish.physicsBody?.affectedByGravity = false
        finish.physicsBody?.categoryBitMask = finishMask
        finish.physicsBody?.contactTestBitMask = enemyMask
        finish.physicsBody?.collisionBitMask = 0
    }
    
    private func setupSpawner() {
        timer1 = Timer.scheduledTimer(timeInterval: 1.2, target: self, selector: #selector(self.setupEnemy), userInfo: nil, repeats: true)
        timer2 = Timer.scheduledTimer(timeInterval: 1.2, target: self, selector: #selector(self.setupEnemy2), userInfo: nil, repeats: true)
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
        var y = CGFloat(110)
        
        // Piano button first
        let firstPianoButton = PianoButtonNode(color: .red, size: CGSize(width: (frame.width - 20) / 4, height: frame.height / 4))
        firstPianoButton.attackPower = 10
        firstPianoButton.position = CGPoint(x: x, y: y)
        self.firstPianoButton1 = firstPianoButton
        addChild(firstPianoButton)
        
        x += (frame.width - 20) / 4 + 4
        
        // Piano button second
        let secondPianoButton = PianoButtonNode(color: .red, size: CGSize(width: (frame.width - 20) / 4, height: frame.height / 4))
        secondPianoButton.attackPower = 40
        secondPianoButton.position = CGPoint(x: x, y: y)
        self.seccondPianoButton1 = secondPianoButton
        addChild(secondPianoButton)
        
        x += (self.frame.width - 20) / 4 + 4
        
        // Piano button third
        let thirdPianoButton = PianoButtonNode(color: .red, size: CGSize(width: (frame.width - 20) / 4, height: frame.height / 4))
        thirdPianoButton.attackPower = 60
        thirdPianoButton.position = CGPoint(x: x, y: y)
        self.thirdPianoButton1 = thirdPianoButton
        addChild(thirdPianoButton)
        
        x += (frame.width - 20) / 4 + 4
        
        // Piano button forth
        let forthPianoButton = PianoButtonNode(color: .red, size: CGSize(width: (frame.width - 20) / 4, height: frame.height / 4))
        forthPianoButton.attackPower = 100
        forthPianoButton.position = CGPoint(x: x, y: y)
        self.forthPianoButton1 = forthPianoButton
        addChild(forthPianoButton)
        
        //--------------------------------------------------------
        x = CGFloat(54)
        y = CGFloat(frame.height - 180)
        
        // Piano button forth
        let forthPianoButton2 = PianoButtonNode(color: .blue, size: CGSize(width: (frame.width - 20) / 4, height: frame.height / 4))
        forthPianoButton2.attackPower = 100
        forthPianoButton2.position = CGPoint(x: x, y: y)
        self.forthPianoButton2 = forthPianoButton2
        addChild(forthPianoButton2)
        
        x += (frame.width - 20) / 4 + 4
        
        // Piano button third
        let thirdPianoButton2 = PianoButtonNode(color: .blue, size: CGSize(width: (frame.width - 20) / 4, height: frame.height / 4))
        thirdPianoButton2.attackPower = 60
        thirdPianoButton2.position = CGPoint(x: x, y: y)
        self.thirdPianoButton2 = thirdPianoButton2
        addChild(thirdPianoButton2)
        
        x += (self.frame.width - 20) / 4 + 4
        
        // Piano button second
        let secondPianoButton2 = PianoButtonNode(color: .blue, size: CGSize(width: (frame.width - 20) / 4, height: frame.height / 4))
        secondPianoButton2.attackPower = 40
        secondPianoButton2.position = CGPoint(x: x, y: y)
        self.seccondPianoButton2 = secondPianoButton2
        addChild(secondPianoButton2)
        
        x += (frame.width - 20) / 4 + 4
        
        // Piano button first
        let firstPianoButton2 = PianoButtonNode(color: .blue, size: CGSize(width: (frame.width - 20) / 4, height: frame.height / 4))
        firstPianoButton2.attackPower = 10
        firstPianoButton2.position = CGPoint(x: x, y: y)
        self.firstPianoButton2 = firstPianoButton2
        addChild(firstPianoButton2)
        
        //--------------------------
        
        // Start1
        startPoint1 = CGPoint(x: frame.width - 55, y: (frame.height - 85) / 4 + 40)
        let start1 = LabelNode(text: "Start", fontSize: 20, position: startPoint1, fontColor: .clear)
        addChild(start1)
        self.start1 = start1
        
        // Start2
        startPoint2 = CGPoint(x: frame.width - 55, y: (frame.height - 85) / 4 * 3 - 40)
        let start2 = LabelNode(text: "Start", fontSize: 20, position: startPoint2, fontColor: .clear)
        addChild(start2)
        self.start2 = start2
        
        
        // Finish
        finishPoint = CGPoint(x: 30, y: (frame.height - 84) / 2.0)
        let finish = LabelNode(text: "Finish", fontSize: 20, position: finishPoint, fontColor: .clear)
        addChild(finish)
        self.finish = finish
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        DispatchQueue.global(qos: .background).async {
            for i in 0..<self.enemies1.count {
                self.enemies1[i].removeFromParent()
            }
            for i in 0..<self.enemies2.count {
                self.enemies2[i].removeFromParent()
            }
            self.enemies1.removeAll()
            self.enemies2.removeAll()
            if let timer = self.timer1,
            let timer2 = self.timer2 {
                timer.invalidate()
                timer2.invalidate()
            }
        }
        changeToSceneBy(nameScene: "MenuScene", userData: ["damage": givenDamage1])
    }
    
    @objc
    private func setupEnemy() {
        let imgName = "badNote2.png"
        let enemy = EnemyNode(imageNamed: imgName)
        enemy.size.height = 32
        enemy.size.width = 32
        enemy.position = startPoint1
        enemies1.append(enemy)
        
        enemy.physicsBody = SKPhysicsBody(rectangleOf: enemy.size)
        enemy.physicsBody?.isDynamic = false
        enemy.physicsBody?.categoryBitMask = enemyMask
        enemy.physicsBody?.contactTestBitMask = finishMask
        enemy.physicsBody?.collisionBitMask = finishMask
        addChild(enemy)
        
        let leftX = finishPoint.x
        let rightX = startPoint1.x
        let bottomY = startPoint1.y
        let topY = finishPoint.y - 20
        
        var currentX = startPoint1.x
        var currentY = startPoint1.y
        
        var points: [CGPoint] = []
        
        // Enemy's path
        let repeats = 2
        for _ in 0..<repeats  {
            points.append(CGPoint(x: currentX, y: currentY))
            currentX = leftX
            points.append(CGPoint(x: currentX, y: currentY))
            currentY += (topY - bottomY) / 4
            points.append(CGPoint(x: currentX, y: currentY))
            currentX = rightX
            points.append(CGPoint(x: currentX, y: currentY))
            currentY += (topY - bottomY) / 4
        }
        points.append(CGPoint(x: currentX, y: currentY))
        points.append(CGPoint(x: leftX, y: currentY))
        
        var moves: [SKAction] = []
        
        var previousPoint = startPoint1
        
        // Enemy's path action
        for point in points {
            moves.append(SKAction.move(to: point, duration: Double(distance(point, previousPoint)) / 100))
            previousPoint = point
        }
        
        let action = SKAction.repeatForever(SKAction.sequence(moves))
        enemy.run(action)
        enemyHP.text = String(enemy.hp)
    }
    
    
    @objc
    private func setupEnemy2() {
        let imgName = "badNote1.png"
        let enemy = EnemyNode(imageNamed: imgName)
        enemy.size.height = 32
        enemy.size.width = 32
        enemy.position = startPoint2
        enemies2.append(enemy)
        
        enemy.physicsBody = SKPhysicsBody(rectangleOf: enemy.size)
        enemy.physicsBody?.isDynamic = false
        enemy.physicsBody?.categoryBitMask = enemy2Mask
        enemy.physicsBody?.contactTestBitMask = finishMask
        enemy.physicsBody?.collisionBitMask = finishMask
        addChild(enemy)
        
        let leftX = finishPoint.x
        let rightX = startPoint2.x
        let bottomY = startPoint2.y
        let topY = finishPoint.y + 20
        
        var currentX = startPoint2.x
        var currentY = startPoint2.y
        
        var points: [CGPoint] = []
        
        // Enemy's path
        let repeats = 2
        for _ in 0..<repeats  {
            points.append(CGPoint(x: currentX, y: currentY))
            currentX = leftX
            points.append(CGPoint(x: currentX, y: currentY))
            currentY += (topY - bottomY) / 4
            points.append(CGPoint(x: currentX, y: currentY))
            currentX = rightX
            points.append(CGPoint(x: currentX, y: currentY))
            currentY += (topY - bottomY) / 4
        }
        points.append(CGPoint(x: currentX, y: currentY))
        points.append(CGPoint(x: leftX, y: currentY))
        
        var moves: [SKAction] = []
        
        var previousPoint = startPoint2
        
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
    
    private func shoot(enemy: EnemyNode, shooter: PianoButtonNode, power: Int, isFirst: Bool) {
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
        if enemy.hp - power >= 0 {
            if (isFirst) {
                givenDamage1 += power
            } else {
                givenDamaga2 += power
            }
        } else {
            if (isFirst) {
                givenDamage1 += enemy.hp
            } else {
                givenDamaga2 += enemy.hp
            }
        }
        
        enemy.hp -= power
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if enemies1.count == 0 {
            return
        }
        for touch in touches {
            let location = touch.location(in: self)
            
            // To menu scene
            if (backButton.contains(location)) {
                if let timer = self.timer1,
                let timer2 = self.timer2 {
                    timer.invalidate()
                    timer2.invalidate()
                }
                changeToSceneBy(nameScene: "MenuScene", userData: NSMutableDictionary.init())
            }
            
            // First piano button
            if (firstPianoButton1.contains(location)) {
                firstPianoButton1.color = .darkGray
                DispatchQueue.global(qos: .background).async {
                    self.firstPianoButton1.run(SKAction.playSoundFileNamed("do.mp3", waitForCompletion: true))
                }
                shoot(enemy: enemies1[0], shooter: firstPianoButton1, power: firstPianoButton1.attackPower, isFirst: true)
            }
            
            // Second piano button
            if (seccondPianoButton1.contains(location)) {
                seccondPianoButton1.color = .darkGray
                DispatchQueue.global(qos: .background).async {
                    self.seccondPianoButton1.run(SKAction.playSoundFileNamed("fa.mp3", waitForCompletion: true))
                }
                shoot(enemy: enemies1[0], shooter: seccondPianoButton1, power: seccondPianoButton1.attackPower, isFirst: true)
            }
            
            // Third piano button
            if (thirdPianoButton1.contains(location)) {
                thirdPianoButton1.color = .darkGray
                DispatchQueue.global(qos: .background).async {
                    self.thirdPianoButton1.run(SKAction.playSoundFileNamed("la.mp3", waitForCompletion: true))
                }
                shoot(enemy: enemies1[0], shooter: thirdPianoButton1, power: thirdPianoButton1.attackPower, isFirst: true)
            }
            
            // Forth piano button
            if (forthPianoButton1.contains(location)) {
                forthPianoButton1.color = .darkGray
                DispatchQueue.global(qos: .background).async {
                    self.forthPianoButton1.run(SKAction.playSoundFileNamed("si.mp3", waitForCompletion: true))
                }
                shoot(enemy: enemies1[0], shooter: forthPianoButton1, power: forthPianoButton1.attackPower, isFirst: true)
            }
            
            // First piano button
            if (firstPianoButton2.contains(location)) {
                firstPianoButton2.color = .darkGray
                DispatchQueue.global(qos: .background).async {
                    self.firstPianoButton2.run(SKAction.playSoundFileNamed("do.mp3", waitForCompletion: true))
                }
                shoot(enemy: enemies2[0], shooter: firstPianoButton2, power: firstPianoButton2.attackPower, isFirst: false)
            }
            
            // Second piano button
            if (seccondPianoButton2.contains(location)) {
                seccondPianoButton2.color = .darkGray
                DispatchQueue.global(qos: .background).async {
                    self.seccondPianoButton2.run(SKAction.playSoundFileNamed("fa.mp3", waitForCompletion: true))
                }
                shoot(enemy: enemies2[0], shooter: seccondPianoButton2, power: seccondPianoButton2.attackPower, isFirst: false)
            }
            
            // Third piano button
            if (thirdPianoButton2.contains(location)) {
                thirdPianoButton2.color = .darkGray
                DispatchQueue.global(qos: .background).async {
                    self.thirdPianoButton2.run(SKAction.playSoundFileNamed("la.mp3", waitForCompletion: true))
                }
                shoot(enemy: enemies2[0], shooter: thirdPianoButton2, power: thirdPianoButton2.attackPower, isFirst: false)
            }
            
            // Forth piano button
            if (forthPianoButton2.contains(location)) {
                forthPianoButton2.color = .darkGray
                DispatchQueue.global(qos: .background).async {
                    self.forthPianoButton2.run(SKAction.playSoundFileNamed("si.mp3", waitForCompletion: true))
                }
                shoot(enemy: enemies2[0], shooter: forthPianoButton2, power: forthPianoButton2.attackPower, isFirst: false)
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            // First piano button
            if (firstPianoButton1.contains(location)) {
                firstPianoButton1.color = .red
            }
            
            // Second piano button
            if (seccondPianoButton1.contains(location)) {
                seccondPianoButton1.color = .red
            }
            
            // Third piano button
            if (thirdPianoButton1.contains(location)) {
                thirdPianoButton1.color = .red
            }
            
            // Forth piano button
            if (forthPianoButton1.contains(location)) {
                forthPianoButton1.color = .red
            }
            
            // First piano button
            if (firstPianoButton2.contains(location)) {
                firstPianoButton2.color = .blue
            }
            
            // Second piano button
            if (seccondPianoButton2.contains(location)) {
                seccondPianoButton2.color = .blue
            }
            
            // Third piano button
            if (thirdPianoButton2.contains(location)) {
                thirdPianoButton2.color = .blue
            }
            
            // Forth piano button
            if (forthPianoButton2.contains(location)) {
                forthPianoButton2.color = .blue
            }
        }
    }
}

