//
//  TreeLayer.swift
//  DonutRun
//
//  Created by Micah Lanier on 12/20/15.
//  Copyright © 2015 Micah Lanier. All rights reserved.
//

import Foundation
import SpriteKit

class TreeLayer: LayerBackground {

    var backgroundTree:SKSpriteNode = SKSpriteNode()


    func addTree() {

        var imageName = ""

        
        let diceRoll = arc4random_uniform(6)

        if diceRoll == 0 {
            imageName = "tree"
        } else if diceRoll == 1 {
            imageName = "tree"
        } else if diceRoll == 2 {
            imageName = "tree"
        } else if diceRoll == 3 {
            imageName = "tree"
        } else if diceRoll == 4 {
            imageName = "tree"
        } else if diceRoll == 5 {
            imageName = "tree"
        } else if diceRoll == 5 {
            imageName = "tree"
        }


        let tex:SKTexture = SKTexture(imageNamed: imageName)
        backgroundTree = SKSpriteNode(texture: tex, color: SKColor.clearColor(), size: tex.size())
        backgroundTree.zPosition = -1
        backgroundTree.position = CGPointMake(0, -45.5)
        self.addChild(backgroundTree)


    }

}