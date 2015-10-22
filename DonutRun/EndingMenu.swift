//
//  EndingMenu.swift
//  DonutRun
//
//  Created by Mick Lerche on 10/21/15.
//  Copyright © 2015 Grumpy Dane Studios. All rights reserved.
//

import SpriteKit
import Foundation

class EndingMenu: SGScene {

    override func didMoveToView(view: SKView) {
        self.backgroundColor = UIColor(red: 244 / 255, green: 102 / 255, blue: 186 / 255, alpha: 1.0)
        let background = SKSpriteNode(imageNamed: "EndingMenuBackground.png")
        background.posByCanvas(0.5, y: 0.5)
        background.xScale = 1
        background.yScale = 1
        background.zPosition = -1
        addChild(background)

        let playGame = SKLabelNode(fontNamed: "Futura")
        playGame.text = "PLAY AGAIN"
        playGame.posByScreen(0.5, y: 0.3)
        playGame.zPosition = 10
        playGame.name = "play"
        playGame.fontSize = 30
        playGame.fontColor = UIColor(red: 244 / 255, green: 102 / 255, blue: 186 / 255, alpha: 1.0)

        addChild(playGame)

    }

    override func screenInteractionStarted(location: CGPoint) {
        GameManager.sharedInstance.resetForNewGame()
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
