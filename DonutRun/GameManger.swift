//
//  DRShareInstance.swift
//  DonutRun
//
//  Created by Mick Lerche on 9/3/15.
//  Copyright (c) 2015 Grumpy Dane Studios. All rights reserved.
//

import Foundation
import UIKit

struct GameManagerDefaultsKeys {
    static let highScoreKey = "highScore"
    //static let someOtherString  = "someOtherString"
    //static let someInt  = "someInt"
}

class GameManager {

    static let sharedInstance = GameManager()

    var gameScore: Int = 0
    var gameScoreDifferential: Int = 0
    var gameScoreLast: Int = 0
    var highScore: Int = 0

    var beanCount: Int = 0
    var lifeCount: Int = 0
    var randomCopCounter: UInt32 = 6
    var randomCoffeeBeanCounter: UInt32 = 3

    //var goToBackgroundObserver: AnyObject?

    private init() {
        let defaults = NSUserDefaults.standardUserDefaults()
        let highScoreFromDefaults: AnyObject? = defaults.objectForKey(GameManagerDefaultsKeys.highScoreKey)
        if highScoreFromDefaults == nil {
            defaults.setObject(0, forKey: GameManagerDefaultsKeys.highScoreKey)
        } else {
            highScore = highScoreFromDefaults as! Int
        }

        //var goToBackgroundObserver: AnyObject?

//        let goToBackgroundObserver: AnyObject? = NSNotificationCenter.defaultCenter()
//            .addObserverForName(UIApplicationDidEnterBackgroundNotification, object: nil, queue: nil) { (note: NSNotification!) -> Void in
//                GameManager.sharedInstance.Save()
//        }

        print("GameManager " + __FUNCTION__)
    }

    func displayGameScore() {
        print("\(__FUNCTION__) \(self.gameScore)")
    }

    func incrementGameScore(scoreIncrement: Int) {
        self.gameScore += scoreIncrement
        //print("incrementGameScore = \(self.gameScore)")
    }

    func incrementGameScoreWithDifferential(scoreIn: Int) -> Int {
        if scoreIn > gameScoreLast {
            self.gameScore = gameScoreDifferential + scoreIn
            self.gameScoreLast = scoreIn
        } else {
            self.gameScoreDifferential = self.gameScore
            self.gameScoreLast = scoreIn
            self.gameScore += scoreIn
        }

        //print("incrementGameScoreWithDifferential = \(self.gameScore)")
        return gameScore
    }

    func incrementBeanCount(beanIncrement: Int = 1) {
        self.beanCount += beanIncrement
        print("incrementBeanCount = \(self.beanCount)")
    }

    func incrementLifeCount(lifeIncrement: Int = 1) {
        self.lifeCount += lifeIncrement
        print("incrementLifeCount = \(self.lifeCount)")
    }

    func randomizeCopCounter() {
        randomCopCounter = arc4random_uniform(100)
        randomCopCounter++
        //print("randomCopCounter = \(self.randomCopCounter)")
    }

    func timeForNewCop() -> Bool {
        var timeForNewCop: Bool = false
        if(GameManager.sharedInstance.randomCopCounter-- == 1){
            GameManager.sharedInstance.randomizeCopCounter()
            timeForNewCop = true
        }
        //println("timeForNewCop = \(self.randomCopCounter)")
        return timeForNewCop
    }

    func resetForNewGame() {
        gameScore = 0
        gameScoreDifferential = 0
        gameScoreLast = 0

        beanCount = 0
        lifeCount = 0
    }

    func Save() {
        let defaults = NSUserDefaults.standardUserDefaults()
        if self.gameScore > self.highScore {
            self.highScore = self.gameScore
            defaults.setObject( self.gameScore, forKey: GameManagerDefaultsKeys.highScoreKey)
            defaults.synchronize()
        }

    }

    func timeForCoffeeBean() -> Bool {
        var timeForNewCoffeeBean: Bool = false
        if(GameManager.sharedInstance.randomCoffeeBeanCounter-- == 1){
            GameManager.sharedInstance.randomizeCoffeeBeanCounter()
            timeForNewCoffeeBean = true
        }
        //println("timeForNewCop = \(self.randomCopCounter)")
        return timeForNewCoffeeBean
    }

    func randomizeCoffeeBeanCounter() {
        randomCoffeeBeanCounter = arc4random_uniform(150)
        randomCoffeeBeanCounter++
        //println("randomCopCounter = \(self.randomCopCounter)")
    }
}
