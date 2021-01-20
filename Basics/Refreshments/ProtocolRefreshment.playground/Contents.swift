import UIKit

// A refresher on protocols

protocol BasicProtocol {
    
}

protocol ComplexProtocol: BasicProtocol{
}


class MyClass: BasicProtocol, ComplexProtocol{
    
}

struct MyStruct: ComplexProtocol{
}

//protocols can be useful as we 've seen previously, but protocols are meant to provide requirements.

//#1 Properties, their type and accessability
//#2 Methods
//#3 Initializers

protocol demoProtocol{
    var aRequiredProperty: String { get set }
    var aReadOnlyProperty: Double { get }
    static var aStaticProperty: Int { get set }
    
    init(requiredProperty: String)
    
    func doSomething() -> Bool
}


// Mutation and value types

protocol Incrementing{
    func increment() -> Int
}


struct Counter: Incrementing{
    private var value: Int = 0
    func increment() -> Int {
        //value += 1
        return value
    }
}
// this will pose an error because the left side of self isnt mutable, so we will re-write the protocol Incrementing

protocol NewIncrementing{
    mutating func increment() -> Int
}

struct NewCounter: NewIncrementing{
    private var value: Int = 0
    mutating func increment() -> Int {
        value += 1
        return value
    }
}



var thisNumber = NewCounter()
thisNumber.increment()
thisNumber.increment()
thisNumber.increment()


//Protocols are full fledge types - you can use them anywhere you'd be able to use any other type:
//As a return type - parameter of a function
//As a member - variable or constant
//Within arrays, dictionaries, or other container types

protocol RunnerDelegate: class{
    func didStart(runner: Runner)
    func didStop(runner: Runner)
}

class Runner{
    weak var delegate: RunnerDelegate?
    
    func start(){
        //start the runner
        delegate?.didStart(runner: self)
        print("now starting the runner!")
    }
    
    func stop(){
        //stop the runner
        delegate?.didStop(runner: self)
        print("now stopping the runner!")
    }
    
    var runningCode = "Complete!"
}

class RunnerCaller{
    let runner = Runner()
    func callRunner(call: String){
        switch call {
        case "start":
            runner.start()
        case "stop":
            runner.stop()
        default:
            break
        }
    }
}

let thisRunner = RunnerCaller()
thisRunner.callRunner(call: "start")
thisRunner.callRunner(call: "stop")

