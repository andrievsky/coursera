//
//  ImageState.swift
//  App-Development-Basics
//
//  Created by Nick Andrievsky on 3/15/16.
//  Copyright © 2016 Nick Andrievsky. All rights reserved.
//

public enum ImageStateProperty {
    case Init, Ready, Filters, Edit, Compare
}

public protocol ImageStateDelegate {
    func changedState(state:ImageStateProperty, previousState:ImageStateProperty)
}

public class ImageState {
    public var delegate:ImageStateDelegate?
    private var state:ImageStateProperty = .Init
    private var previousState:ImageStateProperty = .Init
    
    public func change(newState:ImageStateProperty){
        if(state == newState) {
            return
        }
        previousState = state
        state = newState
        update()
    }
    
    public func update(){
        delegate?.changedState(state, previousState: previousState)
    }
    
    public func getState() -> ImageStateProperty{
        return state
    }

}
