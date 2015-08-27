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

import SpriteKit

class LayerHUD: SKNode {
  
  //--Interface
  var throwCount:SKLabelNode!
  
  //--Buttons
  var jumpButton:SKLabelNode!
  var pauseButton:SKLabelNode!
  var throwButton:SKLabelNode!
  
  
  override init() {
    super.init()
    
    pauseButton = SKLabelNode(fontNamed: "MarkerFelt-Wide")
    pauseButton.fontSize = 42
    pauseButton.posByScreen(0.95, y: 0.95)
    pauseButton.fontColor = SKColor.whiteColor()
    pauseButton.alpha = 0.8
    pauseButton.horizontalAlignmentMode = .Right
    pauseButton.verticalAlignmentMode = .Top
    pauseButton.zPosition = 500
    pauseButton.text = "II"
    pauseButton.name = "pauseButton"
    addChild(pauseButton)
    
    jumpButton = SKLabelNode(fontNamed: "MarkerFelt-Wide")
    jumpButton.fontSize = 54
    jumpButton.posByScreen(0.95, y: 0.05)
    jumpButton.fontColor = SKColor.whiteColor()
    jumpButton.alpha = 0.8
    jumpButton.horizontalAlignmentMode = .Right
    jumpButton.verticalAlignmentMode = .Bottom
    jumpButton.zPosition = 500
    jumpButton.text = "Jump"
    jumpButton.name = "jumpButton"
    addChild(jumpButton)
    
    throwButton = SKLabelNode(fontNamed: "MarkerFelt-Wide")
    throwButton.fontSize = 54
    throwButton.posByScreen(0.05, y: 0.05)
    throwButton.fontColor = SKColor.whiteColor()
    throwButton.alpha = 0.8
    throwButton.horizontalAlignmentMode = .Left
    throwButton.verticalAlignmentMode = .Bottom
    throwButton.zPosition = 500
    throwButton.text = "Throw"
    throwButton.name = "throwButton"
    addChild(throwButton)
    
    throwCount = SKLabelNode(fontNamed: "MarkerFelt-Wide")
    throwCount.fontSize = 32
    throwCount.posByScreen(0.5, y: 0.02)
    throwCount.fontColor = SKColor.whiteColor()
    throwCount.alpha = 0.8
    throwCount.horizontalAlignmentMode = .Center
    throwCount.verticalAlignmentMode = .Bottom
    throwCount.zPosition = 500
    throwCount.text = "Daggers: 3"
    throwCount.name = "throwButton"
    addChild(throwCount)
    
  }

  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  func update(delta:CFTimeInterval) {
    
   // throwCount.text = "Daggers: \((3 - (self.parent as! GameScene).layerProjectile.children.count))"
    
  }
  
}
