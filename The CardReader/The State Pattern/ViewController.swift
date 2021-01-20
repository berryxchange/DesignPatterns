//
//  ViewController.swift
//  TheCardReader
//
//  Created by Quinton Quaye on 7/27/19.
//  Copyright © 2019 Quinton Quaye. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    var newCard = CardInfo(name: "Quinton Quaye", cardNumber: "232483u393u1029382983")
    
    var badCard = CardInfo(name: "Quinton Quaye", cardNumber: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func newCard(_ sender: Any) {
        let cardReader = CardReader()
        cardReader.start(card: newCard)
    }
    
    @IBAction func badCard(_ sender: Any) {
        let cardReader = CardReader()
        
        cardReader.start(card: badCard)
    }
    
    func failedAlert(){
        let alert = UIAlertController(title: "Card Reader", message: "card failed, please try again", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .destructive, handler: nil)
        
        alert.addAction(okAction)
        
        
        self.present(alert, animated: true)
    }
}

