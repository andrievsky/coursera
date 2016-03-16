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

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        userInteractionEnabled = true
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
    
    public func isReady() -> Bool{
        return image != nil
    }
    
    public func clear(){
        image = nil
    }

}

public protocol ProcessedImageViewDelegate {
    func processedImageViewShow(view: ProcessedImageView)
    func processedImageViewHide(view: ProcessedImageView)
}