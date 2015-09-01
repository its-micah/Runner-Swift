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


    var isJumping:Bool = false
    var isDoubleJumping:Bool = false
    var isRunning:Bool = false

    var jumpAmount:CGFloat = 0
    var maxJump:CGFloat = 31
    var minSpeed:CGFloat = 2.5



    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init (imageNamed:String) {

        let imageTexture = SKTexture(imageNamed: imageNamed)



        super.init(texture: imageTexture, color:SKColor.clearColor(), size: imageTexture.size() )  //Swift 2





        let body:SKPhysicsBody = SKPhysicsBody(circleOfRadius: imageTexture.size().height / 2.15)

        body.dynamic = true
        body.affectedByGravity = true
        body.allowsRotation = false
        body.restitution = 0.15
        //body.categoryBitMask = BodyType.deathObject.rawValue
        body.contactTestBitMask = BodyType.platformObject.rawValue | BodyType.player.rawValue | BodyType.water.rawValue | BodyType.grass.rawValue
        body.collisionBitMask = BodyType.platformObject.rawValue | BodyType.grass.rawValue
        body.friction = 0.9 //0 is like glass, 1 is like sandpaper to walk on
        self.physicsBody = body


        setUpRun()
        setUpJump()
        setUpGlide()

        startRun()


    }

    func update() {

        if isDoubleJumping == true {

            self.position = CGPointMake(self.position.x + minSpeed, self.position.y - 0.4)


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

        let atlas = SKTextureAtlas (named: "Ogre")

        var array = [String]()

        //or setup an array with exactly the sequential frames start from 1
        for var i=1; i <= 9; i++ {

            let nameString = String(format: "ogre_jump%i", i)
            array.append(nameString)

        }

        //create another array this time with SKTexture as the type (textures being the .png images)
        var atlasTextures:[SKTexture] = []

        for (var i = 0; i < array.count; i++ ) {

            let texture:SKTexture = atlas.textureNamed( array[i] )
            atlasTextures.insert(texture, atIndex:i)

        }

        let atlasAnimation = SKAction.animateWithTextures(atlasTextures, timePerFrame: 1.0/20, resize: true , restore:false )
        jumpAction =  SKAction.repeatActionForever(atlasAnimation)



    }

    func setUpGlide() {

        let atlas = SKTextureAtlas (named: "Ogre")

        var array = [String]()

        //or setup an array with exactly the sequential frames start from 1
        for var i=1; i <= 4; i++ {

            let nameString = String(format: "ogre_slide%i", i)
            array.append(nameString)

        }

        //create another array this time with SKTexture as the type (textures being the .png images)
        var atlasTextures:[SKTexture] = []

        for (var i = 0; i < array.count; i++ ) {

            let texture:SKTexture = atlas.textureNamed( array[i] )
            atlasTextures.insert(texture, atIndex:i)

        }

        let atlasAnimation = SKAction.animateWithTextures(atlasTextures, timePerFrame: 1.0/20, resize: true , restore:false )
        doubleJumpAction =  SKAction.repeatActionForever(atlasAnimation)



    }





    func startRun(){

        self.runAction(runAction!, withKey: "runKey")

    }

    func startJump(){

        self.runAction(jumpAction!, withKey: "jumpKey")
        isRunning == false
        isDoubleJumping == false
        isJumping == true
    }


    func jump() {

        if isJumping == false && isDoubleJumping == false {

            startJump()

            jumpAmount = maxJump

            let callAgain:SKAction = SKAction.runBlock(taperJump)
            let wait:SKAction = SKAction.waitForDuration(1/60)
            let seq:SKAction = SKAction.sequence([wait, callAgain])
            let repeat = SKAction.repeatAction(seq, count: 20)
            let stop = SKAction.runBlock(stopJump)
            let seq2 = SKAction.sequence([repeat, stop])

            self.runAction(seq2)

        }

        if isJumping == true && isDoubleJumping == false {
            

            startJump()

            jumpAmount = maxJump

            let callAgain:SKAction = SKAction.runBlock(taperJump)
            let wait:SKAction = SKAction.waitForDuration(1/60)
            let seq:SKAction = SKAction.sequence([wait, callAgain])
            let repeat = SKAction.repeatAction(seq, count: 20)
            let stop = SKAction.runBlock(stopJump)
            let seq2 = SKAction.sequence([repeat, stop])

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

            startRun()
        }


    }

    
    func startGlide(){

        self.runAction(doubleJumpAction!)
        
    }


    func glide() {

        if isJumping == true {

            startGlide()
        }


    }



    func stopGlide() {

        self.startRun()

    }




}



