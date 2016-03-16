//
//  ImageProcessor.swift
//  Imagination
//
//  Created by Nick Andrievsky on 2/29/16.
//  Copyright © 2016 Nick Andrievsky. All rights reserved.
//

public protocol Filtering{
    static var MIN_VALUE:Float {get}
    static var MAX_VALUE:Float {get}
    static var DEFAULT_VALUE:Float {get}
    static var TITLE:String {get}
    
    func processImage(inout imafe:RGBAImage, adjustment:Float?)
}

public enum Filter{
    case GaussianBlur, RedContrast
    
    public static func getTitle(filter:Filter) -> String{
        switch filter{
        case .RedContrast:
            return RedContrastFilter.TITLE
        case .GaussianBlur:
            return GaussianBlurFilter.TITLE
        default: return ""
        }
    }
}

import UIKit

public class ImageProcessor{
    private var sourceImage:RGBAImage
    private var filteredImage:RGBAImage
    
    init(image:UIImage){
        sourceImage = RGBAImage(image: image)!
        filteredImage = RGBAImage(image: image)!
    }
    
    static public let FILTERS:[Filter: Filtering] = [
        .RedContrast: RedContrastFilter(),
        .GaussianBlur: GaussianBlurFilter()
    ]
    
    public func addFilter(preset filter:Filter){
        if let aFilter = ImageProcessor.FILTERS[filter] {
            addFilter(aFilter, adjustment: nil)
        }
    }
    
    public func addFilter(preset filter:Filter, adjustment:Float){
        if let aFilter = ImageProcessor.FILTERS[filter] {
            addFilter(aFilter, adjustment: adjustment)
        }
    }
    
    public func addFilter(filter:Filtering, adjustment:Float?){
        refreshImage()
        filter.processImage(&filteredImage, adjustment: adjustment)
    }
    
    public func toUIImage() -> UIImage{
        return filteredImage.toUIImage()!
    }
    
    private func refreshImage(){
        filteredImage = RGBAImage(image: sourceImage.toUIImage()!)!
    }
}
