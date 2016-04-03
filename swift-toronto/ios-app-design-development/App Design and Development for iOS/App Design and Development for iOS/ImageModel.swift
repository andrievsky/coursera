//
//  ImageModel.swift
//  App Design and Development for iOS
//
//  Created by Nick Andrievsky on 4/3/16.
//  Copyright © 2016 Nick Andrievsky. All rights reserved.
//

import UIKit

public class ImageModel: NSObject {
    
    static private let instance = ImageModel()
    
    static public func getInstance() -> ImageModel {
        return instance
    }
    
    private var image:UIImage = UIImage()
    
    public func update(withImage image:UIImage) {
        self.image = image
    }
    
    public func getImage() -> UIImage {
        return self.image
    }
    
}
