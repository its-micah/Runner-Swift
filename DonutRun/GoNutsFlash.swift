//
//  GoNutsFlash.swift
//  DonutRun
//
//  Created by Micah Lanier on 10/14/15.
//  Copyright © 2015 Micah Lanier. All rights reserved.
//

import Foundation
import SpriteKit


class GoNutsFlash: SKSpriteNode {

    var runAction:SKAction?

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init (imageNamed:String) {

        let imageTexture = SKTexture(imageNamed: imageNamed)

        super.init(texture: imageTexture, color:SKColor.clearColor(), size: imageTexture.size() )  //Swift 2

        //let body:SKPhysicsBody = SKPhysicsBody(circleOfRadius: imageTexture.size().width / 2 )
        //let body:SKPhysicsBody = SKPhysicsBody(texture: imageTexture, size: imageTexture.size())

        setUpRun()
        startRun()

    }

    func setUpRun() {
        let textureAtlasArray = SKTexture.createAtlas("GoNutsFlash", numberOfImages: 10)
        let atlasAnimation = SKAction.animateWithTextures(textureAtlasArray, timePerFrame: 1/24, resize: true , restore:false )
        runAction =  SKAction.repeatAction(atlasAnimation, count: 1)
    }

//    func setUpRun() {
//
//        let atlas = SKTextureAtlas (named: "goNutsFlash")
//
//        var array = [String]()
//
//        //or setup an array with exactly the sequential frames start from 1
//        for var i=1; i <= 14; i++ {
//
//            let nameString = String(format: "goNutsFlash_%i", i)
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
//        runAction =  SKAction.repeatAction(atlasAnimation, count: 1)
//
//    }


    func startRun() {
        
        self.runAction(runAction!)
        
    }
    
    
    func update() {
        

        
    }
    
}