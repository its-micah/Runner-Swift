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


class GameScene: SKScene, SKPhysicsContactDelegate {

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

    //let loopingBG = SKSpriteNode(imageNamed: "Looping_BG@2x")
    //let loopingBG2 = SKSpriteNode(imageNamed: "Looping_BG@2x")

    //GameState
    var currentGameState:gameState = .gameActive
    var lastUpdateTime: NSTimeInterval = 0
    var dt: NSTimeInterval = 0

    //    let loopingBG = SKSpriteNode(imageNamed: "Looping_BG@2x")
    //    let loopingBG2 = SKSpriteNode(imageNamed: "Looping_BG@2x")

    var layerBackground01Static = SKNode()
    var layerBackground02Slow = LayerBackground()
    var layerBackground03Fast = LayerBackground()



    var screenWidth:CGFloat = 0
    var screenHeight:CGFloat = 0
    let worldNode:SKNode = SKNode()
    let thePlayer:Donut = Donut(imageNamed: "DonutRun_1")

    var isDead:Bool = false
    var clearOffscreenLevelUnits:Bool = false

    let startingPosition:CGPoint = CGPointMake(0, 0)


    var lastUpdateTimeInterval:Int = 0;
    var timeSinceEnemyAdded:Int = 0;
    var coffeeBeanCount:Int = 0;
    var pauseCount:Int = 0

    let buffer:CGFloat = 125;





    override func didMoveToView(view: SKView) {


        self.physicsWorld.contactDelegate = self

        tapRec.addTarget(self, action: "tapped")
        self.view!.addGestureRecognizer(tapRec)


        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: CGRectMake(0.0, buffer, self.frame.size.width, self.frame.size.height))
        self.physicsBody!.categoryBitMask = SceneEdgeCategory;
        self.physicsBody!.contactTestBitMask = JumpDonutCategory;
        self.physicsBody!.collisionBitMask = SceneEdgeCategory;

        self.backgroundColor = UIColor(red: 0.509, green: 0.859, blue: 1, alpha: 1)

        screenWidth = self.view!.bounds.width
        screenHeight = self.view!.bounds.height

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
//        addChild(loopingBG)
//        addChild(loopingBG2)
//
//        loopingBG.zPosition = -200
//        loopingBG2.zPosition = -200
//
//        loopingBG.yScale = 1.1
//        loopingBG2.yScale = 1.1

        startLoopingBackground()

        assignLayers()
        setUpLayers()

    }

    func assignLayers() {

        addChild(layerBackground01Static)
        //addChild(layerBackground02Slow)
        //layerBackground02Slow.layerVelocity = CGPoint(x: -50.0, y: 0.0)
        addChild(layerBackground03Fast)
        layerBackground03Fast.layerVelocity = CGPoint(x: -100.0, y: 0.0)
        //addChild(hud)

    }


    func setUpLayers() {
        let background = SKSpriteNode(imageNamed: "Looping_BG@2x")
        background.posByCanvas(0, y: -0.09)
        background.zPosition = -3
        layerBackground01Static.addChild(background)

        /*This code below called slowBackgroundLayer would put something in the midground area. The z position needs to be
        addressed so it's behind the bushes, but more importantly, I can't figure out why some of the images are in the right
        area, while others are really high. They are also not spaced correctly either. Uncomment to see for yourself. */

        //        let background2 = SKSpriteNode(imageNamed: "BG002")
        //        background2.posByCanvas(0, y: 0)
        //        background2.anchorPoint = CGPointZero
        //        background2.zPosition = -2
        //        background2.name = "A"
        //        layerBackground02Slow.addChild(background2)
        //        let background3 = SKSpriteNode(imageNamed: "BG002")
        //        background2.posByCanvas(1, y: 0)
        //        background2.anchorPoint = CGPointZero
        //        background2.zPosition = -2
        //        background2.name = "B"
        //        layerBackground02Slow.addChild(background3)


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



    func startLoopingBackground() {

//        resetLoopingBackground()
//
//        loopingBG.position = CGPointMake(0, -50)
//        loopingBG2.position = CGPointMake(loopingBG2.size.width - 3, -50)
//
//        let move = SKAction.moveByX(-loopingBG2.size.width, y: 0, duration: 20)
//        let moveBack = SKAction.moveByX(loopingBG.size.width, y: 0, duration: 0)
//
//        let seq = SKAction.sequence([move,moveBack])
//        let repeat = SKAction.repeatActionForever(seq)
//
//        loopingBG.runAction(repeat)
//        loopingBG2.runAction(repeat)



    }


    func tapped() {

        thePlayer.jump()
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

        //print( "levelUnits in the scene is \(nodeCount)")
        
        
    }
    

    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {

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
            //layerGameWorld?.update(dt, affectAllNodes: true, parallax: true)
            
        }


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

//            loopingBG.removeAllActions()
//            loopingBG2.removeAllActions()

            let fadeOut:SKAction = SKAction.fadeAlphaTo(0, duration: 0.2)
            let move:SKAction = SKAction.moveTo(startingPosition, duration: 0.2)
            let block:SKAction = SKAction.runBlock(revivePlayer)
            let seq:SKAction = SKAction.sequence([fadeOut, move, block])

            thePlayer.runAction(seq)

            let fadeOutBG = SKAction.fadeAlphaTo(0, duration: 0.5)
            let blockBG = SKAction.runBlock(resetLoopingBackground)
            let fadeInBG = SKAction.fadeAlphaTo(1, duration: 0.5)
            let seqBG = SKAction.sequence([fadeOutBG, blockBG, fadeInBG])

//            loopingBG.runAction(seqBG)
//            loopingBG2.runAction(seqBG)



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
