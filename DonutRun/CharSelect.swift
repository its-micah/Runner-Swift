//
//  CharSelect.swift
//  DonutRun
//
//  Created by Micah Lanier on 10/15/15.
//  Copyright © 2015 Micah Lanier. All rights reserved.
//

import Foundation
import SpriteKit

let labelFont = "Gotham Rounded Medium"

class CharSelect: SGScene {

    override func didMoveToView(view: SKView) {

        setNeedsFocusUpdate()
        updateFocusIfNeeded()
        self.backgroundColor = UIColor(red: 132/255, green: 202/255, blue: 255/255, alpha: 1.0)

        let charSelect = SKLabelNode(fontNamed: labelFont)
        charSelect.text = "SELECT A DONUT"
        charSelect.posByScreen(0.5, y: 0.8)
        charSelect.zPosition = 10
        charSelect.name = "Select a Donut"
        addChild(charSelect)

        let player1 = SKLabelNode(fontNamed: labelFont)
        player1.text = "Sprinkle"
        player1.posByScreen(0.2, y: 0.2)
        player1.zPosition = 10
        player1.name = "player1"
        addChild(player1)

        let player2 = SKLabelNode(fontNamed: labelFont)
        player2.text = "Dinkle"
        player2.posByScreen(0.5, y: 0.2)
        player2.zPosition = 10
        player2.name = "player2"
        addChild(player2)

        let player3 = SKLabelNode(fontNamed: labelFont)
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

        let donutTwo: Donut = Donut(imageNamed: "DonutTwoIdle_5")
        donutTwo.posByScreen(0.5, y: 0.5)
        donutTwo.physicsBody?.affectedByGravity = false
        donutTwo.physicsBody?.dynamic = false
        donutTwo.name = "donutTwo"
        addChild(donutTwo)

        donutOne.startIdle()
        donutTwo.startIdleTwo()

    }

    func setNeedsFocusUpdate() {

    }

    func updateFocusIfNeeded() {
        print("")
    }

    @available(iOS 9.0, *)
    func shouldUpdateFocusInContext(context: UIFocusUpdateContext) -> Bool {
        return true
    }

    @available(iOS 9.0, *)
    func didUpdateFocusInContext(context: UIFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
        print("")

    }



    override func screenInteractionStarted(location: CGPoint) {

        for node in nodesAtPoint(location) {
            if node.isKindOfClass(Donut) {
                let theNode = node
                if ((theNode.name?.containsString("donut")) != nil) {
                    self.runAction(SKAction.playSoundFileNamed("Wood_Done3.wav", waitForCompletion: true))
                    let gameScene = GameScene(size: scene!.size)

                    if theNode.name == "donutOne" {
                        gameScene.selectedDonut = 1
                    } else if theNode.name == "donutTwo" {
                        gameScene.selectedDonut = 2
                    }   else if theNode.name == "donutThree" {
                        gameScene.selectedDonut = 3
                    }

                    gameScene.scaleMode = scaleMode
                    let transition = SKTransition.fadeWithDuration(1.0)
                    view?.presentScene(gameScene, transition: transition)
                }
            }
        }

    }



}