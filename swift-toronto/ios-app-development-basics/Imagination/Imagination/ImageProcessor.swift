//
//  ImageProcessor.swift
//  Imagination
//
//  Created by Nick Andrievsky on 2/29/16.
//  Copyright © 2016 Nick Andrievsky. All rights reserved.
//

import UIKit

class ImageProcessor{
    var image:RGBAImage
    
    init(image:UIImage){
        self.image = RGBAImage(image: image)!
    }
    
    let preset:[String: [Filtering]] = [
        "Weak Red": [RedContrastFilter(value: 0.2)],
        "Strong Red": [RedContrastFilter(value: 0.8)],
        "Weak Blur": [GaussianBlurFilter(value: 0.2)],
        "Strong Blur": [GaussianBlurFilter(value: 0.8)],
        "Complex": [RedContrastFilter(value: 0.8), GaussianBlurFilter(value: 0.2)]
    ]
    
    func addFilter(name filterName:String) -> ImageProcessor{
        if let filters = preset[filterName]{
            for filter in filters{
                addFilter(filter)
            }
        }
        return self
    }
    
    func addFilter(filter:Filtering) -> ImageProcessor{
        filter.processImage(&image)
        return self
    }
    
    func toUIImage() -> UIImage{
        return image.toUIImage()!
    }
}
