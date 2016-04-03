//
//  AdditionalView.swift
//  App-Development-Basics
//
//  Created by Nick Andrievsky on 3/16/16.
//  Copyright © 2016 Nick Andrievsky. All rights reserved.
//

private enum AdditionalViewState{
    case Open, Opening, Closing, Closed
}

import UIKit

public class AdditionalView: UIView {
    private var currentView:UIView?
    private var nextView:UIView?
    private var state:AdditionalViewState = .Closed
    
    public func open(newView:UIView){
        if(newView.translatesAutoresizingMaskIntoConstraints) {
            newView.translatesAutoresizingMaskIntoConstraints = false
        }
        if state != .Closed {
            if nextView != newView {
                nextView = newView
            }
            if state == .Open || state == .Opening {
                close()
            }
            return
        }
        state = .Opening
        if newView != currentView {
            currentView = newView
            self.addSubview(newView)
            
            let leftConstraint = newView.leftAnchor.constraintEqualToAnchor(self.leftAnchor)
            let rightConstraint = newView.rightAnchor.constraintEqualToAnchor(self.rightAnchor)
            let bottomConstraint = newView.bottomAnchor.constraintEqualToAnchor(self.bottomAnchor)
            let topConstraint = newView.topAnchor.constraintEqualToAnchor(self.topAnchor)
            NSLayoutConstraint.activateConstraints([leftConstraint, rightConstraint, bottomConstraint, topConstraint])
            self.layoutIfNeeded()
        }
        alpha = 0.0
        UIView.animateWithDuration(0.3, animations: {
            self.alpha = 1.0
            }, completion: {
                done in
                if done {
                    self.state = .Open
                }
            })
    }
    
    public func close(){
        if state == .Closing || state == .Closed {
            return
        }
        state = .Closing
        UIView.animateWithDuration(0.3,
            animations: {
                self.alpha = 0.0
            },
            completion: {
                _ in
                self.currentView!.removeFromSuperview()
                self.currentView = nil
                self.state = .Closed
                if self.nextView != nil {
                    let view = self.nextView
                    self.nextView = nil
                    self.open(view!)
                }
            }
        )
    }
    
    public func isOpen() -> Bool{
        return state == .Open || state == .Opening
    }
}
