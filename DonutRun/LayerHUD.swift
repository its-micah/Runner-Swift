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
  

  var pauseButton:SKLabelNode!

  
  override init() {
    super.init()
    
    pauseButton = SKLabelNode(fontNamed: "Futura")
    pauseButton.fontSize = 44
    pauseButton.position = CGPointMake(450, 250)
    pauseButton.fontColor = UIColor(red: 244 / 255, green: 102 / 255, blue: 186 / 255, alpha: 1.0)
    pauseButton.horizontalAlignmentMode = .Right
    pauseButton.verticalAlignmentMode = .Top
    pauseButton.zPosition = 1
    pauseButton.text = "II"
    pauseButton.name = "pauseButton"
    addChild(pauseButton)


  }

  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  func update(delta:CFTimeInterval) {
    

  }
  
}
