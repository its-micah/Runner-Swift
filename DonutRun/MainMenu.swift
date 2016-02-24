//
//  MainMenu.swift
//  DonutRun
//
//  Created by Micah Lanier on 8/18/15.
//  Copyright (c) 2015 Micah Lanier. All rights reserved.
//

import SpriteKit
import Foundation

//class MainMenu: SGScene {
class MainMenu: SGScene {
    var focusedNode:SKSpriteNode?

    let tapGeneralSelection = UITapGestureRecognizer()

    
    override func didMoveToView(view: SKView) {

        SKTAudio.sharedInstance().playBackgroundMusic("preview (1).mp3")

        self.backgroundColor = UIColor(red: 244 / 255, green: 102 / 255, blue: 186 / 255, alpha: 1.0)
        //let background = SKSpriteNode(imageNamed: "background4")
        let background = SKSpriteNode()
        //background.posByCanvas(0.5, y: 0.5)
        // background.color = SKColorWithRGBA(244, 102, 186, 1)

        //background.xScale = 1.1
        //background.yScale = 1.1


        background.zPosition = -1
        addChild(background)


        let highScore = SKLabelNode(fontNamed: "Gotham Rounded Medium")
        highScore.text = "High Score: " + String(GameManager.sharedInstance.highScore)
        //highScore.posByScreen(0.2, y: 0.9)
        highScore.posBySetting(self.dynamicType, settingName: "highScorePosition")
        highScore.setScale(GameConfiguration.sharedInstance.getGameConfigurationCGFloat(String(self.dynamicType), settingName: "fontScale"))

        highScore.zPosition = 10
        highScore.name = "highScore"
        addChild(highScore)


        let playGame = SKLabelNode(fontNamed: "Gotham Rounded Medium")
        playGame.text = "PLAY"
        //playGame.posByScreen(0.5, y: 0.3)
        playGame.posBySetting(self.dynamicType, settingName: "playGamePosition")
        playGame.setScale(GameConfiguration.sharedInstance.getGameConfigurationCGFloat(String(self.dynamicType), settingName: "fontScale"))
        playGame.zPosition = 10
        playGame.name = "play"
        addChild(playGame)


        #if os(tvOS)
//        tapPlayPause.addTarget(self, action:"tappedPlayPause")
//        tapPlayPause.allowedPressTypes = [NSNumber(integer: UIPressType.PlayPause.rawValue)]
//        self.view!.addGestureRecognizer(tapPlayPause)
//
//        tapDown.addTarget(self, action:"tappedDown")
//        tapDown.allowedPressTypes = [NSNumber(integer: UIPressType.DownArrow.rawValue)]
//        self.view!.addGestureRecognizer(tapDown)

        tapGeneralSelection.addTarget(self, action:"tappedGeneralSelection:")
        tapGeneralSelection.allowedPressTypes = [NSNumber(integer: UIPressType.Select.rawValue)]

        self.view!.addGestureRecognizer(tapGeneralSelection)
        #endif
    }

    override func screenInteractionStarted(location: CGPoint) {
        for node in nodesAtPoint(location) {
            if node.isKindOfClass(SKNode) {
                let theNode = node 
                if theNode.name == "play" {
                    print("play game")
                    let gameScene = CharSelect(size: scene!.size)
                    gameScene.scaleMode = scaleMode
                    let transition = SKTransition.fadeWithDuration(0.3)
                    view?.presentScene(gameScene, transition: transition)


                }
            }
        }
    }

    func tappedGeneralSelection(sender:UITapGestureRecognizer) {
        // this seems to just be a "click" on the touch pad

        print("play game")
        let gameScene = CharSelect(size: scene!.size)
        gameScene.scaleMode = scaleMode
        let transition = SKTransition.fadeWithDuration(0.3)
        view?.presentScene(gameScene, transition: transition)

    }
}
