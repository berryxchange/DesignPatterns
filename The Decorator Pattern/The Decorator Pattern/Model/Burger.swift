//
//  Burger.swift
//  The Decorator Pattern
//
//  Created by Quinton Quaye on 7/18/19.
//  Copyright © 2019 Quinton Quaye. All rights reserved.
//

import Foundation

struct Order{
    var items: [Burger] = []
    var total: Double = 0
}

class OrderBurger{
    var burger: Burger = BaseBurger() // the buns

    func getTopping(toppingName: String){
        switch toppingName{
        case "ketchup":
            burger = WithToppings(burger: burger, topping: .ketchup)
        //return burger
        case "mayonase":
            burger = WithToppings(burger: burger, topping: .mayonase)
        //return burger
        case "lettuce":
            burger = WithToppings(burger: burger, topping: .lettuce)
        //return burger
        case "pickles":
            burger = WithToppings(burger: burger, topping: .pickles)
        //return burger
        case "onions":
            burger = WithToppings(burger: burger, topping: .onions)
        //return burger
        case "tomatoes":
            burger = WithToppings(burger: burger, topping: .tomatoes)
        //return burger
        case "mustard":
            burger = WithToppings(burger: burger, topping: .mustard)
        //return burger
        case "relish":
            burger = WithToppings(burger: burger, topping: .relish)
        //return burger
        default:
            break
        }
    }


    func getPatty(){
        burger = TheIncrediblePatty(burger: burger)
    }

    func getCheese(){
        burger = WithCheese(burger: burger)
    }

    func getTax(){
        burger = BurgerTax(burger: burger, tax: 0.08)
    }
}
