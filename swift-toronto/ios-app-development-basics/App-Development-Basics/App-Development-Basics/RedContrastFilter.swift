//
//  RedContrastFilter.swift
//  Imagination
//
//  Created by Nick Andrievsky on 2/29/16.
//  Copyright © 2016 Nick Andrievsky. All rights reserved.
//

class RedContrastFilter:Filtering{
    static let MIN_VALUE:Float = 0.0
    static let MAX_VALUE:Float = 1.0
    static let DEFAULT_VALUE:Float = 0.5
    static let TITLE = "Red Contrast"
    
    func processImage(inout image:RGBAImage, adjustment:Float?){
        let value = min(RedContrastFilter.MAX_VALUE, max(RedContrastFilter.MIN_VALUE, adjustment ?? RedContrastFilter.DEFAULT_VALUE))
        let amplifierValue = 1 + value
        let deamplifierValue = 1 - value
        
        var red:UInt8
        for index in 0..<image.pixels.count{
            red = image.pixels[index].red
            if red < 128{
                image.pixels[index].red = UInt8(Float(red) * deamplifierValue)
            } else {
                image.pixels[index].red = UInt8(min(Float(red) * amplifierValue, 255.0))
            }
        }
    }
}
