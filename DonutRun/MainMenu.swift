//
//  MainMenu.swift
//  DonutRun
//
//  Created by Micah Lanier on 8/18/15.
//  Copyright (c) 2015 Micah Lanier. All rights reserved.
//

import SpriteKit
import Foundation

class MainMenu: SGScene {

    override func didMoveToView(view: SKView) {
        self.backgroundColor = UIColor(red: 244 / 255, green: 102 / 255, blue: 186 / 255, alpha: 1.0)
        //let background = SKSpriteNode(imageNamed: "background4")
        let background = SKSpriteNode()
        //background.posByCanvas(0.5, y: 0.5)
        background.xScale = 1.1
        // background.color = SKColorWithRGBA(244, 102, 186, 1)
        background.yScale = 1.1
        background.zPosition = -1
        addChild(background)


        let playGame = SKLabelNode(fontNamed: "Futura")
        playGame.text = "PLAY"
        playGame.posByScreen(0.5, y: 0.3)
        playGame.zPosition = 10
        playGame.name = "play"
        addChild(playGame)

    }

    override func screenInteractionStarted(location: CGPoint) {
        for node in nodesAtPoint(location) {
            if node.isKindOfClass(SKNode) {
                let theNode = node 
                if theNode.name == "play" {
                    print("play game")
                    let gameScene = GameScene(size: scene!.size)
                    gameScene.scaleMode = scaleMode
                    let transition = SKTransition.fadeWithDuration(0.3)
                    view?.presentScene(gameScene, transition: transition)


                }
            }
        }
    }





}
