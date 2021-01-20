//
//  Decorators.swift
//  The Decorator Pattern
//
//  Created by Quinton Quaye on 7/18/19.
//  Copyright © 2019 Quinton Quaye. All rights reserved.
//

import Foundation


// this protocol will represent the object that will be decorated over and over

public protocol Burger{
    // main pieces of the object
    var price: Double { get }
    var ingredients: [String] { get }
}

// the object to be decorated - it also conforms to the type that defines the base object being decorated:

public protocol BurgerDecorator: Burger{
    // main object
    var burger: Burger { get }

}

//if no other requirement is implemented in the BurgerDecorator, we can use the extension for optional items

extension BurgerDecorator{
    // here we are going to link the functions from the main object to return as the burger being decorated.
    
    public var price: Double{
        return burger.price
    }
    public var ingredients: [String]{
        return burger.ingredients
    }
}

// the root of the object
public struct BaseBurger: Burger{
    //set the data for each object piece
    public var price: Double = 1.0
    
    public var ingredients: [String] = ["Buns"]
    
}


// now create structs of each add-on the object will optionally be accessable to using.

//#1 - the Cheese
public struct WithCheese: BurgerDecorator{
    public let burger: Burger
    
    public var price: Double{
        return burger.price + 0.50
    }
    
    public var ingredients: [String]{
        // here you will use the "+ ["object"]" to add towards the array
       return burger.ingredients + ["Cheese"]
    }
}


//#2 the Patty
public struct TheIncrediblePatty: BurgerDecorator{
    public var burger: Burger
    
    public var price: Double{
       return burger.price + 2.0
    }
    
    public var ingredients: [String]{
        return burger.ingredients + ["Burger Patty"]
    }
}



//for multiple items of a category, we can use an enum of objects to return as strings in raw-value

enum Topping: String{
    case ketchup
    case mayonase
    case lettuce
    case pickles
    case onions
    case tomatoes
    case mustard
    case relish
}

extension Topping{
    func getTopping(burger: Burger) -> WithToppings{
        return WithToppings(burger: burger, topping: self)
    }
}


struct WithToppings: BurgerDecorator{
    var burger: Burger
    // these are free, so no need to add price
    // tie enum to the object
    var topping: Topping
    var ingredients: [String]{
        return burger.ingredients + [topping.rawValue]
    }
}



struct BurgerTax: BurgerDecorator{
    var burger: Burger
    
    var tax: Double = 0.0
    var price: Double{
        return burger.price * tax + burger.price.rounded()
    }
}

struct TenPercentDiscount: BurgerDecorator {
    var burger: Burger
    
    var percentDiscount: Double = 0.10
    var price: Double {
        return burger.price * percentDiscount - burger.price
    }
}

