//
//  sceneryObject.swift
//  DonutRun
//
//  Created by Micah Lanier on 12/28/15.
//  Copyright © 2015 Micah Lanier. All rights reserved.
//

import Foundation
import SpriteKit

class sceneryObject: LayerBackground {


    var sceneryObject:SKSpriteNode = SKSpriteNode()


    func addSceneryObject() {

        var imageName = ""


        let diceRoll = arc4random_uniform(6)

        if diceRoll == 0 {
            imageName = "trashCan"
        } else if diceRoll == 1 {
            imageName = "trashCan"
        } else if diceRoll == 2 {
            imageName = "trashCan"
        } else if diceRoll == 3 {
            imageName = "trashCan"
        } else if diceRoll == 4 {
            imageName = "trashCan"
        } else if diceRoll == 5 {
            imageName = "trashCan"
        } else if diceRoll == 5 {
            imageName = "trashCan"
        }


        let objectTex:SKTexture = SKTexture(imageNamed: imageName)

        sceneryObject = SKSpriteNode(texture: objectTex, color: SKColor.clearColor(), size: objectTex.size())
        sceneryObject.zPosition = -0.9

        sceneryObject.position = CGPointMake(0, -120)

        
        self.addChild(sceneryObject)
        
        
    }





}