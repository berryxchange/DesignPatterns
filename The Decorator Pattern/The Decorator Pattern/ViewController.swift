//
//  ViewController.swift
//  The Decorator Pattern
//
//  Created by Quinton Quaye on 7/18/19.
//  Copyright © 2019 Quinton Quaye. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    //implementation
    
    
    let burger = OrderBurger()
    
    var order: [Burger] = []
    var total: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    func getRoyalWithCheeseburger(){
        burger.getPatty()
        burger.getCheese()
        //ask for toppings
        var toppings: [String] = []
        let alert = UIAlertController(title: "Burger Builder", message: "Would you like to add any toppings?", preferredStyle: .alert)
        let pickles = UIAlertAction(title: "Pickles", style: .default, handler: { alert in
            toppings.append("pickles")
        })
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        alert.addAction(pickles)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
        
        for topping in toppings{
            burger.getTopping(toppingName: topping)
        }
        burger.getTax()
        order.append(burger.burger)
        burger.burger = BaseBurger()
    }

    func getRegularNoCheeseburger(){
        burger.getPatty()
        //ask for toppings
        askForToppings()
    }
    
    @IBAction func button(_ sender: Any) {
        getRegularNoCheeseburger()
        
    }
    
    
    @IBAction func totalButton(_ sender: Any) {
        getTotal()
    }
    
    
    func getSubTotal()-> [String]{
        var totalText = [String]()
        //getTax()
        self.total += self.burger.burger.price
        //order.append(burger)
        for (index,item) in order.enumerated(){
            //print("item: \(index + 1) \n--------\nIngredients:\n\n\(item.ingredients.joined(separator: "\n")) \n--------\nTotal: \(item.price) \n--------")
             totalText.append("item: \(index + 1) \n--------\nIngredients:\n\n\(item.ingredients.joined(separator: "\n")) \n--------\nTotal: \(item.price) \n--------")
        }
        return totalText
    }
    
    func getTotal(){
        let taxTotal = total * 0.05 + total
        print("Total Items: \(order.count)")
        print("Total: $\(taxTotal)")
        //send order to backend to prepare
        let subtotal = getSubTotal()
        let prepOrder = "\n\norder#: 193838wj32 \n--------\n\(subtotal.joined(separator: "\n\n"))\n\n"
        print(prepOrder)
        order = []
       total = 0
    }
    
    func askForToppings(){
        var arrayOfTopping: [String] = []
        let alert = UIAlertController(title: "Burger Builder", message: "Would you like to add any toppings?", preferredStyle: .alert)
        let pickles = UIAlertAction(title: "Pickles", style: .default, handler: { alert in
            arrayOfTopping.append("pickles")
            self.burger.getTopping(toppingName: "pickles")
            self.order.append(self.burger.burger)
            
            self.getSubTotal()
            self.burger.burger = BaseBurger()
        })
        let onions = UIAlertAction(title: "Onions", style: .default, handler: { alert in
            arrayOfTopping.append("onions")
            self.burger.getTopping(toppingName: "Onions")
            self.order.append(self.burger.burger)
            
            self.getSubTotal()
            self.burger.burger = BaseBurger()
        })
        let noTopping = UIAlertAction(title: "None", style: .default, handler: { alert in
            self.order.append(self.burger.burger)
            self.getSubTotal()
            self.burger.burger = BaseBurger()
        })
        let cheese = UIAlertAction(title: "Cheese", style: .default, handler: { alert in
            self.burger.getCheese()
            self.order.append(self.burger.burger)
            self.getSubTotal()
            self.burger.burger = BaseBurger()
        })
        
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        alert.addAction(pickles)
        alert.addAction(onions)
        alert.addAction(noTopping)
        alert.addAction(cheese)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
        //for topping in arrayOfTopping{
          //  getNewTopping(thisTopping: topping)
        //}
       
        //return arrayOfTopping
        
    }
}

