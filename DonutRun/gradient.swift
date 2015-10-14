//
//  gradient.swift
//  squares
//
//  Created by Adam Eccles on 25/01/2015.
//  Copyright (c) 2015 Squillop Media. All rights reserved.
//

import Foundation
import SpriteKit


class GradientBG: SKScene {
    
    func drawGradientImage(size: CGSize) -> UIImage {
        
        // Setup our context
        let bounds = CGRect(origin: CGPoint.zero, size: size)
        let opaque = false
        let scale: CGFloat = 0
        UIGraphicsBeginImageContextWithOptions(size, opaque, scale)
        let context = UIGraphicsGetCurrentContext()

        // gradient colours for a nice sky effect
        let topColour = UIColor(red:0.509, green:0.859, blue:1.000, alpha:1.000)
        let midColour = UIColor(red:0.610, green:0.952, blue:1.000, alpha:1.000)
        let bottomColour = UIColor(red:0.600, green:0.602, blue:1.000, alpha:1.000)
        
        // set up gradient array
        let gradientColours: [CGColor] = [topColour.CGColor, midColour.CGColor, bottomColour.CGColor]
        
        // set up gradient spread
        let gradientLocations: [CGFloat] = [0.0, 0.5, 1.0] // top, middle and bottom of the frame
        
        // now make a gradient that can be applied to the path rect
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        let gradient = CGGradientCreateWithColors(
            colorSpace,
            gradientColours,
            gradientLocations)
        
        // make a gradient layer
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColours
        gradientLayer.locations = gradientLocations
        
        // make a rectangle
        let topPoint = CGPointMake(bounds.width/2, bounds.height)
        let bottomPoint = CGPointMake(bounds.width/2, 0)
        
        // Setup complete, do drawing here
        CGContextDrawLinearGradient(context, gradient, bottomPoint, topPoint, [])
        
        // Drawing complete, retrieve the finished image and cleanup
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }

    
}

    