/*
* Copyright (c) 2014 Neil North.
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

/*
The job of the introducer is to continue from the launch screen and do any further pre-loading for pre-game assets.
It also segues elegently to the scene as opposed to BAM! scene.
*/


import SpriteKit

class Introducer: SKScene {
  
  var logoSprite:SKSpriteNode?
  var isLoading = false
  
  override func didMoveToView(view: SKView) {
    GameConfiguration.sharedInstance.setGameScale()
    
    //Set a background color
    self.backgroundColor = SKColor.whiteColor()
    
    //Animate initial
    let atlas = SKTextureAtlas(named: "OtherAssets")
    logoSprite = SKSpriteNode(texture: atlas.textureNamed("myLogo"))
    logoSprite?.size = CGSizeMake(40, 40)
    logoSprite!.posByCanvas(0.5, y: 0.5)
    addChild(logoSprite!)
    
    let animInitial:SKAction = SKAction.group([SKAction.scaleTo(1.0, duration: 0.8),SKAction.fadeAlphaTo(1.0, duration: 0.6)])
    
    //Animate Fill
    let animFill:SKAction = SKAction.repeatActionForever(SKAction.sequence([SKAction.scaleTo(0.8, duration: 0.6),SKAction.scaleTo(1.0, duration: 0.6),
      SKAction.runBlock({ () -> Void in
        if (self.isLoading != true) {self.startLoadingAssets()}
    })]))
    
    //Animate
    
    if (logoSprite != nil) {
      //if (gameSettings?.objectForKey("Defaults")?.objectForKey("ALL-Introduce") as! Bool) {
        logoSprite!.alpha = 0.0
        logoSprite!.xScale = 0.0
        logoSprite!.yScale = 0.0
        logoSprite!.runAction(SKAction.sequence([animInitial,animFill]))
        
      //} else {
        logoSprite!.alpha = 1.0
        logoSprite!.xScale = 1.0
        logoSprite!.yScale = 1.0
        startLoadingAssets()
      //}
    }

  }
  
  func startLoadingAssets() {
    
    let startTime = CACurrentMediaTime()
    isLoading = true
    
    //Prepare textures to load
    var textureAtlasesArray : [SKTextureAtlas] = []
    let atlas01 = SKTextureAtlas(named: "DonutRun")
    textureAtlasesArray.append(atlas01)
    let atlas02 = SKTextureAtlas(named: "CoffeeBean")
    textureAtlasesArray.append(atlas02)
    let atlas03 = SKTextureAtlas(named: "Cop2")
    textureAtlasesArray.append(atlas03)
    let atlas04 = SKTextureAtlas(named: "DonutDoubleJump")
    textureAtlasesArray.append(atlas04)
    let atlas05 = SKTextureAtlas(named: "GoNutsFlash")
    textureAtlasesArray.append(atlas05)
    let atlas06 = SKTextureAtlas(named: "DonutJump")
    textureAtlasesArray.append(atlas06)
    let atlas07 = SKTextureAtlas(named: "DonutOneIdle")
    textureAtlasesArray.append(atlas07)
    let atlas08 = SKTextureAtlas(named: "DonutTwoIdle")
    textureAtlasesArray.append(atlas08)


    //Prepare sounds to load
    

    SKTextureAtlas.preloadTextureAtlases(textureAtlasesArray, withCompletionHandler: {
        gameTextures = textureAtlasesArray
        let endTime = CACurrentMediaTime()
        let timeDifference = endTime - startTime
        print(NSString(format: "Loaded Texture Atlases in %0.2f seconds", timeDifference))
        self.transitionToNextScene()

    })

    
  }
  
  func transitionToNextScene() {
    //let mainMenu = MainMenu(size: self.scene!.size)
    //let scene = Introducer(size: CGSize(width: 1024, height: 768))

    //let mainMenu = MainMenu(size: CGSize(width: 1024, height: 768))


    let mainMenu = MainMenu(size: CGSize(width: view!.bounds.size.width, height: view!.bounds.size.height))
    mainMenu.scaleMode = self.scaleMode
    self.view?.presentScene(mainMenu, transition: SKTransition.fadeWithDuration(2))

//    let endingMenu = EndingMenu(size: CGSize(width: view!.bounds.size.width, height: view!.bounds.size.height))
//    endingMenu.scaleMode = self.scaleMode
//    self.view?.presentScene(endingMenu, transition: SKTransition.fadeWithDuration(2))
  }
  
}
