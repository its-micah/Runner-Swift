//
//  BuildingLayer.swift
//  DonutRun
//
//  Created by Micah Lanier on 12/20/15.
//  Copyright © 2015 Micah Lanier. All rights reserved.
//

import Foundation
import SpriteKit

class BuildingLayer: LayerBackground {

    var backgroundBuilding:SKSpriteNode = SKSpriteNode()


    func addBuilding() {

        var imageName = ""


        let diceRoll = arc4random_uniform(6)

        if diceRoll == 0 {
            imageName = "building"
        } else if diceRoll == 1 {
            imageName = "building"
        } else if diceRoll == 2 {
            imageName = "building3"
        } else if diceRoll == 3 {
            imageName = "building2"
        } else if diceRoll == 4 {
            imageName = "building3"
        } else if diceRoll == 5 {
            imageName = "building"
        } else if diceRoll == 5 {
            imageName = "building3"
        }


        let buildingTex:SKTexture = SKTexture(imageNamed: imageName)
        
        backgroundBuilding = SKSpriteNode(texture: buildingTex, color: SKColor.clearColor(), size: buildingTex.size())
        backgroundBuilding.zPosition = -1

        if imageName == "building2" {
            backgroundBuilding.position = CGPointMake(0, 23.0)
        } else if imageName == "building3" {
            backgroundBuilding.position = CGPointMake(0, -80.0)
        } else if imageName == "building" {
            backgroundBuilding.position = CGPointMake(0, -2.5)
        }

        self.addChild(backgroundBuilding)
        
        
    }

}
