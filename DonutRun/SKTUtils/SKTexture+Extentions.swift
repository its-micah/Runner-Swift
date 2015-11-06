//
//  SKTexture+Extentions.swift
//  DonutRun
//
//  Created by Mick Lerche on 11/3/15.
//  Copyright © 2015 Grumpy Dane Studios. All rights reserved.
//

import SpriteKit

public extension SKTexture {

    public static func createAtlas(atlasNamed: String, numberOfImages: Int) -> Array<SKTexture> {
        let textureAtlas = SKTextureAtlas(named:atlasNamed + ".atlas")

        var spriteArray = Array<SKTexture>()
        for var i = 1; i <= numberOfImages; i++ {
            spriteArray.append(textureAtlas.textureNamed(atlasNamed + "_" + String(i)))
        }

        return spriteArray
    }
}



