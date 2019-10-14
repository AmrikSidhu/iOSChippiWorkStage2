//
//  GameScene.swift
//  ChippyGame
//
//  Created by AJAY BAJWA on 2019-10-05.
//  Copyright © 2019 AJAY BAJWA. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    
    
    var player:Player = Player(imageNamed: "player")
    //var enemy:Enemy = Enemy(imageNamed: "enemy")
    var enemy:SKSpriteNode!
//     var enemy2:SKSpriteNode!
//     var enemy3:SKSpriteNode!
//     var enemy4:SKSpriteNode!
//     var enemy5:SKSpriteNode!
//     var enemy6:SKSpriteNode!
//     var enemy7:SKSpriteNode!
//     var enemy8:SKSpriteNode!
    //var playerBullet: SKSpriteNode!
    var playerBullet:Bullet = Bullet(imageNamed: "player_bullet")
    var enemyBullet:Bullet = Bullet(imageNamed: "enemyBullet")
    //var screenBorder:SKSpriteNode!
    var bulletsArray:[SKSpriteNode] = []
     var enemyBulletsArray:[SKSpriteNode] = []
    var upArrow:SKSpriteNode!
    var downArrow:SKSpriteNode!
    var leftArrow:SKSpriteNode!
    var rightArrow:SKSpriteNode!
    var upLeftArrow:SKSpriteNode!
    var downLeftArrow:SKSpriteNode!
    var upRightArrow:SKSpriteNode!
    var downRightArrow:SKSpriteNode!
    var arrowTouched:String = ""
    var touch:UITouch!
    var mouseX:CGFloat! = 100
    var mouseY:CGFloat! = 100
    var arrowButtonTouched = false
    var shootBullet = false
    var arrowButtonsRect:CGRect!
    
    override func didMove(to view: SKView) {
        
        // Set the background color of the app
        self.backgroundColor = SKColor.black;
        let background = SKSpriteNode(imageNamed: "background")
        background.size = self.size
        background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        background.zPosition = -1
        addChild(background)
        print("screen: \(self.size.width), \(self.size.height)")
    
        self.player = Player(imageNamed: "player")
        self.player.size.width = self.size.width/15
        self.player.size.height = self.size.height/12
        self.player.position = CGPoint(x: self.size.width*0.2, y: self.size.height / 2)
        addChild(self.player)
        
        self.enumerateChildNodes(withName: "enemy") {
                        (node, stop) in
            self.enemy = node as? SKSpriteNode
        
        self.enemy = self.scene?.childNode(withName: "enemy") as? SKSpriteNode
        }

        
//        let square = UIBezierPath(rect: CGRect(x: 0,y: 0, width: 50, height: 50))
//        let followSquare = SKAction.follow(square.cgPath, asOffset: true, orientToPath: false, duration: 5.0)
        let circle = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 30, height: 50), cornerRadius: 30)
        let followCircle = SKAction.follow(circle.cgPath, asOffset: true, orientToPath: false, duration: 5.0)
        let circleAnimation = followCircle.reversed()
//
//        //let reverseCircleAnimation = circleAnimation.reversed()
//        //self.enemy.run(SKAction.sequence([circleAnimation,reverseCircleAnimation]))
        self.enumerateChildNodes(withName: "enemy") {
                        (node, stop) in
            self.enemy = node as? SKSpriteNode
        self.enemy.run(SKAction.repeatForever(circleAnimation.reversed()))
        }
//        self.enemy.physicsBody = SKPhysicsBody(texture: self.enemy.texture ?? SKTexture(imageNamed: "enemy"), alphaThreshold: 0, size: (self.enemy.texture!.size()))
//        self.enemy.physicsBody = SKPhysicsBody(texture: self.enemy.texture!, size: (self.enemy.texture!.size()))
//        self.enemy.physicsBody?.affectedByGravity = false
        
        
        self.leftArrow = SKSpriteNode(imageNamed: "left")
//        self.leftArrow.physicsBody = SKPhysicsBody(texture: self.leftArrow.texture!, size: self.leftArrow.texture!.size())
        self.leftArrow.size = CGSize(width: self.size.width/25, height: self.size.height/20)
        self.leftArrow.position = CGPoint(x: 100, y: 250)
        addChild(self.leftArrow)
        
        self.downArrow = SKSpriteNode(imageNamed: "down")
        self.downArrow.size = CGSize(width: self.size.height/20 , height: self.size.width/30)
        self.downArrow.position = CGPoint(x: self.leftArrow.position.x + self.leftArrow.size.width*1.5, y: self.leftArrow.position.y - self.leftArrow.size.height*1.5)
        addChild(self.downArrow)
        
        self.rightArrow = SKSpriteNode(imageNamed: "right")
//        self.rightArrow.physicsBody = SKPhysicsBody(texture: self.rightArrow.texture!, size: self.rightArrow.texture!.size())
        self.rightArrow.size = CGSize(width: self.size.width/25, height: self.size.height/20)
        self.rightArrow.position = CGPoint(x: self.downArrow.position.x + self.leftArrow.size.width*1.5, y: self.leftArrow.position.y)
        print("righ : \(self.rightArrow.position.x)")
        addChild(self.rightArrow)
        
        self.upArrow = SKSpriteNode(imageNamed: "up")
//        self.upArrow.physicsBody = SKPhysicsBody(texture: self.upArrow.texture!, size: self.upArrow.texture!.size())
        self.upArrow.size = CGSize(width: self.size.height/20, height: self.size.width/30)
        self.upArrow.position = CGPoint(x: self.downArrow.position.x, y: self.leftArrow.position.y + self.leftArrow.size.height*1.5)
        addChild(self.upArrow)
        
        self.upLeftArrow = SKSpriteNode(imageNamed: "upLeft")
//        self.upLeftArrow.physicsBody = SKPhysicsBody(texture: self.upLeftArrow.texture!, size: self.upLeftArrow.texture!.size())
        self.upLeftArrow.size = CGSize(width: self.size.height/20, height: self.size.width/30)
        self.upLeftArrow.position = CGPoint(x: self.leftArrow.position.x + self.leftArrow.size.width*0.7, y: self.upArrow.position.y - self.upArrow.size.height*0.7)
        addChild(self.upLeftArrow)
        
        self.downLeftArrow = SKSpriteNode(imageNamed: "downLeft")
//        self.downLeftArrow.physicsBody = SKPhysicsBody(texture: self.downLeftArrow.texture!, size: self.downLeftArrow.texture!.size())
        self.downLeftArrow.size = CGSize(width: self.size.height/20, height: self.size.width/30)
        self.downLeftArrow.position = CGPoint(x: self.upLeftArrow.position.x, y: self.downArrow.position.y + self.downArrow.size.height*0.7)
        addChild(self.downLeftArrow)
        
        self.downRightArrow = SKSpriteNode(imageNamed: "downRight")
//    self.downRightArrow.physicsBody = SKPhysicsBody(texture: self.downRightArrow.texture!, size: self.downRightArrow.texture!.size())
        self.downRightArrow.size = CGSize(width: self.size.height/20, height: self.size.width/30)
        self.downRightArrow.position = CGPoint(x: self.rightArrow.position.x - self.rightArrow.size.width*0.7, y: self.downLeftArrow.position.y)
        addChild(self.downRightArrow)
        
        self.upRightArrow = SKSpriteNode(imageNamed: "upRight")
//         self.upRightArrow.physicsBody = SKPhysicsBody(texture: self.upRightArrow.texture!, size: self.upRightArrow.texture!.size())
        self.upRightArrow.size = CGSize(width: self.size.height/20, height: self.size.width/30)
        self.upRightArrow.position = CGPoint(x: self.downRightArrow.position.x, y: self.upLeftArrow.position.y)
        addChild(self.upRightArrow)
        
         self.arrowButtonsRect = CGRect(x: 0, y: 0, width: self.rightArrow.position.x + self.rightArrow.size.width/2, height: self.upArrow.position.y + self.upArrow.size.height/2)
    
    
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        if self.arrowButtonTouched == true {
            self.movePlayer()
        }
        if self.shootBullet == true{
            self.spawnPlayerBullet()
            self.moveBulletToTarget()
        }
        self.removeBullet()
        self.bulletHitsEnemy()
        self.spawnEnemyBullet()
        self.randomeenemyBulltsonScreen()
        
    }
    
    
//    func didBegin(_ contact: SKPhysicsContact) {
//        let nodeA = contact.bodyA.node
//        let nodeB = contact.bodyB.node
//
//
//    }
    
    
    func spawnPlayerBullet() {
        // 1. Make a bullet
        
        if(self.bulletsArray.count <= 2){
            self.playerBullet = Bullet(imageNamed: "player_bullet")
            self.playerBullet.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "player_bullet"), size: self.playerBullet.size)
            self.playerBullet.physicsBody?.affectedByGravity = false
            playerBullet.size.width = self.player.size.width/2
            playerBullet.size.height = self.player.size.height/2
        playerBullet.position = CGPoint(x: self.player.position.x - 30, y: self.player.position.y)
        addChild(playerBullet)
        self.bulletsArray.append(playerBullet)
        }
        
        
        
        // MARK: Z_creating enemy bulletss
        
        //        else{
        //            let previousBullet = self.bulletsArray[self.bulletsArray.count - 1]
        //            playerBullet.position = CGPoint(x: previousBullet.position.x-200, y: self.player.position.y)
        //            addChild(playerBullet)
        //            self.bulletsArray.append(playerBullet)
        //        }
//        let moveBullet = SKAction.moveBy(x: -50, y: 0, duration: 0.05)
//        let indefiniteBulletMove = SKAction.repeatForever(moveBullet)
//        playerBullet.run(indefiniteBulletMove)
//
        
        
        //print("size of bullets: \(self.bulletsArray.count)")
        //print("x of bullet: \(self.bulletsArray[self.bulletsArray.count-1].position.x)" )
    }
    func spawnEnemyBullet() {
        
        if(self.enemyBulletsArray.count <= 20){
            self.enemyBullet = Bullet(imageNamed: "enemyBullet")
            self.enemyBullet.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "enemyBullet"), size: self.enemyBullet.size)
            self.enemyBullet.physicsBody?.affectedByGravity = false
            enemyBullet.size.width = self.enemy.size.width/10
            enemyBullet.size.height = self.enemy.size.height/10
            enemyBullet.position = CGPoint(x: self.enemy.position.x , y: self.enemy.position.y)
            addChild(enemyBullet)
            self.enemyBulletsArray.append(enemyBullet)
        }
    }

    func movePlayer(){
        
        if ((self.arrowTouched == "up")&&(self.player.position.y < self.size.height)){
            let playerMove = SKAction.moveBy(x: 0, y: 30, duration: 0.01)
            self.player.run(playerMove)
            self.player.zRotation = .pi / 2
        }
        else if (self.arrowTouched == "down")&&(self.player.position.y > 0){
            let playerMove = SKAction.moveBy(x: 0, y: -30, duration: 0.01)
            self.player.run(playerMove)
            self.player.zRotation = .pi / -2
        }
        else if (self.arrowTouched == "left")&&(self.player.position.x > 0 ){
            let playerMove = SKAction.moveBy(x: -30, y: 0, duration: 0.01)
            self.player.run(playerMove)
            self.player.zRotation = .pi
            //self.player.position.x = self.player.position.x - 10
        }
        else if (self.arrowTouched == "right")&&(self.player.position.x < self.size.width){
            let playerMove = SKAction.moveBy(x: 30, y: 0, duration: 0.01)
            self.player.run(playerMove)
            self.player.zRotation = 0
            //self.player.position.x = self.player.position.x + 10
        }
        else if (self.arrowTouched == "upRight")&&(self.player.position.x < self.size.width){
            let playerMove = SKAction.moveBy(x: 30, y: 30, duration: 0.01)
            self.player.run(playerMove)
            self.player.zRotation = .pi / 4
            //self.player.position.x = self.player.position.x + 10
        }
        else if (self.arrowTouched == "downRight")&&(self.player.position.x < self.size.width)&&(self.player.position.y < self.size.height){
            let playerMove = SKAction.moveBy(x: 30, y: -30, duration: 0.01)
            self.player.run(playerMove)
            self.player.zRotation = .pi / -4
            //self.player.position.x = self.player.position.x + 10
        }
        
        else if (self.arrowTouched == "downLeft")&&(self.player.position.x > 0)&&(self.player.position.y > 0){
            let playerMove = SKAction.moveBy(x: -30, y: -30, duration: 0.01)
            self.player.run(playerMove)
            self.player.zRotation = .pi / -1.5
            //self.player.position.x = self.player.position.x + 10
        }
        
        else if (self.arrowTouched == "upLeft")&&(self.player.position.x > 0)&&(self.player.position.y < self.size.height){
            let playerMove = SKAction.moveBy(x: -30, y: 30, duration: 0.01)
            self.player.run(playerMove)
            self.player.zRotation = .pi / 1.5
            //self.player.position.x = self.player.position.x + 10
        }
        
        // let indefiniteBulletMove = SKAction.repeatForever(moveBullet)
        
        //        else if (self.arrowTouched == "") {
        //            self.player.position = self.player.position
        //        }
        //self.player.texture = SKTexture(imageNamed: "up")
        
    }
    func removeBullet(){
        
        self.playerBullet.name = "playerBullet"
        self.enumerateChildNodes(withName: "playerBullet") {
            node, stop in
            if(self.bulletsArray.count != 0){
            if (node is SKSpriteNode) {
                let sprite = node as! SKSpriteNode
                // Check if the node is not in the scene
                if (sprite.position.x < 100 || sprite.position.x > self.size.width - 100 || sprite.position.y < 100 || sprite.position.y > self.size.height - 100) {
                    // Remove the Sprite first from Parent then, from Array. else it does not completely removes the sprite and creates memory problems.
                    sprite.removeFromParent()
                    self.bulletsArray.removeFirst()
                    print("outside")
                }
                if sprite.intersects(self.enemy) {
                    self.enemy.physicsBody = nil
                    sprite.removeFromParent()
                    self.bulletsArray.removeFirst()
                    }
                }
            }
        }
    }
    func moveBulletToTarget() {
       
        let a = (self.mouseX - self.player.position.x);
        let b = (self.mouseY - self.player.position.y);
        //Caculating angle between a and b
        let angle = atan2(b, a)
        let angleDegrees = angle * (180 / CGFloat.pi);
        //print("Angle: \(angleDegrees)")
        // turning the bullet to destination direction
        self.playerBullet.zRotation = angle
        
        var destination1 = CGPoint.zero
        if b > 0 {
            // move bullet to the top of screen
            destination1.y = self.size.height + self.enemy.size.height*2
        } else {
            // move bullet to the bottom of screen
            destination1.y = -self.enemy.size.height*2
        }
        // X position of destination in proportion to the the Y Position
        destination1.x = self.player.position.x +
            ((destination1.y - self.player.position.y) / b * a)
        
        var destination2 = CGPoint.zero
        if a > 0 {
            // move the bullet to the right of screen
            destination2.x = self.size.width + self.enemy.size.width*2
        } else {
            //move the bullet to the left of screen
            destination2.x = -self.enemy.size.width*2
        }
        destination2.y = self.player.position.y +
            ((destination2.x - self.player.position.x) / a * b)
        
        var destination:CGPoint!
        //comparing the absolute Coordinate values of destination
        if abs(destination1.x) < abs(destination2.x) || abs(destination1.y) < abs(destination2.y) {
            destination = destination1
        }
        else {
            destination = destination2
        }
        
        // distance were never used
//        let distance = sqrt(pow(destination.x - self.player.position.x, 2) +
//            pow(destination.y - self.player.position.y, 2))
        
        let bulletVector = CGVector(dx: destination.x - self.player.position.x, dy: destination.y - self.player.position.y)
        // Shoot the bullet to destination
        self.playerBullet.physicsBody?.velocity = bulletVector
        //let duration = TimeInterval(distance/2500)
        //let bulletMoveAcion = SKAction.move(to: destination, duration: duration)
        //self.playerBullet.run(bulletMoveAcion)
    }
    
    func randomeenemyBulltsonScreen() {
        //var randDomeBulletsOnScreenArray:[SKSpriteNode] = []
        
        var randomeX:Int!
        var randomeY:Int!
        randomeX = Int.random(in: 200...800)
        randomeY = Int.random(in: 200...800)
        if(self.size.width >= 0 )
        {
//            for i in self.enemyBulletsArray
//            {
//                if(i <= self.enemyBulletsArray)
//                {
//        self.enemyBullet.position.x =  self.enemy.position.x - CGFloat(randomeX)
//        self.enemyBullet.position.y = self.enemy.position.y - CGFloat(randomeY)
//            }
            //            }
        }
        
//        let aX = self.enemy.position.x - self.player.position.x;
//        let bY = self.enemy.position.y - self.player.position.y;
//        //Caculating angle between a and b
//        let angle = atan2(bY, aX)
//        let angleDegrees = angle * (180 / CGFloat.pi);
//        //print("Angle: \(angleDegrees)")
//        // turning the bullet to destination direction
//        self.enemyBullet.zRotation = angle
//
//        var destination1 = CGPoint.zero
//        if bY > 0 {
//            // move bullet to the top of screen
//            destination1.y = -self.size.height + CGFloat(randomeY)
//        } else {
//            // move bullet to the bottom of screen
//            destination1.y = -self.enemy.size.height*2
//        }
//        // X position of destination in proportion to the the Y Position
//        destination1.x = self.enemy.position.x +
//            ((destination1.y - self.enemy.position.y) / bY * aX)
//
//
//        var destination2 = CGPoint.zero
//        if aX > 0 {
//            // move the bullet to the right of screen
//            destination2.x = self.size.width + self.enemy.size.width + CGFloat(randomeX)
//        } else {
//            //move the bullet to the left of screen
//            destination2.x = -self.enemy.size.width*2
//        }
//        destination2.y = self.player.position.y +
//            ((destination2.x - self.player.position.x) / aX * bY)
//
//        var destination:CGPoint!
//        //comparing the absolute Coordinate values of destination
//        if abs(destination1.x) < abs(destination2.x) || abs(destination1.y) < abs(destination2.y) {
//            destination = destination1
//        }
//        else {
//            destination = destination2
//        }
//
//        // distance were never used
//        //        let distance = sqrt(pow(destination.x - self.player.position.x, 2) +
//        //            pow(destination.y - self.player.position.y, 2))
//
//        let bulletVector = CGVector(dx: destination.x - self.player.position.x, dy: destination.y - self.player.position.y)
//        // Shoot the bullet to destination
//        self.playerBullet.physicsBody?.velocity = bulletVector
        
        
       
        
        
    }
    
    
    func bulletHitsEnemy(){
       
            
            self.enumerateChildNodes(withName: "enemy") {
                           (node, stop) in
                self.enemy = node as? SKSpriteNode
                 if self.playerBullet.intersects(self.enemy){
                    self.enemy.removeFromParent()
                    self.removeBullet()
                    print("ememy removed")
                
                       }
            
//            let cropNode = SKCropNode()
//            cropNode.position = CGPoint(x: 100, y: 100)
//            
//            cropNode.maskNode = SKSpriteNode(imageNamed: "enemy")
//
//            var childNode = SKSpriteNode(imageNamed: "child")
//            childNode.position = CGPoint(x: 200, y: 200)
//            childNode.name = "character"
//            cropNode.addChild(childNode)
//            addChild(cropNode)
////            self.enemy.texture?.textureRect().contains(CGRect(x: self.playerBullet.position.x, y: self.playerBullet.position.y, width: self.playerBullet.size.width, height: self.playerBullet.size.height))
//            var pixelRect =  CGRect(x: self.playerBullet.position.x, y: self.playerBullet.position.y, width: self.playerBullet.size.width, height: self.playerBullet.size.height)
//            var delTexture = SKTexture(rect: pixelRect, in: self.enemy.texture!)
//            self.enemy.texture = self.enemy.texture - delTexture
            
//      self.enemy.color = .blue
//        self.enemy.colorBlendFactor = 1.0
        }
    }

    func checkArrowTouched(){
        
        if self.upArrow.contains(touch.location(in: self)) {
            print("up touched")
            self.arrowTouched = "up"
        }
        else if self.downArrow.contains(touch.location(in: self)) {
            print("down touched")
            self.arrowTouched = "down"
        }
        else if self.leftArrow.contains(touch.location(in: self)) {
            print("left touched")
            self.arrowTouched = "left"
        }
        else if self.rightArrow.contains(touch.location(in: self)) {
            print("right touched")
            self.arrowTouched = "right"
        }
        else if self.upRightArrow.contains(touch.location(in: self)) {
            print("UpRight touched")
            self.arrowTouched = "upRight"
        }
        else if self.downRightArrow.contains(touch.location(in: self)) {
            print("downRight touched")
            self.arrowTouched = "downRight"
        }
        else if self.upLeftArrow.contains(touch.location(in: self)) {
            print("upLeft touched")
            self.arrowTouched = "upLeft"
        }
        else if self.downLeftArrow.contains(touch.location(in: self)) {
            print("downLeft touched")
            self.arrowTouched = "downLeft"
        }
    }

    override
    func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view?.isMultipleTouchEnabled = true
        self.touch = touches.first!
        //let touch = touches.first!
        self.mouseX = touch.location(in: self).x
        self.mouseY = touch.location(in: self).y
    
        self.player.size.height = self.player.size.height - self.player.size.height/3
    
        if (self.arrowButtonsRect.contains(touch.location(in: self))){
            self.arrowButtonTouched = true
            self.checkArrowTouched()
        }
        else {
            self.shootBullet = true
            //self.spawnBulletsCallBack()
            
        }
        
        
        guard let mousePosition = touches.first?.location(in: self) else {
            return
        }
        
        print(mousePosition)
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view?.isMultipleTouchEnabled = true
        self.touch = touches.first!
        //let touch = touches.first!
        
        self.mouseX = touch.location(in: self).x
        self.mouseY = touch.location(in: self).y
        
        if (self.arrowButtonsRect.contains(touch.location(in: self))){
            self.arrowButtonTouched = true
            self.checkArrowTouched()
        }
        else{
            self.shootBullet = false
            self.spawnPlayerBullet()
            self.moveBulletToTarget()
        }
        
        //self.callback()
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.arrowTouched = ""
        self.shootBullet = false
        self.arrowButtonTouched = false
        self.shootBullet = false
        self.player.size.height = self.size.height/12
        //self.player.texture = SKTexture(imageNamed: "player")
    }
    
    @objc func callback() {
        self.movePlayer()
        // loop in a non blocking way after 0.1 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            if (self.arrowTouched != "") {
                self.callback()
            }
        }
    }
       @objc func spawnBulletsCallBack(){
            self.spawnPlayerBullet()
        self.moveBulletToTarget()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                if (self.shootBullet == true){
                    self.spawnBulletsCallBack()
                }
            }
    }
    
}

