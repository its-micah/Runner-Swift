//
//  LevelUnit.swift
//  EndlessWorlds
//
//  Created by Justin Dike on 5/27/15.
//  Copyright (c) 2015 CartoonSmart. All rights reserved.
//

import Foundation
import SpriteKit

class LevelUnit:SKNode {
    
    var imageName:String = ""
    var backgroundSprite:SKSpriteNode = SKSpriteNode()
    var levelUnitWidth:CGFloat = 0
    var levelUnitHeight:CGFloat = 0
    var theType:LevelType = LevelType.ground
    
    var xAmount:CGFloat = 0.8  //essentially this is our speed
    var direction:CGFloat = 1 //will be saved as either 1 or -1
    var numberOfObjectsInLevel:UInt32 = 0
    var offscreenCounter:Int = 0 //anytime an object goes offscreen we add to this, for resetting speed purposes
    var topSpeedgrass:UInt32 = 5
    var topSpeedWater:UInt32 = 2
    var maxObjectsInLevelUnit:UInt32 = 5
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override init () {
        
        super.init()
        
        

    }
    
    func setUpLevel(){
        

        let diceRoll = arc4random_uniform(6)

        if diceRoll == 0 {
            imageName = "background1"
            theType = LevelType.ground
        } else if diceRoll == 1 {
            imageName = "background2"
        } else if diceRoll == 2 {
            imageName = "background3"
        } else if diceRoll == 3 {
            imageName = "background1"
        } else if diceRoll == 4 {
            imageName = "background3"
        } else if diceRoll == 5 {
            imageName = "background2"
        } else if diceRoll == 5 {
            imageName = "background4"
        }



    
        let theSize:CGSize = CGSizeMake(levelUnitWidth, levelUnitHeight)
        let tex:SKTexture = SKTexture(imageNamed: imageName)
        backgroundSprite = SKSpriteNode(texture: tex, color: SKColor.clearColor(), size: theSize)
        
        
        // backgroundSprite = SKSpriteNode(texture: nil, color:SKColor.blueColor(), size:theSize)
        
        self.addChild(backgroundSprite)
        self.name = "levelUnit"
        
        self.position = CGPointMake(backgroundSprite.size.width / 2.2, 0)
       // backgroundSprite.position = CGPointMake(backgroundSprite.size.width / 2, 0)
        
//        if (theType == LevelType.water) {
//            
//            backgroundSprite.physicsBody = SKPhysicsBody(rectangleOfSize: backgroundSprite.size)
//            
//            backgroundSprite.physicsBody!.categoryBitMask = BodyType.water.rawValue
//            backgroundSprite.physicsBody!.contactTestBitMask = BodyType.water.rawValue
//            backgroundSprite.physicsBody!.dynamic = false

      if (theType == LevelType.ground){
            
            backgroundSprite.physicsBody = SKPhysicsBody(rectangleOfSize: backgroundSprite.size, center: CGPointMake(0, -backgroundSprite.size.height * 0.88))
            
            backgroundSprite.physicsBody!.categoryBitMask = BodyType.grass.rawValue
            backgroundSprite.physicsBody!.contactTestBitMask = BodyType.grass.rawValue
            backgroundSprite.physicsBody!.dynamic = false
            backgroundSprite.physicsBody!.restitution = 0
            
        }

        
        createObstacle()
    }
    
    func createObstacle() {
        
      
       
        
        numberOfObjectsInLevel = arc4random_uniform(maxObjectsInLevelUnit)
        numberOfObjectsInLevel = numberOfObjectsInLevel + 1 // so it can't be 0
        
        
        
       
        
        
        if (theType == LevelType.ground) {
            
            for (var i = 0; i < Int(numberOfObjectsInLevel); i++) {
                
                let randomX = arc4random_uniform(  UInt32 (backgroundSprite.size.width) )
                let randomY = arc4random_uniform(  UInt32 (backgroundSprite.size.height) )
                
                let obstacle:Object = Object()
                
                obstacle.theType = LevelType.ground
                obstacle.levelUnitWidth = levelUnitWidth
                obstacle.levelUnitHeight = levelUnitHeight
                
                
                obstacle.createObject()
                addChild(obstacle)
                
            }
        }


           
            
            
//        } else if (theType == LevelType.water) {
//            
//            
//            
//            for (var i = 0; i < Int(numberOfObjectsInLevel); i++) {
//                
//                
//                let randomX = arc4random_uniform(  UInt32 (backgroundSprite.size.width) )
//                let randomY = arc4random_uniform(  UInt32 (backgroundSprite.size.height) )
//                
//                let obstacle:Object = Object()
//                
//                obstacle.xAmount = xAmount
//                obstacle.theType = LevelType.water
//                
//                obstacle.createObject()
//                addChild(obstacle)
//                
//                
//                obstacle.position = CGPointMake(-(backgroundSprite.size.width / 2) + CGFloat(randomX) , -(backgroundSprite.size.height / 2) + CGFloat(randomY) )
//                
//            }
//            
//            
//        }

        
       
        
    }
    
    
    
    
    
    
    
}













