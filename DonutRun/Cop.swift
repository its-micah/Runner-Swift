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


        self.setScale(GameConfiguration.sharedInstance.getGameConfigurationCGFloat(String(self.dynamicType), settingName: "killObjectScale"))

        setUpRun()
        startRun()



    }

    func setUpRun() {
        let textureAtlasArray = SKTexture.createAtlas("Cop2", numberOfImages: 16)
        let atlasAnimation = SKAction.animateWithTextures(textureAtlasArray, timePerFrame: 1/30, resize: true , restore:false )
        runAction =  SKAction.repeatActionForever(atlasAnimation)
    }

    func startRun(){

        self.runAction(runAction!, withKey: "runKey")
        
    }

    func update() {
        self.position = CGPointMake(self.position.x - minSpeed, self.position.y)
    }




}