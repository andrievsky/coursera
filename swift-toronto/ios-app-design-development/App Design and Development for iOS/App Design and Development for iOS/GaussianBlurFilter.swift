//
//  GaussianBlurFilter.swift
//  Imagination
//
//  Created by Nick Andrievsky on 2/29/16.
//  Copyright © 2016 Nick Andrievsky. All rights reserved.
//

struct RGBPixel {
    let red:UInt8
    let green:UInt8
    let blue:UInt8
}

class GaussianBlurFilter:Filtering{
    static let MIN_VALUE:Float = 0.0
    static let MAX_VALUE:Float = 1.0
    static let DEFAULT_VALUE:Float = 0.2
    static let TITLE = "Gaussian Blur"

    func processImage(inout image:RGBAImage, adjustment:Float?){
        let width = image.width
        let height = image.height
        let value = Int(10 * min(GaussianBlurFilter.MAX_VALUE, max(GaussianBlurFilter.MIN_VALUE, adjustment ?? GaussianBlurFilter.DEFAULT_VALUE)))
        let emptyPixel = RGBPixel(red: 0, green: 0, blue: 0)
        var newPixels:[RGBPixel] = [RGBPixel](count: image.pixels.count, repeatedValue: emptyPixel)
        
        var count:Int = 0
        var neighborPixel:Pixel?
        var neighborIndex:Int = 0
        var red:Int = 0
        var green:Int = 0
        var blue:Int = 0
        var neighborX:Int
        var neighborY:Int
        var index = 0
        for y in 0..<height{
            for x in 0..<width{
                red = 0
                green = 0
                blue = 0
                count = 0
                for newY in -1...1 {
                    for newX in -1...1 {
                        neighborX = newX * value + x
                        neighborY = newY * value + y
                        if neighborX < 0 || neighborX >= width || neighborY < 0 || neighborY >= height{
                            continue
                        }
                        neighborIndex = neighborX + width * neighborY
                        neighborPixel = image.pixels[neighborIndex]
                        if (neighborPixel != nil){
                            red += Int(neighborPixel!.red)
                            green += Int(neighborPixel!.green)
                            blue += Int(neighborPixel!.blue)
                            count += 1;
                        }
                    }
                }
                if count > 0 {
                    newPixels[index] = RGBPixel(red: UInt8(red / count), green: UInt8(green / count), blue: UInt8(blue / count))
                } else {
                    newPixels[index] = RGBPixel(red: image.pixels[index].red, green: image.pixels[index].green, blue: image.pixels[index].blue)
                }
                index += 1
            }
        }
        
        for index in 0..<image.pixels.count{
            image.pixels[index].red = newPixels[index].red
            image.pixels[index].green = newPixels[index].green
            image.pixels[index].blue = newPixels[index].blue
        }
    }
    
}