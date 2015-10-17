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

        let charSelect = SKLabelNode(fontNamed: "Gotham Rounded Medium")
        charSelect.text = "SELECT A DONUT"
        charSelect.posByScreen(0.5, y: 0.8)
        charSelect.zPosition = 10
        charSelect.name = "Select a Donut"
        addChild(charSelect)

        let player1 = SKLabelNode(fontNamed: "Gotham Rounded Medium")
        player1.text = "Sprinkle"
        player1.posByScreen(0.2, y: 0.2)
        player1.zPosition = 10
        player1.name = "player1"
        addChild(player1)

        let player2 = SKLabelNode(fontNamed: "Gotham Rounded Medium")
        player2.text = "Dinkle"
        player2.posByScreen(0.5, y: 0.2)
        player2.zPosition = 10
        player2.name = "player2"
        addChild(player2)

        let player3 = SKLabelNode(fontNamed: "Gotham Rounded Medium")
        player3.text = "Jeff"
        player3.posByScreen(0.8, y: 0.2)
        player3.zPosition = 10
        player3.name = "player3"
        addChild(player3)

        let donutOne: Donut = Donut(imageNamed: "DonutIdle_1")
        donutOne.posByScreen(0.2, y: 0.5)
        donutOne.physicsBody?.affectedByGravity = false
        donutOne.physicsBody?.dynamic = false
        donutOne.name = "donutOne"
        addChild(donutOne)

        donutOne.startIdle()

    }

    override func screenInteractionStarted(location: CGPoint) {

        for node in nodesAtPoint(location) {
            if node.isKindOfClass(Donut) {
                let theNode = node
                if ((theNode.name?.containsString("player")) != nil) {
                    self.runAction(SKAction.playSoundFileNamed("Wood_Done3.wav", waitForCompletion: true))
                    let gameScene = GameScene(size: scene!.size)
                    gameScene.scaleMode = scaleMode
                    let transition = SKTransition.fadeWithDuration(1.0)
                    view?.presentScene(gameScene, transition: transition)
                }
            }
        }

    }



}