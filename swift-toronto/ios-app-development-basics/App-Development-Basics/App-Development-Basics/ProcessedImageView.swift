//
//  ProcessedImageView.swift
//  App-Development-Basics
//
//  Created by Nick Andrievsky on 3/15/16.
//  Copyright © 2016 Nick Andrievsky. All rights reserved.
//
import UIKit

public class ProcessedImageView: UIImageView {
    
    public var delegate:ProcessedImageViewDelegate?
    private var imageProcessor:ImageProcessor?
    private var filter:Filter?
    private var value:Float = 0.0

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        userInteractionEnabled = true
    }
    
    public func recreate(image:UIImage){
        filter = nil
        self.image = image
        imageProcessor = ImageProcessor(image: image)
    }
    
    public func applyFilter(filter:Filter){
        self.filter = filter
        imageProcessor?.addFilter(preset: filter)
        updateImage()
    }
    
    public func adjust(value:Float){
        if filter == nil{
            return
        }
        let newValue = Float(round(10*value)/10)
        if self.value == newValue {
            return
        }
        self.value = newValue
        imageProcessor?.addFilter(preset: filter!, adjustment: newValue)
        updateImage()
    }
    
    private func updateImage(){
        image = imageProcessor?.toUIImage()
    }
    
    override public func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        hide()
    }
    
    override public func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        show()
    }
    
    public func show(){
        UIView.animateWithDuration(0.3, animations: {
            self.alpha = 1.0
        })
        delegate?.processedImageViewShow(self)
    }
    
    public func hide(){
        UIView.animateWithDuration(0.3, animations: {
            self.alpha = 0.0
        })
        delegate?.processedImageViewHide(self)
    }
    
    public func hasFilter() -> Bool{
        return filter != nil
    }

}

public protocol ProcessedImageViewDelegate {
    func processedImageViewShow(view: ProcessedImageView)
    func processedImageViewHide(view: ProcessedImageView)
}