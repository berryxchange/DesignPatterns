//
//  CardReader.swift
//  The State Pattern
//
//  Created by Quinton Quaye on 7/27/19.
//  Copyright © 2019 Quinton Quaye. All rights reserved.
//

import UIKit


struct CardInfo{
    
    
    var name: String
    var cardNumber: String
    func readCardInfo(){
        print("Name on Card: \(self.name)")
    }
    
    func checkCard()-> Bool{
        return true
    }
}

struct ReadError{
    var error: String
}

enum State{
    case unknown
    case waiting
    case reading
    case read(CardInfo)
    case failed(ReadError)
}

class CardReader{
    
    var viewController = ViewController()
   
    // implement the state with the enum, with all the possible state views as follows:
    
    
    var readCardError = ReadError(error: "Cannot read card at this time..")
    
    
    private var state: State = .unknown
    
    private var transactionComplete: Bool = true
    
    
    func start(card: CardInfo){
        transactionComplete = false
        while transactionComplete == false{
            
            switch state{
            case .unknown:
                state = .waiting
                print("\(state)")
            case .waiting:
                
                //print("waiting..")
                // when waiting, we wait for a card to be detected by the radio, when the card is detected, we change the state to reading
                if seenCard(card: card){
                    state = .reading
                }else{
                state = .failed(readCardError)
                print(readCardError.error)
                }
            case .reading:
                //print("reading")
                //when reading, we'll wait for this to complete. If it succeeds, we will change the state to read(CardInfo), or otherwise indicate failure as follows:
                if readCard(card: card) == true{
                    state = .read(card)
                }else {
                    //print("Failed..")
                     state = .failed(readCardError)
                    print(readCardError.error)
                }
            case .read(_):
                //print("has read card..")
                //Card is read
                //now we can do something
                print("hello, \(card.name)! please enter.")
                sleep(1)
                print("Now opening bay doors..")
                
                transactionComplete = true
                state = .unknown
                
                //state = .waiting
                
                
            case .failed(_):
                // Display an error message on the screen
               
                //viewController.failedAlert()
                
                // prompt to restart after a few seconds
                
                transactionComplete = true
                state = .unknown
                //state = .waiting
                
            }
            sleep(1)
        }
        print("Welcome To Q Enterprises")
    }
    
    func readCard(card: CardInfo)-> Bool{
        if  card.cardNumber != ""{
            print("data has been verified!")
            return true
        }else{
            
            print("no data exists!")
            
            return false
        }
    }
    
    func seenCard(card: CardInfo) -> Bool{
        if card.cardNumber != ""{
            print("data has been seen, now reading...")
            return true
        }else{
            print("no data exists!")
            sleep(1)
            return false
        }
    }
    
}

