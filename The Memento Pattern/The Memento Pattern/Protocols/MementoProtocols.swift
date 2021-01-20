//
//  MementoProtocols.swift
//  The Memento Pattern
//
//  Created by Quinton Quaye on 7/20/19.
//  Copyright © 2019 Quinton Quaye. All rights reserved.
//

import Foundation

// Requires the implementation of three distinct entities:

//#1 Memento: a representation of the internal state of the originator, which should be immutable - (A state of a utilized object)

//#2 Originator: the original object that can produce and consume the momento, in order to save and restore its own state - (a utilized object)

//#3 Caretaker: an external object that stores and restores a momento to an originator - (a "Saving Haven - Restorer")


protocol Originator{
    associatedtype MementoType
    
    func createMemento()-> MementoType
    
    mutating func setMemento(_ memento: MementoType) // sets the state back to its memorized state the momento saved
    
}


protocol CareTaker {
    associatedtype OriginatorType: Originator
    var originator: OriginatorType { get set } // ability to be accessed and changed
    
    var mementos: [OriginatorType.MementoType] { get set } // ability to be accessed and changed
    
    mutating func save()
    mutating func restore()
}

//now caretaker has a reference to the Originator as it should be able to get and restore Memento objects from it


extension CareTaker{
    mutating func save(){
        mementos.append(originator.createMemento()) // creating a new
        print("CareTaker Mementos: \(mementos)")
    }
    
    mutating func restore(){
        // from the mementos array, whatever item was lastly saved, will be brought back to life and applied to the object.
        guard let memento = mementos.popLast() else{
            return
        }
        
        originator.setMemento(memento) // sets the memento to the object
    }
}
