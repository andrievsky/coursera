//
//  RedContrastFilter.swift
//  Imagination
//
//  Created by Nick Andrievsky on 2/29/16.
//  Copyright © 2016 Nick Andrievsky. All rights reserved.
//

class RedContrastFilter:Filtering{
    let minValue:Float = 0.0
    let maxValue:Float = 1.0
    let value:Float
    let amplifierValue:Float;
    let deamplifierValue:Float;
    init(value:Float){
        self.value = min(maxValue, max(minValue, value))
        amplifierValue = 1 + self.value
        deamplifierValue = 1 - self.value
    }
    
    func processImage(inout image:RGBAImage) {
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
