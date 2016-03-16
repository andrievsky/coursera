//
//  ImageUtil.swift
//  App-Development-Basics
//
//  Created by Nick Andrievsky on 3/16/16.
//  Copyright © 2016 Nick Andrievsky. All rights reserved.
//

import UIKit

class ImageUtil {
    static func resize (inout image:UIImage, sizeChange:CGSize)-> UIImage{
        
        let hasAlpha = true
        let scale: CGFloat = 0.0 // Use scale factor of main screen
        
        UIGraphicsBeginImageContextWithOptions(sizeChange, !hasAlpha, scale)
        image.drawInRect(CGRect(origin: CGPointZero, size: sizeChange))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        return scaledImage
    }

}
