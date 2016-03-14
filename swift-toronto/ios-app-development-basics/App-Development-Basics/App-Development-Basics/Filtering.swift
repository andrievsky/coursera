//
//  Filtering.swift
//  Imagination
//
//  Created by Nick Andrievsky on 2/29/16.
//  Copyright © 2016 Nick Andrievsky. All rights reserved.
//

protocol Filtering{
    var minValue:Float {get}
    var maxValue:Float {get}
    func processImage(inout imafe:RGBAImage)
}