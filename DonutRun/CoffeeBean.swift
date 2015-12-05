//
//  CoffeeBean.swift
//  DonutRun
//
//  Created by Micah Lanier on 9/20/15.
//  Copyright (c) 2015 Micah Lanier. All rights reserved.
//

import Foundation
import SpriteKit


class CoffeeBean: SKSpriteNode {

    var runAction:SKAction?

    var minSpeed:CGFloat = 2.5

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init (imageNamed:String) {

        let imageTexture = SKTexture(imageNamed: imageNamed)

        super.init(texture: imageTexture, color:SKColor.clearColor(), size: imageTexture.size() )  //Swift 2

        //let body:SKPhysicsBody = SKPhysicsBody(circleOfRadius: imageTexture.size().width / 2 )
        //let body:SKPhysicsBody = SKPhysicsBody(texture: imageTexture, size: imageTexture.size())
        let body:SKPhysicsBody = SKPhysicsBody(circleOfRadius: imageTexture.size().height / 2.15)

        body.dynamic = false
        body.affectedByGravity = false
        body.allowsRotation = false
        body.mass = 0
        body.categoryBitMask = BodyType.coffeeBeanObject.rawValue
        body.contactTestBitMask = BodyType.player.rawValue
        body.collisionBitMask = BodyType.player.rawValue
        body.friction = 0 //0 is like glass, 1 is like sandpaper to walk on
        self.physicsBody = body

        setUpRun()
        startRun()

    }

    func setUpRun() {
        let textureAtlasArray = SKTexture.createAtlas("Coin", numberOfImages: 24)
        let atlasAnimation = SKAction.animateWithTextures(textureAtlasArray, timePerFrame: 1/24, resize: true , restore:false )
        runAction =  SKAction.repeatActionForever(atlasAnimation)
    }

//    func setUpRun() {
//
//        let atlas = SKTextureAtlas (named: "CoffeeBean")
//
//        var array = [String]()
//
//        //or setup an array with exactly the sequential frames start from 1
//        for var i=1; i <= 25; i++ {
//
//            let nameString = String(format: "CoffeeBean_%i", i)
//            array.append(nameString)
//
//        }
//
//        //create another array this time with SKTexture as the type (textures being the .png images)
//        var atlasTextures:[SKTexture] = []
//
//        for (var i = 0; i < array.count; i++ ) {
//
//            let texture:SKTexture = atlas.textureNamed( array[i] )
//            atlasTextures.insert(texture, atIndex:i)
//
//        }
//
//        let atlasAnimation = SKAction.animateWithTextures(atlasTextures, timePerFrame: 1/24, resize: true , restore:false )
//        runAction =  SKAction.repeatActionForever(atlasAnimation)
//
//    }


    func startRun() {

        self.runAction(runAction!)

    }


    func update() {

        self.position = CGPointMake(self.position.x - minSpeed, self.position.y)

    }

}