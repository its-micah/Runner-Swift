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
        addLifes()


        //setupScoreboard()
        //addBean()  // add beans that are picked up to box, cleanup caode for push

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    func addScore () {

        var scoreLabel: SKLabelNode!
        scoreLabel = SKLabelNode(fontNamed: "Futura")
        scoreLabel.fontSize = GameConfiguration.sharedInstance.getGameConfigurationCGFloat(String(self.dynamicType), settingName: "scoreFontSize")
        scoreLabel.posByScreen(-0.25, y: 0.4)
        scoreLabel.setScale(GameConfiguration.sharedInstance.gameScale)
        scoreLabel.fontColor = UIColor(red: 0 / 255, green: 102 / 255, blue: 186 / 255, alpha: 1.0)
        scoreLabel.horizontalAlignmentMode = .Center
        scoreLabel.verticalAlignmentMode = .Bottom
        scoreLabel.zPosition = 1
        scoreLabel.text = GameConfiguration.sharedInstance.getGameConfigurationString(String(self.dynamicType), settingName: "scoreText")
        scoreLabel.name = "scoreLabel"
        //addChild(scoreLabel)

        var score: SKLabelNode!
        score = SKLabelNode(fontNamed: "Futura")
        score.fontSize = GameConfiguration.sharedInstance.getGameConfigurationCGFloat(String(self.dynamicType), settingName: "scoreFontSize")
        score.posByScreen(-0.1, y: 0.4)
        score.setScale(GameConfiguration.sharedInstance.gameScale)
        score.fontColor = UIColor(red: 0 / 255, green: 102 / 255, blue: 186 / 255, alpha: 1.0)
        score.horizontalAlignmentMode = .Left
        score.verticalAlignmentMode = .Bottom
        score.zPosition = 1
        score.text = String(GameManager.sharedInstance.gameScore)
        score.name = "score"
        //addChild(score)
        self.score = score

    }

    func addLifes () {
        // let numberOfLifes: Int = GameConfiguration.sharedInstance.life
        for index in 1...3 {
            addLife(index)
        }
    }

    func addLife(lifeNumber: Int) {

        let lifeImageName: String = "lifeDonut.png" //+ String(GameConfiguration.sharedInstance.gameScoreImageNumber) + ".png"
        let lifeNode = SKSpriteNode(texture: SKTexture(imageNamed: lifeImageName))
        lifeNode.name = "life" + String(lifeNumber)
        lifeNode.posByCanvas(0.25 + CGFloat(Double(lifeNumber - 1) * 0.09), y: 0.4)
        lifeNode.setScale(GameConfiguration.sharedInstance.gameScale)
        lifeNode.zPosition = 5

        addChild(lifeNode)
    }


    func addBean () {
        let coffeeBean = SKSpriteNode(texture: SKTexture(imageNamed: "coffeeBean_1.png"))

        coffeeBean.setScale(0.30)
        //coffeeBean.setScale(GameConfiguration.sharedInstance.getCollectableSetting("collectableScale"))

        coffeeBean.zPosition = 1
        coffeeBean.position = CGPointMake(CGFloat(-380 + Int(arc4random_uniform(70))), CGFloat(150 + (arc4random_uniform(20))))

        //addChild(coffeeBean)
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
        pauseButton = SKLabelNode(fontNamed: "Gotham Rounded Medium")
        pauseButton.fontSize = 44
        pauseButton.posByScreen(0.45, y: 0.45)
        pauseButton.setScale(GameConfiguration.sharedInstance.gameScale)
        pauseButton.fontColor = UIColor(red: 244 / 255, green: 102 / 255, blue: 186 / 255, alpha: 1.0)
        pauseButton.horizontalAlignmentMode = .Center
        pauseButton.verticalAlignmentMode = .Top
        pauseButton.zPosition = 1
        pauseButton.text = "II"
        pauseButton.name = "pauseButton"
        //addChild(pauseButton)
    }


    func addScoreImage () {
//        let scoreImageName: String = "ScoreImage" + GameConfiguration.sharedInstance.getGameConfigurationString(String(self.dynamicType), settingName: "scoreImageNumber") + ".png"
//        let scoreImageTexture: SKTexture = SKTexture(imageNamed: scoreImageName)
//        let scoreImageNode = SKSpriteNode(texture: scoreImageTexture)
//        scoreImageNode.posByScreen(-0.4, y: 0.4)
//        scoreImageNode.setScale(GameConfiguration.sharedInstance.gameScale)
//        addChild(scoreImageNode)
    }
    
    
}












