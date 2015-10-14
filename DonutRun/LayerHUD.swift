//
//  LayerHUD.swift
//  Generic Game HUD Layer
//
//  Created by Mick Lerche on 9/3/15.
//  Copyright (c) 2015 Grumpy Dane Studios. All rights reserved.
//

import SpriteKit

class LayerHUD: SKNode {


    var pauseButton:SKLabelNode!

    var screenSize2: CGRect!
    var xUpperLeft: Float!
    var yUpperLeft: Float!

    var beanCount: Int = 0



    override init() {
        super.init()

        // set these with screen
        screenSize2 = UIScreen.mainScreen().bounds
        xUpperLeft = -450.0
        yUpperLeft = -250.0

        addPause()

        addBeans()
        addScoreImage()

        addScore()


        setupScoreboard()

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    func addScore () {
        var scoreLabel: SKLabelNode!
        scoreLabel = SKLabelNode(fontNamed: "Futura")
        scoreLabel.fontSize = 22
        scoreLabel.position = CGPointMake(CGFloat(xUpperLeft + 50), CGFloat(250))
        scoreLabel.fontColor = UIColor(red: 0 / 255, green: 102 / 255, blue: 186 / 255, alpha: 1.0)
        scoreLabel.horizontalAlignmentMode = .Center
        scoreLabel.verticalAlignmentMode = .Top
        scoreLabel.zPosition = 1
        scoreLabel.text = GameConfiguration.sharedInstance.gameScoreLabelText
        scoreLabel.name = "scoreLabel"
        addChild(scoreLabel)

    }

    func addBeans () {
        let coffeBean: SKTexture = SKTexture(imageNamed: "coffeeBean_0.png")
        //var test: SKSpriteNode!

        let test = SKSpriteNode(texture: coffeBean)

        //let screenSize: CGRect = UIScreen.mainScreen().bounds
        let screenSize: CGRect = UIScreen.mainScreen().bounds

        test.setScale(0.25)
        //test.position = CGPointMake(-(screenSize.width/2) + 10, CGFloat(240.0))
        test.position = CGPointMake(-340, 240)

        //test.position = CGPointMake(CGFloat(-40 + (beanCount * 20)), CGFloat(240.0))

        beanCount++


        addChild(test)

    }

    func setupScoreboard () {

        // find coordinates
        //var xx: Int = GameConfiguration.sharedInstance.gameScoreLocation

        // settings are a coordinate setup of 25, 5x5
        // 1,  2,  3,  4,  5
        // 6,  7,  8,  9, 10
        //11, 12, 13, 14, 15
        //16, 17, 18, 19, 20
        //21, 22, 23, 24, 25


        // do math

        //let xPosition: CGFloat = 0
        //let yPosition: CGFloat = -100


        let xPosition = ((GameConfiguration.sharedInstance.gameScreen.width / 5) * CGFloat(GameConfiguration.sharedInstance.gameScoreLocationX))
        let yPosition = ((GameConfiguration.sharedInstance.gameScreen.height / 5) * CGFloat(GameConfiguration.sharedInstance.gameScoreLocationY))




        // set position
        //self.childNodeWithName("scoreLabel")!.position = CGPointMake(xPosition, yPosition)
        self.childNodeWithName("scoreLabel")!.position = CGPointMake(xPosition, yPosition)

    }

    func update (delta:CFTimeInterval) {
        // update the score if needed here


        addBeans()

    }

    func addPause () {
        pauseButton = SKLabelNode(fontNamed: "Futura")
        pauseButton.fontSize = 44
        pauseButton.position = CGPointMake(450, 250)
        pauseButton.fontColor = UIColor(red: 244 / 255, green: 102 / 255, blue: 186 / 255, alpha: 1.0)
        pauseButton.horizontalAlignmentMode = .Center
        pauseButton.verticalAlignmentMode = .Top
        pauseButton.zPosition = 1
        pauseButton.text = "II"
        pauseButton.name = "pauseButton"
        addChild(pauseButton)
    }


    func addScoreImage () {
        let scoreImageName: String = "ScoreImage" + String(GameConfiguration.sharedInstance.gameScoreImageNumber) + ".png"
        let scoreImage: SKTexture = SKTexture(imageNamed: scoreImageName)
        let test = SKSpriteNode(texture: scoreImage)
        
        //let screenSize: CGRect = UIScreen.mainScreen().bounds
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        
        //test.setScale(0.5)
        var xPoint: CGFloat = (screenSize.width / 2) + (test.frame.width / 2 ) - 20
        var yPoint: CGFloat = (screenSize.height / 2) + (test.frame.height / 2)

        //test.position = CGPointMake(-(xPoint), (screenSize.height / 2) + (test.frame.height / 2))

        //xPoint = 433.5 // xPoint - 20

        test.position = CGPointMake(-xPoint ,yPoint)

        print("frame width: \(test.frame.width)")
        print("frame height: \(test.frame.height)")
        print("screen width: \(screenSize.width)")
        print("screen height: \(screenSize.height)")
        print("xpoint: \(xPoint)")
        print("ypoint: \(yPoint)")

        addChild(test)
    }
    
    
}












