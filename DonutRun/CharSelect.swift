//
//  CharSelect.swift
//  DonutRun
//
//  Created by Micah Lanier on 10/15/15.
//  Copyright © 2015 Micah Lanier. All rights reserved.
//

import Foundation
import SpriteKit

class CharSelect: SGScene {

    override func didMoveToView(view: SKView) {

        self.backgroundColor = UIColor(red: 132/255, green: 202/255, blue: 255/255, alpha: 1.0)

        let charSelect = SKLabelNode(fontNamed: "Futura")
        charSelect.text = "Select a Donut"
        charSelect.posByScreen(0.5, y: 0.8)
        charSelect.zPosition = 10
        charSelect.name = "Select a Donut"
        addChild(charSelect)

        let player1 = SKLabelNode(fontNamed: "Futura")
        player1.text = "player1"
        player1.posByScreen(0.2, y: 0.3)
        player1.zPosition = 10
        player1.name = "player1"
        addChild(player1)

        let player2 = SKLabelNode(fontNamed: "Futura")
        player2.text = "player2"
        player2.posByScreen(0.5, y: 0.3)
        player2.zPosition = 10
        player2.name = "player2"
        addChild(player2)

        let player3 = SKLabelNode(fontNamed: "Futura")
        player3.text = "player3"
        player3.posByScreen(0.8, y: 0.3)
        player3.zPosition = 10
        player3.name = "player3"
        addChild(player3)



    }

    override func screenInteractionStarted(location: CGPoint) {

        for node in nodesAtPoint(location) {
            if node.isKindOfClass(SKNode) {
                let theNode = node
                if ((theNode.name?.containsString("player")) != nil) {
                    print("play game")
                    let gameScene = GameScene(size: scene!.size)
                    gameScene.scaleMode = scaleMode
                    let transition = SKTransition.fadeWithDuration(0.5)
                    view?.presentScene(gameScene, transition: transition)


                }
            }
        }

    }



}