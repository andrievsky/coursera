//: Playground - noun: a place where people can play

import UIKit

let image = UIImage(named: "sample")!

// Process the image!



var rgbaImage:RGBAImage = RGBAImage(image: image)!

let imageWidth = rgbaImage.width
let imageHeight = rgbaImage.height

extension RGBAImage{
    mutating func addFilter(filter:Filtering) {
        var index:Int = 0;
        var originalPixels:[Pixel] = []
        for pixel in pixels {
            originalPixels.append(pixel)
        }
        for y in 0..<self.height {
            for x in 0..<self.width {
                pixels[index] = filter.processPixel(pixels[index], x: x, y: y, index:index, source:&originalPixels)
                index++
            }
        }
    }
    
    mutating func addFilters(filters:[Filtering]){
        for filter in filters{
            addFilter(filter)
        }
        
    }
}

protocol Filtering{
    var minValue:Float {get}
    var maxValue:Float {get}
    func processPixel(pixel: Pixel, x:Int, y:Int, index:Int, inout source:[Pixel]) -> Pixel
}

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
    
    func processPixel(var pixel: Pixel, x:Int, y:Int, index:Int, inout source:[Pixel]) -> Pixel {
        if pixel.red < 128{
            pixel.red = UInt8(Float(pixel.red) * deamplifierValue)
        } else {
            pixel.red = UInt8(min(Float(pixel.red) * amplifierValue, 255.0))
        }
        return pixel
    }

}

class GaussianBlurFilter:Filtering{
    let minValue:Float = 0.1
    let maxValue:Float = 1
    let value:Int
    let width:Int
    let height:Int
    init(value:Float, imageWidth:Int, imageHeight:Int){
        self.value = Int(min(maxValue, max(minValue, value)) * 3) + 1
        width = imageWidth
        height = imageHeight
    }
    
    func processPixel(var pixel: Pixel, x:Int, y:Int, index:Int, inout source:[Pixel]) -> Pixel {
        var count:Int = 0;
        var neighborPixel:Pixel?
        var neighborIndex:Int = 0;
        var red:Int = 0;
        var green:Int = 0;
        var blue:Int = 0;
        var neighborX:Int
        var neighborY:Int
        
        for newY in -1...1 {
            for newX in -1...1 {
                neighborX = newX * value + x
                neighborY = newY * value + y
                if neighborX < 0 || neighborX >= width || neighborY < 0 || neighborY >= height{
                    continue
                }
                neighborIndex = getIndex(neighborX, y: neighborY)
                neighborPixel = source[neighborIndex]
                if (neighborPixel != nil){
                    red += Int(neighborPixel!.red)
                    green += Int(neighborPixel!.green)
                    blue += Int(neighborPixel!.blue)
                    count++;
                }
            }
            if count > 0 {
                pixel.red = UInt8(red / count)
                pixel.green = UInt8(green / count)
                pixel.blue = UInt8(blue / count)
            }
        }
        
        return pixel
    }
    
    func getIndex(x:Int, y:Int) -> Int{
        return x + width * y
    }
    
}

let preset:[String: [Filtering]] = [
    "Weak Red": [RedContrastFilter(value: 0.2)],
    "Strong Red": [RedContrastFilter(value: 0.8)],
    "Weak Blue": [GaussianBlurFilter(value: 0.2, imageWidth: imageWidth, imageHeight: imageHeight)],
    "Strong Blur": [GaussianBlurFilter(value: 0.8, imageWidth: imageWidth, imageHeight: imageHeight)],
    "Complex": [RedContrastFilter(value: 0.8), GaussianBlurFilter(value: 0.2, imageWidth: imageWidth, imageHeight: imageHeight)]
]

func addFilterToImage(inout image:RGBAImage, filterName:String){
    if let filters = preset[filterName]{
        image.addFilters(filters)
    }
}

addFilterToImage(&rgbaImage, filterName: "Complex")

let newImage = rgbaImage.toUIImage()

print("Done")
