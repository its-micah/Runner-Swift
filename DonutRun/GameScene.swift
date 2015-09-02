//
//  GameScene.swift
//  DonutRun
//
//  Created by Micah Lanier on 8/12/15.
//  Copyright (c) 2015 Micah Lanier. All rights reserved.
//

import SpriteKit


enum BodyType:UInt32 {

    case player = 1
    case platformObject = 2
    case deathObject = 4
    case copObject = 8
    case bounceObject = 16
    case water = 32
    case grass = 64
    case coffeeBeanObject = 128

}

enum LevelType:UInt32 {

    case ground, water
}


let DonutCategory:UInt32 = 0x1 << 0;
let CopCategory:UInt32 = 0x1 << 1;
let SceneEdgeCategory:UInt32 = 0x1 << 2;
let MilkManCategory:UInt32 = 0x1 << 3;
let CoffeeBeanCategory:UInt32 = 0x1 << 4;
let JumpDonutCategory:UInt32 = 0x1 << 5;

var factor:CGFloat = 1;
var jumpCount:Int = 0;


class GameScene: SGScene, SKPhysicsContactDelegate {

    enum gameState {
        case gamePreGame
        case gamePaused
        case gameActive
        case gameDeath
    }

    let tapRec = UITapGestureRecognizer()

    var levelUnitCounter:CGFloat = 0
    var levelUnitWidth:CGFloat = 0
    var levelUnitHeight:CGFloat = 0
    var initialUnits:Int = 2
    var levelUnitCurrentlyOn:LevelUnit?


    //GameState
    var currentGameState:gameState = .gameActive
    var lastUpdateTime: NSTimeInterval = 0
    var timeSinceCopAdded: NSTimeInterval = 0
    var dt: NSTimeInterval = 0


    var layerBackground01Static = SKNode()
    var layerBackground02Slow = LayerBackground()
    var layerClouds = LayerBackground()
    var layerBackground03Fast = LayerBackground()



    var screenWidth:CGFloat = 0
    var screenHeight:CGFloat = 0
    let worldNode:SKNode = SKNode()
    var layerHUD:SKNode = LayerHUD()
    let thePlayer:Donut = Donut(imageNamed: "DonutRun_1")
    //var cop:Cop = Cop(imageNamed: "Cop2_1")

    var isDead:Bool = false
    var clearOffscreenLevelUnits:Bool = false

    let startingPosition:CGPoint = CGPointMake(0, 0)
    var copStartingPosition:CGPoint = CGPointMake(0, 0)



    var lastUpdateTimeInterval:Int = 0;
    var timeSinceEnemyAdded:Int = 0;
    var coffeeBeanCount:Int = 0;
    var pauseCount:Int = 0

    let buffer:CGFloat = 125;





    override func didMoveToView(view: SKView) {

        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: CGRectMake(0.0, buffer, self.frame.size.width, self.frame.size.height))
        self.physicsBody!.categoryBitMask = SceneEdgeCategory;
        self.physicsBody!.contactTestBitMask = JumpDonutCategory;
        self.physicsBody!.collisionBitMask = SceneEdgeCategory;

        self.backgroundColor = UIColor(red: 0.509, green: 0.859, blue: 1, alpha: 1)

        screenWidth = self.view!.bounds.width
        screenHeight = self.view!.bounds.height

        copStartingPosition = CGPointMake(screenWidth + 400, 0)

        levelUnitWidth = screenWidth
        levelUnitHeight = screenHeight

        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx:-1, dy:-9.8)


        self.anchorPoint = CGPointMake(0.5, 0.5)

        addChild(worldNode)
        worldNode.addChild(thePlayer)
        thePlayer.position = startingPosition
        thePlayer.zPosition = 101
        thePlayer.setScale(0.7)

        addLevelUnits()
        assignLayers()
        setUpLayers()

        physicsWorld.contactDelegate = self

    }

    func assignLayers() {

        addChild(layerBackground01Static)
        addChild(layerBackground02Slow)
        layerBackground02Slow.layerVelocity = CGPoint(x: -80.0, y: 0.0)
        addChild(layerClouds)
        layerClouds.layerVelocity = CGPoint(x: -25, y: 0.0)
        addChild(layerBackground03Fast)
        layerBackground03Fast.layerVelocity = CGPoint(x: -100.0, y: 0.0)
        addChild(layerHUD)

    }


    func setUpLayers() {
        let background = SKSpriteNode(imageNamed: "Looping_BG@2x")
        background.posByCanvas(0, y: -0.09)
        background.zPosition = -3
        layerBackground01Static.addChild(background)


        let clouds = SKSpriteNode(imageNamed: "clouds")
        clouds.posByCanvas(0, y: 0.15)
        clouds.anchorPoint = CGPointZero
        clouds.zPosition = -2.9
        clouds.alpha = 0.5
        clouds.name = "A"
        layerClouds.addChild(clouds)

        let clouds2 = SKSpriteNode(imageNamed: "clouds")
        clouds2.posByCanvas(1, y: 0.12)
        clouds2.anchorPoint = CGPointZero
        clouds2.zPosition = -2.9
        clouds2.alpha = 0.5
        clouds2.name = "B"
        layerClouds.addChild(clouds2)


        /*I think the building images need to be bigger images, so they don't get cut off like they are currently*/

        let background2 = SKSpriteNode(imageNamed: "buildings2")
        background2.posByCanvas(2, y: -0.33)
        background2.anchorPoint = CGPointZero
        background2.zPosition = -2.7
        background2.name = "A"
        layerBackground02Slow.addChild(background2)
        let background3 = SKSpriteNode(imageNamed: "buildings2")
        background3.position = CGPoint(x: background2.size.width, y: -300)
        background3.anchorPoint = CGPointZero
        background3.zPosition = -2.7
        background3.name = "B"
        layerBackground02Slow.addChild(background3)


        //layerBackground03Fast
        let background4 = SKSpriteNode(imageNamed: "BG003")
        background4.position = CGPoint (x: 0, y: -400)
        background4.anchorPoint = CGPointZero
        background4.zPosition = -2.5
        background4.name = "A"
        layerBackground03Fast.addChild(background4)
        let background5 = SKSpriteNode(imageNamed: "BG003")
        background5.position = CGPoint(x: background4.size.width - 3, y: -400)
        background5.anchorPoint = CGPointZero
        background5.zPosition = -2.5
        background5.name = "B"
        layerBackground03Fast.addChild(background5)

        
    }


    override func screenInteractionStarted(location: CGPoint) {
        if (location.x > (self.size.width * 0.4)) && (location.y > (self.size.height * 0.29)) {
            if currentGameState == .gameActive {
                currentGameState = .gamePaused
                physicsWorld.speed = 0.0
                speed = 0.0
            } else {
                currentGameState = .gameActive
                physicsWorld.speed = 1.0
                speed = 1.0
            }
        } else {
            tapped()
        }

    }


    func tapped() {

        if currentGameState == .gameActive {
            thePlayer.jump()
        } else {
            println("don't jump")
        }
    }


    func resetLevel(){

        worldNode.enumerateChildNodesWithName("levelUnit" ) {
            node, stop in

            node.removeFromParent()

        }

        levelUnitCounter = 0
        addLevelUnits()


    }

    func checkLevelUnitAroundLocation(theLocation:CGPoint) {

        var xLocation:CGFloat = theLocation.x
        var yLocation:CGFloat = theLocation.y

        var createLevel:Bool  = true

        if (createLevel == true) {


            let levelUnit:LevelUnit = LevelUnit()
            worldNode.addChild(levelUnit)
            levelUnit.zPosition = -1
            levelUnit.levelUnitWidth = levelUnitWidth
            levelUnit.levelUnitHeight = levelUnitHeight
            levelUnit.setUpLevel()

            levelUnit.position = CGPointMake( xLocation , yLocation)

            //println(levelArray)

        }

        
    }




    func createLevelUnit() {

        var ylocation:CGFloat = -100
        var xlocation:CGFloat = levelUnitCounter * levelUnitWidth


        let levelUnit:LevelUnit = LevelUnit()
        worldNode.addChild(levelUnit)
        levelUnit.zPosition = -1
        levelUnit.levelUnitWidth = levelUnitWidth
        levelUnit.levelUnitHeight = levelUnitHeight
        levelUnit.setUpLevel()

        levelUnit.position = CGPointMake( xlocation , ylocation)


        levelUnitCounter++

    }


    func addLevelUnits(){

        for var i = 0; i < initialUnits; i++ {

            createLevelUnit()

        }


    }



    func clearNodes(){


        var nodeCount:Int = 0

        worldNode.enumerateChildNodesWithName("levelUnit") {
            node, stop in


            let nodeLocation:CGPoint = self.convertPoint(node.position, fromNode: self.worldNode)

            if ( nodeLocation.x < -(self.screenWidth / 2) - self.levelUnitWidth ) {

                node.removeFromParent()

            } else {

                nodeCount++

            }

        }
        
    }

    func randomValueBetween(low: CFTimeInterval, high: CFTimeInterval) -> CFTimeInterval {
        return ((high * low) + low) - (low / 3)
    }
    


   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */

        //get the delta time
        if lastUpdateTime > 0 {
            dt = currentTime - lastUpdateTime
        } else {
            dt = 0
        }
        lastUpdateTime = currentTime


        //Update game
        if currentGameState == .gameActive {
            layerBackground02Slow.update(dt, affectAllNodes: true, parallax: true)
            layerBackground03Fast.update(dt, affectAllNodes: true, parallax: true)
            layerClouds.update(dt, affectAllNodes: true, parallax: true)
            //layerGameWorld?.update(dt, affectAllNodes: true, parallax: true)

            let nextTier:CGFloat = ((levelUnitCounter * levelUnitWidth) - (CGFloat(initialUnits) * levelUnitWidth))

            if (thePlayer.position.x > nextTier) {
                createLevelUnit()
            }


            clearNodes()


            if isDead == false {
                
                thePlayer.update()
                
            }

            let baseSpeed:CGFloat = 5


            thePlayer.position = CGPointMake(thePlayer.position.x + 5, thePlayer.position.y)


        }


    }


    override func didSimulatePhysics() {


        self.centerOnNode(thePlayer)


    }


    func centerOnNode(node:SKNode) {

        let cameraPositionInScene:CGPoint = self.convertPoint(node.position, fromNode: worldNode)
        worldNode.position = CGPoint(x: worldNode.position.x - cameraPositionInScene.x - 200 , y:0  )

    }




    func didBeginContact(contact: SKPhysicsContact) {


        // let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask

        //// check on water

        if (contact.bodyA.categoryBitMask == BodyType.player.rawValue  && contact.bodyB.categoryBitMask == BodyType.water.rawValue ) {

            levelUnitCurrentlyOn = contact.bodyB.node!.parent as? LevelUnit



        } else if (contact.bodyA.categoryBitMask == BodyType.water.rawValue  && contact.bodyB.categoryBitMask == BodyType.player.rawValue ) {

            levelUnitCurrentlyOn = contact.bodyA.node!.parent as? LevelUnit


        }


        //// check on grass

        if (contact.bodyA.categoryBitMask == BodyType.player.rawValue  && contact.bodyB.categoryBitMask == BodyType.deathObject.rawValue ) {

            killPlayer()

        } else if (contact.bodyA.categoryBitMask == BodyType.deathObject.rawValue  && contact.bodyB.categoryBitMask == BodyType.player.rawValue ) {

            killPlayer()

        }



    }


    func killPlayer() {


        if ( isDead == false) {

            isDead = true

            let fadeOut:SKAction = SKAction.fadeAlphaTo(0, duration: 0.2)
            let move:SKAction = SKAction.moveTo(startingPosition, duration: 0.2)
            let block:SKAction = SKAction.runBlock(revivePlayer)
            let seq:SKAction = SKAction.sequence([fadeOut, move, block])

            thePlayer.runAction(seq)

            let fadeOutBG = SKAction.fadeAlphaTo(0, duration: 0.5)
            let blockBG = SKAction.runBlock(resetLoopingBackground)
            let fadeInBG = SKAction.fadeAlphaTo(1, duration: 0.5)
            let seqBG = SKAction.sequence([fadeOutBG, blockBG, fadeInBG])

        }


    }

    func revivePlayer() {

        isDead = false

        let fadeOut:SKAction = SKAction.fadeAlphaTo(0, duration: 0.2)
        let block:SKAction = SKAction.runBlock(resetLevel)
        let fadeIn:SKAction = SKAction.fadeAlphaTo(1, duration: 0.2)
        let seq:SKAction = SKAction.sequence([fadeOut, block, fadeIn])
        worldNode.runAction(seq)

        let wait:SKAction = SKAction.waitForDuration(1)
        let fadeIn2:SKAction = SKAction.fadeAlphaTo(1, duration: 0.2)
        let seq2:SKAction = SKAction.sequence([wait , fadeIn2])
        thePlayer.runAction(seq2)

    }



    func resetLoopingBackground() {

//        loopingBG.position = CGPointMake(0, -50)
//        loopingBG2.position = CGPointMake(loopingBG2.size.width - 3, -50)

    }







    



}
