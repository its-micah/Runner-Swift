//
//  DRShareInstance.swift
//  DonutRun
//
//  Created by Mick Lerche on 9/3/15.
//  Copyright (c) 2015 Grumpy Dane Studios. All rights reserved.
//

import Foundation
//import UIKit

class GameManager {

    static let sharedInstance = GameManager()

    var gameScore: Int = 5
    var randomCopCounter: UInt32 = 6



    private init() {
        print("GameManager " + __FUNCTION__)


    }

    func displayGameScore() {
        //println("\(__FUNCTION__) \(self.gameScore)")
    }

    func incrementGameScore(scoreInc: Int) {
        self.gameScore += scoreInc
        print("incrementGameScore = \(self.gameScore)")
    }

    func randomizeCopCounter() {
        randomCopCounter = arc4random_uniform(100)
        randomCopCounter++
        //println("randomCopCounter = \(self.randomCopCounter)")
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


}
