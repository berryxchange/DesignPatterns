//
//  ViewController.swift
//  The Memento Pattern
//
//  Created by Quinton Quaye on 7/20/19.
//  Copyright © 2019 Quinton Quaye. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // creating the shopping list:
    var shoppingList = ShoppingList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //add some fish
        shoppingList.addItem("Fish")
        // save to the memento
        shoppingList.save()
        
        // mew item added
        shoppingList.addItem("Karrots")
        print(shoppingList.list)
        
        // restore the previous list from memento
        shoppingList.restore() //
        print(shoppingList.list)
        
        
        // check the contents
        print("1--\n\(shoppingList)\n\n")
        
        // add the proper carrots
        shoppingList.addItem("Carrots")
        print("2--\n\(shoppingList)\n\n")
        shoppingList.save()
        print(shoppingList.mementos)
        //CareTaker Mementos: [[Fish, Carrots]]
        
        //mark the aquired items
        shoppingList.toggleItem(itemAt: 1)
        print("3--\n\(shoppingList)\n\n")
        print(shoppingList.mementos)
        
        // and restore (aquired the wrong item(s))
        shoppingList.restore()
        //CareTaker Mementos: []
        
        print("4--\n\(shoppingList)\n\n")
        print(shoppingList.mementos)
        
    }
}

