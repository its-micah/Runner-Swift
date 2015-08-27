//
//  MainMenu.swift
//  DonutRun
//
//  Created by Micah Lanier on 8/18/15.
//  Copyright (c) 2015 Micah Lanier. All rights reserved.
//

import Foundation
import SpriteKit

class MainMenu: SGScene {

    override func didMoveToView(view: SKView) {
        let background = SKSpriteNode(imageNamed: "background4")
        background.posByCanvas(0.5, y: 0.5)
        background.xScale = 1.1
        background.yScale = 1.1
        background.zPosition = -1
        addChild(background)
    }


}
