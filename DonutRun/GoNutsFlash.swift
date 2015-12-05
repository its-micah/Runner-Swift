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

    func startRun() {
        self.runAction(runAction!)
    }
    
    
    func update() {
    
    }
    
}