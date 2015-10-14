//
//  Donut.swift
//  DonutRun
//
//  Created by Micah Lanier on 8/12/15.
//  Copyright (c) 2015 Micah Lanier. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class Donut: SKSpriteNode {

    var jumpAction:SKAction?
    var runAction:SKAction?
    var doubleJumpAction:SKAction?

    enum DonutState {
        case jumping
        case runnning
        case falling
        case doubleJumping
        case dead
    }

    var donutState:DonutState?


    var isJumping:Bool = false
    var isDoubleJumping:Bool = false
    var isRunning:Bool = false
    var isOnGround:Bool = false
    var isGoingNuts:Bool = false
    var velocity:CGPoint = CGPointMake(0,0)

    var jumpAmount:CGFloat = 0
    var maxJump:CGFloat = 28
    var maxDoubleJump:CGFloat = 33
    var minSpeed:CGFloat = 3.5
    var jumpCount:CGFloat = 0



    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init (imageNamed:String) {

        let imageTexture = SKTexture(imageNamed: imageNamed)



        super.init(texture: imageTexture, color:SKColor.clearColor(), size: imageTexture.size() )  //Swift 2


        //let body:SKPhysicsBody = SKPhysicsBody(circleOfRadius: imageTexture.size().width / 2 )
        //let body:SKPhysicsBody = SKPhysicsBody(texture: imageTexture, size: imageTexture.size())
        let body:SKPhysicsBody = SKPhysicsBody(circleOfRadius: imageTexture.size().height / 2.15)

        body.dynamic = true
        body.affectedByGravity = true
        body.allowsRotation = false
        body.restitution = 0.15
        body.mass = 0.4
        body.categoryBitMask = BodyType.player.rawValue
        body.contactTestBitMask = BodyType.platformObject.rawValue | BodyType.deathObject.rawValue | BodyType.water.rawValue | BodyType.grass.rawValue
        body.collisionBitMask = BodyType.platformObject.rawValue | BodyType.grass.rawValue
        body.friction = 0.9 //0 is like glass, 1 is like sandpaper to walk on
        self.physicsBody = body


        setUpRun()
        setUpJump()
        setUpDoubleJump()

        startRun()


    }

    func update() {


        if isDoubleJumping == true {

            self.position = CGPointMake(self.position.x + minSpeed, self.position.y + jumpAmount)


        } else {

            self.position = CGPointMake(self.position.x + minSpeed, self.position.y + jumpAmount)

        }


    }


    func setUpRun() {

        let atlas = SKTextureAtlas (named: "donutRunTest")

        var array = [String]()

        //or setup an array with exactly the sequential frames start from 1
        for var i=1; i <= 25; i++ {

            let nameString = String(format: "DonutRun_%i", i)
            array.append(nameString)

        }

        //create another array this time with SKTexture as the type (textures being the .png images)
        var atlasTextures:[SKTexture] = []

        for (var i = 0; i < array.count; i++ ) {

            let texture:SKTexture = atlas.textureNamed( array[i] )
            atlasTextures.insert(texture, atIndex:i)

        }

        let atlasAnimation = SKAction.animateWithTextures(atlasTextures, timePerFrame: 1/24, resize: true , restore:false )
        runAction =  SKAction.repeatActionForever(atlasAnimation)



    }


    func setUpJump() {

        let atlas = SKTextureAtlas (named: "DonutJump")

        var array = [String]()

        //or setup an array with exactly the sequential frames start from 1
        for var i=1; i <= 10; i++ {

            let nameString = String(format: "donutJump_%i", i)
            array.append(nameString)

        }

        //create another array this time with SKTexture as the type (textures being the .png images)
        var atlasTextures:[SKTexture] = []

        for (var i = 0; i < array.count; i++ ) {

            let texture:SKTexture = atlas.textureNamed( array[i] )
            atlasTextures.insert(texture, atIndex:i)

        }

        let atlasAnimation = SKAction.animateWithTextures(atlasTextures, timePerFrame: 1.0/30, resize: true , restore:false )
        jumpAction =  SKAction.repeatAction(atlasAnimation, count: 1)



    }

    func setUpDoubleJump() {

        let atlas = SKTextureAtlas (named: "DonutDoubleJump")

        var array = [String]()

        //or setup an array with exactly the sequential frames start from 1
        for var i=1; i <= 14; i++ {

            let nameString = String(format: "DonutDoubleJump_%i", i)
            array.append(nameString)

        }

        //create another array this time with SKTexture as the type (textures being the .png images)
        var atlasTextures:[SKTexture] = []

        for (var i = 0; i < array.count; i++ ) {

            let texture:SKTexture = atlas.textureNamed( array[i] )
            atlasTextures.insert(texture, atIndex:i)

        }

        let atlasAnimation = SKAction.animateWithTextures(atlasTextures, timePerFrame: 1.0/30, resize: true , restore:false )
        doubleJumpAction =  SKAction.repeatAction(atlasAnimation, count: 1)

    }



    func startRun(){
        self.removeActionForKey("jumpKey")
        self.removeActionForKey("doubleJumpKey")
        self.runAction(runAction!, withKey: "runKey")
        isRunning = true
        isJumping = false
        isDoubleJumping = false

    }

    func startJump(){
        self.removeActionForKey("runKey")
        self.runAction(jumpAction!, withKey: "jumpKey")
        isRunning == false
        isDoubleJumping == false
        isJumping == true
    }

    func startDoubleJump(){
        self.removeActionForKey("runKey")
        self.removeActionForKey("jumpKey")
        self.runAction(doubleJumpAction!, withKey: "doubleJumpKey")
        isJumping = false
        isRunning = false
        isDoubleJumping = true
    }



    func jump() {

        // if self.position.y == -183, the donut is on the ground. Anything above that, he's in the air.

        if (donutState == DonutState.jumping && isDoubleJumping == false) {
            changeState(DonutState.doubleJumping)
            isOnGround = false
            jumpAmount = maxDoubleJump
            startDoubleJump()

            self.physicsBody?.velocity = CGVectorMake(0, jumpAmount)


            let callAgain:SKAction = SKAction.runBlock(taperJump)
            let wait:SKAction = SKAction.waitForDuration(1/60)
            let seq:SKAction = SKAction.sequence([wait, callAgain])
            let `repeat` = SKAction.repeatAction(seq, count: 20)
            let stop = SKAction.runBlock(stopDoubleJump)
            let seq2 = SKAction.sequence([`repeat`, stop])
            
            self.runAction(seq2)


        }

        if isJumping == false && isDoubleJumping == false {

            startJump()
            changeState(DonutState.jumping)
            isOnGround = false
            jumpAmount = maxJump

            let callAgain:SKAction = SKAction.runBlock(taperJump)
            let wait:SKAction = SKAction.waitForDuration(1/60)
            let seq:SKAction = SKAction.sequence([wait, callAgain])
            let `repeat` = SKAction.repeatAction(seq, count: 20)
            let stop = SKAction.runBlock(stopJump)
            let seq2 = SKAction.sequence([`repeat`, stop])

            self.runAction(seq2)

        }

    }


    func taperJump() {

        jumpAmount = jumpAmount * 0.9


    }


    func stopJump() {

        isJumping = false
        jumpAmount = 0

        if isDoubleJumping == false {
            changeState(DonutState.runnning)
            startRun()
        }


    }


    func doubleJump() {

        if isJumping == true && isDoubleJumping == false {

            startDoubleJump()
        }

        let wait:SKAction = SKAction.waitForDuration(1)
        let block:SKAction = SKAction.runBlock(stopDoubleJump)
        let seq:SKAction = SKAction.sequence([wait, block])

        self.runAction(seq)

    }



    func stopDoubleJump() {
        
        changeState(DonutState.falling)
        if isOnGround == true {
            self.startRun()
            changeState(DonutState.runnning)
        } 
    }


    func changeState(newState:DonutState) {
        if (newState == self.donutState) {
            return
        }
        self.donutState = newState;
        //print("Character changeState = \(self.donutState)")
    }

    func goNuts() {

        self.physicsBody!.contactTestBitMask = BodyType.platformObject.rawValue | BodyType.grass.rawValue
        
        let wait = SKAction.waitForDuration(5)
        self.runAction(wait) { () -> Void in
            self.physicsBody!.contactTestBitMask = BodyType.platformObject.rawValue | BodyType.deathObject.rawValue | BodyType.water.rawValue | BodyType.grass.rawValue
            self.color = UIColor.clearColor()
            self.colorBlendFactor = 0;
        }
    }





}



