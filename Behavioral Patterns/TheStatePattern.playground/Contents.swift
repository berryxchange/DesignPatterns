import UIKit

//The State Pattern - helps you decouple the behavior of an object, often called the context, from its internal state. For each state, the state object will implement the specific behaviors, keeping the context clean and concise.

//The Card Reader


class CardReader{
    
    enum State{
        case unknown
        case waiting
        case reading
        case read(CardInfo)
        case failed
    }
    
    //use the private var state property so that no one can mutate the state from outside
    private var state: State = .unknown
    
    //the main routine - for each loop, it will print the current state:
  
    
    func start(){
        while true{
            print("\(state)")
            switch state {
            case .unknown:
                state = .waiting
            case .waiting: if seenCard(){
                state = .reading
                }
            case .reading:
            //while reading, we will wait for this to complete. if it succeeds, we will change the state to read, otherwise, we will indecate the failure as follows:
                if readCard(){
                    state = .read(CardInfo())
                }else{
                    state = .failed(ReadError())
                }
            case .read(_):
                // Card is read
                //now opening the doors
                state = .waiting
            case .failed(_):
                //display an error message on the screen
                //prompt to restart after a few seconds
                state = .waiting
            }
            sleep(1)
        }
    }
}



let reader = CardReader()
reader.start()
