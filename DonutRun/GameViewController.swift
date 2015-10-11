//
//  GameViewController.swift
//  DonutRun
//
//  Created by Micah Lanier on 8/12/15.
//  Copyright (c) 2015 Micah Lanier. All rights reserved.
//

import UIKit
import SpriteKit



class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let scene = Introducer(size: CGSize(width: 1024, height: 768))
        let skView = self.view as! SKView

        skView.multipleTouchEnabled = true

        #if DEBUG
            skView.showsFPS = gameSettings?.objectForKey("Debugging")?.objectForKey("ALL-ShowFrameRate") as! Bool
            skView.showsNodeCount = gameSettings?.objectForKey("Debugging")?.objectForKey("ALL-ShowNodeCount") as! Bool
            skView.showsDrawCount = gameSettings?.objectForKey("Debugging")?.objectForKey("IOS-ShowDrawCount") as! Bool
            skView.showsQuadCount = gameSettings?.objectForKey("Debugging")?.objectForKey("IOS-ShowQuadCount") as! Bool
            skView.showsPhysics = gameSettings?.objectForKey("Debugging")?.objectForKey("IOS-ShowPhysics") as! Bool
            skView.showsFields = gameSettings?.objectForKey("Debugging")?.objectForKey("IOS-ShowFields") as! Bool
        #endif

        DRGameManager.sharedInstance.gameScore = 9

        DRGameManager.sharedInstance.displayGameScore()

        DRGameManager.sharedInstance.randomizeCopCounter()


        skView.ignoresSiblingOrder = true

        scene.scaleMode = .AspectFill

        let SizeCon:SGResolution = SGResolution(screenSize: view.bounds.size, canvasSize: scene.size)
        
        skView.presentScene(scene)
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return UIInterfaceOrientationMask.AllButUpsideDown
        } else {
            return UIInterfaceOrientationMask.All
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
