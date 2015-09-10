//
//  Object.swift
//  JoyStickControls
//
//  Created by Justin Dike on 5/4/15.
//  Copyright (c) 2015 CartoonSmart. All rights reserved.
//

import Foundation
import SpriteKit

class Object: SKNode {
    
    var objectSprite:SKSpriteNode = SKSpriteNode()
    var imageName:String = ""
    var xAmount :CGFloat = 1
    var theType:LevelType = LevelType.ground

    var levelUnitWidth:CGFloat = 0
    var levelUnitHeight:CGFloat = 0

    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override init () {
        
        super.init()
        
        
    }
    
    func createObject() {

        
        if (theType == LevelType.ground) {
            
             let diceRoll = arc4random_uniform(6)
            
            if ( diceRoll == 0) {
                
                imageName = "Platform2"
                
            } else if ( diceRoll == 1) {
                
                //imageName = "Cactus"
                
            } else if ( diceRoll == 2) {
                
                //imageName = "Barrel"
                
            } else if ( diceRoll == 3) {
                
                //imageName = "Wheel"
                
            } else if ( diceRoll == 4) {
                
                //imageName = "Rock"
                
            } else if ( diceRoll == 5) {
                
                //imageName = "Money"
    
            }

            
        }
        
        objectSprite = SKSpriteNode(imageNamed:imageName)
        
        
        
        //self.addChild(objectSprite)

        if imageName == "Platform2" {

            let newSize = CGSizeMake(objectSprite.size.width, 10)

            objectSprite.physicsBody = SKPhysicsBody(rectangleOfSize: newSize)
            objectSprite.physicsBody!.categoryBitMask = BodyType.platformObject.rawValue
            objectSprite.physicsBody!.friction = 1
            objectSprite.physicsBody!.dynamic = false
            objectSprite.physicsBody!.affectedByGravity = false
            objectSprite.physicsBody!.restitution = 0.0
            objectSprite.physicsBody!.allowsRotation = false


            let diceRoll = arc4random_uniform(3)

            if diceRoll == 0 {
                self.position = CGPointMake(0 , 20)

            } else if diceRoll == 1 {
                self.position = CGPointMake(0 ,  25)

            } else if diceRoll == 2 {
                self.position = CGPointMake(0 , 50)

            }

            let width:UInt32 = UInt32(levelUnitWidth)
            let diceRollX = arc4random_uniform(width)

            self.position = CGPointMake(CGFloat(diceRollX) - (levelUnitWidth / 2) , self.position.y)
            self.addChild(objectSprite)


        }



//         else if imageName == "Wheel" {
//
//            objectSprite.physicsBody = SKPhysicsBody(circleOfRadius: objectSprite.size.width / 2)
//            //objectSprite.physicsBody!.categoryBitMask = BodyType.deathObject.rawValue
//            //objectSprite.physicsBody!.contactTestBitMask = BodyType.deathObject.rawValue
//            objectSprite.physicsBody!.friction = 1
//            objectSprite.physicsBody!.dynamic = true
//            objectSprite.physicsBody!.affectedByGravity = true
//            objectSprite.physicsBody!.restitution = 0.0
//            objectSprite.physicsBody!.allowsRotation = false
//            self.position = CGPointMake(0 ,  0)
//
//
//        } else if imageName == "Money" {
//
//        } else {
//
//            objectSprite.physicsBody = SKPhysicsBody(circleOfRadius: objectSprite.size.width / 2)
////            objectSprite.physicsBody!.categoryBitMask = BodyType.deathObject.rawValue
////            objectSprite.physicsBody!.contactTestBitMask = BodyType.deathObject.rawValue
//            objectSprite.physicsBody!.friction = 1
//            objectSprite.physicsBody!.dynamic = true
//            objectSprite.physicsBody!.affectedByGravity = true
//            objectSprite.physicsBody!.restitution = 0.0
//            objectSprite.physicsBody!.allowsRotation = false
//            self.position = CGPointMake(0 ,  0)
////
////
//        }


        self.name = "obstacle"
        self.zPosition = 102
        
        
    }

}
    
    
   
    
    
    






