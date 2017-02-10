//
//  ProfileGenerator.swift
//  Placeholder
//
//  Created by Eric Kueper on 2016-12-01.
//  Copyright © 2016 Softprint. All rights reserved.
//

import Foundation
import UIKit

class ProfileGenerator {
    
    class func generateImage(text: String, size: CGSize, backgroundColour: UIColor, textColour: UIColor) -> UIImage? {
        
        // rect for the image
        let rect = CGRect(origin: CGPoint.zero, size: size)
        
        // buffer he label by 10% vertically / horizontally
        let buffer = size.height * 0.05
        
        // set rect for the label
        let labelRect = CGRect(x: buffer, y: buffer, width: size.width - 2*buffer, height: size.height - 2*buffer)
        
        // create the label
        let label = UILabel(frame: labelRect)
        label.text = text
        label.textColor = textColour
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        
        // font may be too large, will adjust dynamically
        label.font = UIFont(name: "Avenir-Medium", size: size.height * 0.4)
        
        // being the graphics context
        UIGraphicsBeginImageContext(size)
        
        // draw the circle
        let circle = CircleView(frame: rect)
        circle.borderWidth = 8
        circle.borderColour = Colour.hizentraBlue
        circle.fill = true
        circle.fillColour = Colour.white
        circle.draw(rect)
        
        // draw the label on top
        label.drawText(in: labelRect)
        
        // generate the image
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        // end context
        UIGraphicsEndImageContext()
        
        // return the image
        return image
    }

    
}
