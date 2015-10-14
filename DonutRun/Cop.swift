//
//  Cop.swift
//  DonutRun
//
//  Created by Micah Lanier on 8/28/15.
//  Copyright (c) 2015 Micah Lanier. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class Cop: SKSpriteNode {

    var runAction:SKAction?

    var minSpeed:CGFloat = 2.5


    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init (imageNamed:String) {

        let imageTexture = SKTexture(imageNamed: imageNamed)



        super.init(texture: imageTexture, color:SKColor.clearColor(), size: imageTexture.size() )  //Swift 2






        let body:SKPhysicsBody = SKPhysicsBody(circleOfRadius: imageTexture.size().height / 2.6)

        body.dynamic = true
        body.affectedByGravity = true
        body.allowsRotation = false
        body.restitution = 0
        body.categoryBitMask = BodyType.deathObject.rawValue
        body.contactTestBitMask = BodyType.platformObject.rawValue | BodyType.deathObject.rawValue | BodyType.water.rawValue | BodyType.grass.rawValue
        body.collisionBitMask = BodyType.platformObject.rawValue | BodyType.grass.rawValue
//        body.friction = 0.9 //0 is like glass, 1 is like sandpaper to walk on
        self.physicsBody = body

        setUpRun()
        startRun()



    }

    func setUpRun() {

        let atlas = SKTextureAtlas (named: "Cop2")

        var array = [String]()

        //or setup an array with exactly the sequential frames start from 1
        for var i=1; i <= 16; i++ {

            let nameString = String(format: "Cop2_%i", i)
            array.append(nameString)

        }

        //create another array this time with SKTexture as the type (textures being the .png images)
        var atlasTextures:[SKTexture] = []

        for (var i = 0; i < array.count; i++ ) {

            let texture:SKTexture = atlas.textureNamed( array[i] )
            atlasTextures.insert(texture, atIndex:i)

        }

        let atlasAnimation = SKAction.animateWithTextures(atlasTextures, timePerFrame: 1/30, resize: true , restore:false )
        runAction =  SKAction.repeatActionForever(atlasAnimation)
        
        
        
    }

    func startRun(){

        self.runAction(runAction!, withKey: "runKey")
        
    }

    func update() {


        self.position = CGPointMake(self.position.x - minSpeed, self.position.y)

        
        
    }





}