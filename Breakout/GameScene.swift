//
//  GameScene.swift
//  Breakout
//
//  Created by Avery Zakson on 3/9/20.
//  Copyright © 2020 mojo. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var ball = SKShapeNode()
    var paddle = SKSpriteNode()
    var brick = SKSpriteNode()
    var loseZone = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        createBackground()
        makeBall()
        makePaddle()
        makeBrick()
        makeLoseZone()
    }
    
    func createBackground() {
        let stars = SKTexture(imageNamed: "Stars")
        for i in 0...1 { 
            let starsBackground = SKSpriteNode(texture: stars)
            starsBackground.zPosition = -1
            starsBackground.position = CGPoint(x: 0, y: starsBackground.size.height * CGFloat(i))
            addChild(starsBackground)
            let moveDown = SKAction.moveBy(x: 0, y: -starsBackground.size.height, duration: 20)
            let moveReset = SKAction.moveBy(x: 0, y: starsBackground.size.height, duration: 0)
            let moveLoop = SKAction.sequence([moveDown, moveReset])
            let moveForever = SKAction.repeatForever(moveLoop)
            starsBackground.run(moveForever)
        }
    }
    
    func makeBall() {
        ball = SKShapeNode(circleOfRadius: 10)
        ball.position = CGPoint(x: frame.midX, y: frame.midY)
        ball.strokeColor = .black
        ball.fillColor = .yellow
        ball.name = "ball"
        //Physics shape matches ball image
        ball.physicsBody = SKPhysicsBody(circleOfRadius: 10)
        //Ignores all forces and impulses
        ball.physicsBody?.isDynamic = false
        //Use precise collision detection
        ball.physicsBody?.usesPreciseCollisionDetection = true
        //No loss off energy from friction
        ball.physicsBody?.friction = 0
        //Gravity is not a factor
        ball.physicsBody?.affectedByGravity = false
        //Bounces fully off of other objects
        ball.physicsBody?.restitution = 1
        //Does not slow down over time
        ball.physicsBody?.linearDamping = 0
        ball.physicsBody?.contactTestBitMask = (ball.physicsBody?.collisionBitMask)!
        //Add ball object to the view
        addChild(ball)
    }
    
    func makePaddle() {
        paddle = SKSpriteNode(color: .white, size: CGSize(width: frame.width/4, height: 20))
        paddle.position = CGPoint(x: frame.midX, y:frame.minY + 125)
        paddle.name = "paddle"
        paddle.physicsBody = SKPhysicsBody(rectangleOf: paddle.size)
        paddle.physicsBody?.isDynamic = false
        addChild(paddle)
    }
    
    func makeBrick() {
        brick = SKSpriteNode(color: .blue, size: CGSize(width: 50, height: 20))
        brick.position = CGPoint(x: frame.midX, y: frame.maxY - 50)
        brick.name = "brick"
        brick.physicsBody = SKPhysicsBody(rectangleOf: brick.size)
        brick.physicsBody?.isDynamic = false
        addChild(brick)
    }
    
    func makeLoseZone() {
       loseZone = SKSpriteNode(color: .red, size: CGSize(width: frame.width, height: 50))
       loseZone.position = CGPoint(x: frame.midX, y: frame.minY + 25)
       loseZone.name = "loseZone"
       loseZone.physicsBody = SKPhysicsBody(rectangleOf: loseZone.size)
       loseZone.physicsBody?.isDynamic = false
       addChild(loseZone)
    }
}
