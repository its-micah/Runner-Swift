//
//  GameConfiguration.swift
//  DonutRun
//
//  Created by Mick Lerche on 10/5/15.
//  Copyright © 2015 Grumpy Dane Studios. All rights reserved.
//

import Foundation
import UIKit

class GameConfiguration {

    static let sharedInstance = GameConfiguration()

    var gameScore: Int = 0
    var gameScoreLocationX: Int = -3
    var gameScoreLocationY: Int = 0
    var gameScoreImageNumber: Int = 3
    var gameScoreLabelText: String = "Score"

    var gameScreen: CGRect


    private init() {
        print("GameConfiguration \(__FUNCTION__)")
        // plist test
        let path = NSBundle.mainBundle().pathForResource("LayerHUD", ofType: "plist")
        let layerHudOptionsDictionary = NSDictionary(contentsOfFile: path!)
        let layerHudScoreDictionary = layerHudOptionsDictionary!["Score"] as! NSDictionary

        gameScreen = UIScreen.mainScreen().bounds
        print("Screen width = \(gameScreen.width)")
        print("Screen height = \(gameScreen.height)")

        gameScoreImageNumber = layerHudScoreDictionary["ImageNumber"] as! Int
        gameScoreLocationX = layerHudScoreDictionary["LocationX"] as! Int
        gameScoreLocationY = layerHudScoreDictionary["LocationY"] as! Int
        gameScoreLabelText = layerHudScoreDictionary["LabelText"] as! String
        
    }

    func displayGameScore() {
        //println("\(__FUNCTION__) \(self.gameScore)")
    }

    func changeGameScoreLocation(scoreInc: Int) {
        //self.gameScoreLocation = scoreInc
        //print("incrementGameScore = \(self.gameScore)")
    }
}