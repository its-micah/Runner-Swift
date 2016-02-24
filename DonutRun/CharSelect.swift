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

        InAppManager.sharedManager()
        //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(unlockProduct1) name:@"feature1Purchased" object:nil];
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "refreshDonuts",
            name: "feature1Purchased",
            object: nil)




        let charSelect = SKLabelNode(fontNamed: labelFont)
        charSelect.text = "SELECT A DONUT"
        charSelect.posByScreen(0.5, y: 0.8)
        charSelect.setScale(GameConfiguration.sharedInstance.getGameConfigurationCGFloat(String(self.dynamicType), settingName: "fontScale"))
        charSelect.zPosition = 10
        charSelect.name = "Select a Donut"
        addChild(charSelect)

        let player1 = SKLabelNode(fontNamed: labelFont)
        player1.text = "Sprinkle"
        player1.posByScreen(0.2, y: 0.2)
        player1.zPosition = 10
        player1.setScale(GameConfiguration.sharedInstance.getGameConfigurationCGFloat(String(self.dynamicType), settingName: "fontScale"))
        player1.name = "player1"
        addChild(player1)

        let player2 = SKLabelNode(fontNamed: labelFont)
        player2.text = "Dinkle"
        player2.posByScreen(0.5, y: 0.2)
        player2.setScale(GameConfiguration.sharedInstance.getGameConfigurationCGFloat(String(self.dynamicType), settingName: "fontScale"))
        player2.zPosition = 10
        player2.name = "player2"
        addChild(player2)

        let player3 = SKLabelNode(fontNamed: labelFont)
        player3.text = "Jeff"
        player3.posByScreen(0.8, y: 0.2)
        player3.setScale(GameConfiguration.sharedInstance.getGameConfigurationCGFloat(String(self.dynamicType), settingName: "fontScale"))
        player3.zPosition = 10
        player3.name = "player3"
        addChild(player3)

        let donutOne: Donut = Donut(imageNamed: "DonutIdle_1")
        donutOne.posByScreen(0.2, y: 0.5)
        donutOne.setScale(GameConfiguration.sharedInstance.getGameConfigurationCGFloat(String(self.dynamicType), settingName: "playerScale"))
        donutOne.physicsBody?.affectedByGravity = false
        donutOne.physicsBody?.dynamic = false
        donutOne.name = "donutOne"
        addChild(donutOne)

        let donutTwo: Donut = Donut(imageNamed: "DonutTwoIdle_5")
        donutTwo.posByScreen(0.5, y: 0.5)
        donutTwo.setScale(GameConfiguration.sharedInstance.getGameConfigurationCGFloat(String(self.dynamicType), settingName: "playerScale"))
        donutTwo.physicsBody?.affectedByGravity = false
        donutTwo.physicsBody?.dynamic = false
        donutTwo.name = "donutTwo"
        addChild(donutTwo)

        let donutThree: Donut = Donut(imageNamed: "DonutTwoIdle_5")
        donutThree.posByScreen(0.8, y: 0.5)
        donutThree.setScale(GameConfiguration.sharedInstance.getGameConfigurationCGFloat(String(self.dynamicType), settingName: "playerScale"))
        donutThree.physicsBody?.affectedByGravity = false
        donutThree.physicsBody?.dynamic = false
        donutThree.name = "donutThree"
        addChild(donutThree)

        donutOne.startIdle()
        donutTwo.startIdleTwo()
        donutThree.startIdleTwo()


        if !GameManager.sharedInstance.extraDonutsPurchased {
            let purchase1 = SKLabelNode(fontNamed: labelFont)
            purchase1.text = "Purchase Dinkle & Jeff"
            purchase1.posByScreen(0.64, y: 0.1)
            purchase1.setScale(GameConfiguration.sharedInstance.getGameConfigurationCGFloat(String(self.dynamicType), settingName: "fontScale"))
            purchase1.zPosition = 10
            purchase1.name = "purchase1"
            addChild(purchase1)

            let refresh = SKLabelNode(fontNamed: labelFont)
            refresh.fontSize = 9
            refresh.text = "Refresh Purchase"
            refresh.posByScreen(0.9, y: 0.05)
            refresh.setScale(GameConfiguration.sharedInstance.getGameConfigurationCGFloat(String(self.dynamicType), settingName: "fontScale"))
            refresh.zPosition = 10
            refresh.name = "refresh"
            addChild(refresh)

            donutTwo.alpha = 0.5
            donutThree.alpha = 0.5

        }

        //        let purchase2 = SKLabelNode(fontNamed: labelFont)
        //        purchase2.text = "Purchase"
        //        purchase2.posByScreen(0.8, y: 0.1)
        //        purchase2.setScale(GameConfiguration.sharedInstance.getGameConfigurationCGFloat(String(self.dynamicType), settingName: "fontScale"))
        //        purchase2.zPosition = 10
        //        purchase2.name = "purchase2"
        //        addChild(purchase2)



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
                if (theNode.name == "donutOne" ||
                    ((theNode.name == "donutTwo" || theNode.name == "donutThree") && GameManager.sharedInstance.extraDonutsPurchased)) {

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

            if node.name == "purchase1" {
                InAppManager.sharedManager().buyFeature1();
            }
        }

    }

    func refreshDonuts() {
        if (GameManager.sharedInstance.extraDonutsPurchased || InAppManager.sharedManager().isFeature1PurchasedAlready()) {
            GameManager.sharedInstance.extraDonutsPurchased = true
            self.childNodeWithName("purchase1")?.removeFromParent()
            self.childNodeWithName("donutTwo")?.alpha = 1
            self.childNodeWithName("donutThree")?.alpha = 1
        }
    }
    
}