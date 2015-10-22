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
    var score:SKLabelNode!

    var screenSize2: CGRect!
    var xUpperLeft: Float!
    var yUpperLeft: Float!

    var lastLifeCount: Int = 0
    var lastBeanCount: Int = 0



    override init() {
        super.init()

        // set these with screen
        screenSize2 = UIScreen.mainScreen().bounds
        xUpperLeft = -450.0
        yUpperLeft = -250.0

        addPause()

        addScoreImage()

        addScore()
        addLives()


        //setupScoreboard()
        addBean()  // add beans that are picked up to box, cleanup caode for push

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    func addScore () {
        var scoreLabel: SKLabelNode!
        scoreLabel = SKLabelNode(fontNamed: "Futura")
        scoreLabel.fontSize = 30
        scoreLabel.position = CGPointMake(CGFloat(xUpperLeft + 280), CGFloat(210))
        scoreLabel.fontColor = UIColor(red: 0 / 255, green: 102 / 255, blue: 186 / 255, alpha: 1.0)
        scoreLabel.horizontalAlignmentMode = .Center
        scoreLabel.verticalAlignmentMode = .Bottom
        scoreLabel.zPosition = 1
        scoreLabel.text = GameConfiguration.sharedInstance.gameScoreLabelText
        scoreLabel.name = "scoreLabel"
        addChild(scoreLabel)

        var score: SKLabelNode!
        score = SKLabelNode(fontNamed: "Futura")
        score.fontSize = 30
        score.position = CGPointMake(CGFloat(xUpperLeft + 380), CGFloat(210))
        score.fontColor = UIColor(red: 0 / 255, green: 102 / 255, blue: 186 / 255, alpha: 1.0)
        score.horizontalAlignmentMode = .Left
        score.verticalAlignmentMode = .Bottom
        score.zPosition = 1
        score.text = String(GameManager.sharedInstance.gameScore)
        score.name = "score"
        addChild(score)
        self.score = score

    }

    func addLives () {

        let scoreImageName: String = "BagOfSugar.png" //+ String(GameConfiguration.sharedInstance.gameScoreImageNumber) + ".png"
        let scoreImage: SKTexture = SKTexture(imageNamed: scoreImageName)
        let life1 = SKSpriteNode(texture: scoreImage)
        life1.name = "life1"
        let life2 = SKSpriteNode(texture: scoreImage)
        life2.name = "life2"
        let life3 = SKSpriteNode(texture: scoreImage)
        life3.name = "life3"

        //let screenSize: CGRect = UIScreen.mainScreen().bounds
        let screenSize: CGRect = UIScreen.mainScreen().bounds

        //test.setScale(0.5)
        var xPoint: CGFloat = (screenSize.width / 2) - (life1.frame.width / 2 ) - 20
        var yPoint: CGFloat = (screenSize.height / 2) + (life1.frame.height / 2)


        //xPoint = 433.5 // xPoint - 20

        life1.position = CGPointMake(xPoint, yPoint)
        life2.position = CGPointMake(xPoint + 100, yPoint)
        life3.position = CGPointMake(xPoint + 200, yPoint)

        print("frame width: \(life1.frame.width)")
        print("frame height: \(life1.frame.height)")
        print("screen width: \(screenSize.width)")
        print("screen height: \(screenSize.height)")
        print("xpoint: \(xPoint)")
        print("ypoint: \(yPoint)")
        
        addChild(life1)
        addChild(life2)
        addChild(life3)



    }

    func addBean () {
        let coffeeBean = SKSpriteNode(texture: SKTexture(imageNamed: "coffeeBean_1.png"))
        coffeeBean.setScale(0.30)
        coffeeBean.zPosition = 1
        coffeeBean.position = CGPointMake(CGFloat(-380 + Int(arc4random_uniform(70))), CGFloat(150 + (arc4random_uniform(20))))

        addChild(coffeeBean)
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


        //let xPosition = ((GameConfiguration.sharedInstance.gameScreen.width / 5) * CGFloat(GameConfiguration.sharedInstance.gameScoreLocationX))
        //let yPosition = ((GameConfiguration.sharedInstance.gameScreen.height / 5) * CGFloat(GameConfiguration.sharedInstance.gameScoreLocationY))




        // set position
        //self.childNodeWithName("scoreLabel")!.position = CGPointMake(xPosition, yPosition)
        //self.childNodeWithName("scoreLabel")!.position = CGPointMake(xPosition, yPosition)

    }

    func update (delta:CFTimeInterval, positionIn:CGFloat) {
        updateLives()
        updateScore(positionIn)
        updateBeans()

    }

    func updateBeans() {
        if lastBeanCount != GameManager.sharedInstance.beanCount {
            lastBeanCount = GameManager.sharedInstance.beanCount
            addBean()
        }
    }

    func updateScore(positionIn:CGFloat) {
        score.text = String(GameManager.sharedInstance.incrementGameScoreWithDifferential(Int(positionIn)))
    }

    func updateLives() {
        if lastLifeCount != GameManager.sharedInstance.lifeCount {
            lastLifeCount = GameManager.sharedInstance.lifeCount
            childNodeWithName("life" + String(lastLifeCount))?.hidden = true
        }
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
        var xPoint: CGFloat = (screenSize.width / 2) + (test.frame.width / 2 ) - 40
        var yPoint: CGFloat = (screenSize.height / 2) + (test.frame.height / 2) - 70

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












