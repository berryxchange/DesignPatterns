//
//  The Memento.swift
//  The Memento Pattern
//
//  Created by Quinton Quaye on 7/20/19.
//  Copyright © 2019 Quinton Quaye. All rights reserved.
//

import Foundation

// a new shopping list App which can (add, edit, mark as done).

struct Item{
    var name: String
    var aquired: Bool = false
}

// represent the Orginator, Memento, CareTaker objects.

// the object(Originator) is an array
extension Array: Originator{
    func createMemento() -> [Element]{
        return self
    }
    
    // sets the object(Originator) with an array of data
    mutating func setMemento(_ memento: [Element]) {
        self = memento
    }
}


// the careTaker is the Shopping List

class ShoppingList: CareTaker{
   
    var originator: [Item] {
        get {
            return list
        } // pulls the items from the list or the array
        set {
            list = newValue //sets the new value of [Item]
        }
    }
    
    // The list (Item) is the Originator
    var mementos: [[Item]] = []
    
    
    var list = [Item]()
    // the memento will store the different states of the list when calling save() or restore().
    
    
    // add two conveinience methods to the list and toggle them
    
    func addItem(_ name: String) {
        list.append(Item(name: name, aquired: false))
    }
    
    func toggleItem(itemAt index:Int) {
        list[index].aquired.toggle()
    }
}

// for printing out shopping list nicely

extension String{
    var strikeThrough: String{
        return self.reduce("") {(res, char)-> String in
            return res + "\(char)" + "\u{0336}"
        }
    }
}

// a discription for the shopping items:
extension Item: CustomStringConvertible{
    var description: String{
        return aquired ? name.strikeThrough: name
    }
}

// enhance the description of the shopping list:

extension ShoppingList: CustomStringConvertible{
    var description: String{
        return list.map {
            $0.description
        }.joined(separator: "\n")
    }
}


