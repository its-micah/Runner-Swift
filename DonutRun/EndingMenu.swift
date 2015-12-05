//
//  EndingMenu.swift
//  DonutRun
//
//  Created by Mick Lerche on 10/21/15.
//  Copyright © 2015 Grumpy Dane Studios. All rights reserved.
//

import SpriteKit
import Foundation

//class EndingMenu: SKScene {
class EndingMenu: SGScene {

    override func didMoveToView(view: SKView) {

        GameManager.sharedInstance.Save()

        let gameScore = SKLabelNode(fontNamed: "Futura")
        gameScore.text = "Score: " + String(GameManager.sharedInstance.gameScore)
        gameScore.posByScreen(0.15, y: 0.9)
        gameScore.zPosition = 10
        gameScore.fontSize = GameConfiguration.sharedInstance.getGameConfigurationCGFloat(String(self.dynamicType), settingName: "fontSize")
        //gameScore.fontColor = UIColor(red: 244 / 255, green: 102 / 255, blue: 186 / 255, alpha: 1.0)
        gameScore.name = "gameScore"
        addChild(gameScore)

        let highScore = SKLabelNode(fontNamed: "Futura")
        highScore.text = "High Score: " + String(GameManager.sharedInstance.highScore)
        highScore.posByScreen(0.2, y: 0.8)
        highScore.zPosition = 10
        highScore.fontSize = GameConfiguration.sharedInstance.getGameConfigurationCGFloat(String(self.dynamicType), settingName: "fontSize")
        //highScore.fontColor = UIColor(red: 244 / 255, green: 102 / 255, blue: 186 / 255, alpha: 1.0)
        highScore.name = "highScore"
        addChild(highScore)

        let playGame = SKLabelNode(fontNamed: "Futura")
        playGame.text = "PLAY AGAIN"
        playGame.posByScreen(0.5, y: 0.3)
        playGame.zPosition = 10
        playGame.name = "play"
        playGame.fontSize = GameConfiguration.sharedInstance.getGameConfigurationCGFloat(String(self.dynamicType), settingName: "fontSize")
        playGame.fontColor = GameConfiguration.sharedInstance.pink
        addChild(playGame)

        self.backgroundColor = UIColor(red: 244 / 255, green: 102 / 255, blue: 186 / 255, alpha: 1.0)
        let background = SKSpriteNode(imageNamed: "EndingMenuBackground.png")
        background.posByCanvas(0.5, y: 0.5)
        background.setScale(GameConfiguration.sharedInstance.getGameConfigurationCGFloat(String(self.dynamicType), settingName: "backgroundScale"))
        background.zPosition = -1
        addChild(background)
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
