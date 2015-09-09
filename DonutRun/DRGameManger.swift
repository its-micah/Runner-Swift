//
//  DRShareInstance.swift
//  DonutRun
//
//  Created by Mick Lerche on 9/3/15.
//  Copyright (c) 2015 Micah Lanier. All rights reserved.
//

import Foundation

class DRGameManager {

    static let sharedInstance = DRGameManager()

    var gameScore: Int = 5
    var randomCopCounter: UInt32 = 6


    private init() {
        println(__FUNCTION__)
    }

    func displayGameScore() {
        println("\(__FUNCTION__) \(self.gameScore)")
    }

    func incrementGameScore(scoreInc: Int) {
        self.gameScore += scoreInc
    }

    func randomizeCopCounter() {
        randomCopCounter = arc4random_uniform(100)
        randomCopCounter++
        println("randomCopCounter = \(self.randomCopCounter)")
    }

    func timeForNewCop() -> Bool {
        var timeForNewCop: Bool = false
        if(DRGameManager.sharedInstance.randomCopCounter-- == 1){
            DRGameManager.sharedInstance.randomizeCopCounter()
            timeForNewCop = true
        }
        println("timeForNewCop = \(self.randomCopCounter)")
        return timeForNewCop
    }


}
