//
//  GameViewController.swift
//  DonutRun (tvOS)
//
//  Created by Mick Lerche on 10/31/15.
//  Copyright (c) 2015 Micah Lanier. All rights reserved.
//

import UIKit
import SpriteKit


class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        if let scene = GameScene(fileNamed: "GameScene") {
//            // Configure the view.
//            let skView = self.view as! SKView
//            skView.showsFPS = true
//            skView.showsNodeCount = true
//            
//            /* Sprite Kit applies additional optimizations to improve rendering performance */
//            skView.ignoresSiblingOrder = true
//            
//            /* Set the scale mode to scale to fit the window */
//            scene.scaleMode = .AspectFill
//            
//            skView.presentScene(scene)
//        }




// below works, from ios version
        let scene = Introducer(size: CGSize(width: 1024, height: 768))
        //let scene = Introducer(size: CGSize(width: view.bounds.size.width, height: view.bounds.size.height))

        let skView = self.view as! SKView

        //skView.multipleTouchEnabled = true

        #if DEBUG
            skView.showsFPS = gameSettings?.objectForKey("Debugging")?.objectForKey("ALL-ShowFrameRate") as! Bool
            skView.showsNodeCount = gameSettings?.objectForKey("Debugging")?.objectForKey("ALL-ShowNodeCount") as! Bool
            skView.showsDrawCount = gameSettings?.objectForKey("Debugging")?.objectForKey("IOS-ShowDrawCount") as! Bool
            skView.showsQuadCount = gameSettings?.objectForKey("Debugging")?.objectForKey("IOS-ShowQuadCount") as! Bool
            skView.showsPhysics = gameSettings?.objectForKey("Debugging")?.objectForKey("IOS-ShowPhysics") as! Bool
            skView.showsFields = gameSettings?.objectForKey("Debugging")?.objectForKey("IOS-ShowFields") as! Bool
        #endif

        GameManager.sharedInstance.gameScore = 0

        GameManager.sharedInstance.displayGameScore()

        GameManager.sharedInstance.randomizeCopCounter()


        skView.ignoresSiblingOrder = true

        scene.scaleMode = .AspectFill

        let SizeCon:SGResolution = SGResolution(screenSize: view.bounds.size, canvasSize: scene.size)
        
        skView.presentScene(scene)

    }

//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Release any cached data, images, etc that aren't in use.
//    }
}
