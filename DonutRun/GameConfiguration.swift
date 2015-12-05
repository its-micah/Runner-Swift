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


    var gameScreen: CGRect
    var gameScale: CGFloat = 1

    var suffix: String = "(iOS)"

    var gameConfigurationDictionary: NSDictionary

    let pink: UIColor = UIColor(red: 244 / 255, green: 102 / 255, blue: 186 / 255, alpha: 1.0)

    private init() {
        // print("GameConfiguration \(__FUNCTION__)")
        // plist setup
        let path = NSBundle.mainBundle().pathForResource("GameConfiguration", ofType: "plist")
        gameConfigurationDictionary = NSDictionary(contentsOfFile: path!)!

        gameScreen = UIScreen.mainScreen().bounds
        print("Screen width = \(gameScreen.width)")
        print("Screen height = \(gameScreen.height)")


    }

    func setGameScale() {
        #if os(tvOS)

        GameConfiguration.sharedInstance.suffix = "(tvOS)"

        #endif
    }

    func displayGameScore() {
        //println("\(__FUNCTION__) \(self.gameScore)")
    }

    func changeGameScoreLocation(scoreInc: Int) {
        //self.gameScoreLocation = scoreInc
        //print("incrementGameScore = \(self.gameScore)")
    }

    func getGameConfigurationCGFloat(type: String, settingName: String) -> CGFloat {
        let typeGameConfigurationDictionary = gameConfigurationDictionary[type] as! NSDictionary
        return typeGameConfigurationDictionary[settingName + GameConfiguration.sharedInstance.suffix] as! CGFloat
    }

    func getGameConfigurationString(type: String, settingName: String) -> String {
        let typeGameConfigurationDictionary = gameConfigurationDictionary[type] as! NSDictionary
        return typeGameConfigurationDictionary[settingName + GameConfiguration.sharedInstance.suffix] as! String
    }
    





}