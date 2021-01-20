import UIKit

// The Strategy Pattern - The strategy Pattern only involves a few components:
//#1 Context Objects, which will have a strategy member
//#2 Strategy implementations that can be swapped at runtime

protocol Strategy {
    associatedtype ReturnType
    associatedtype ArgumentType
    func run(argument: ArgumentType) -> ReturnType
}


// Now for all the objects that neeed a different strategy, we can define a new context type. This type will need to have an associated StategyType, and keep a reference to the strategy:
protocol Context{
    associatedtype StrategyType: Strategy
    var strategy: StrategyType { get set }
}

//The Icecream Shop example

enum IceCreamPart{
    case waffer
    case cup
    case scoop(Int)
    case chocolateDip
    case candyTopping
    
    var price: Double{
        switch self{
        case .scoop:
            return 2.0
        default:
            return 0.25
        }
    }
}

//adding a debugging string is always welcome, as this will help ensure our program runs smoothly:

extension IceCreamPart: CustomStringConvertible{
    var description: String {
        switch self{
        case .scoop(let count):
            return "\(count)x scoops"
        case .waffer:
            return "1x waffer"
        case .cup:
            return "1x cup"
        case .chocolateDip:
            return "1x chocolate dipping"
        case .candyTopping:
            return "1x candy topping"
        }
    }
}

//lets jump to our billing strategies now. BillingStrategy is a simple protocol with a single method:

protocol BillingStrategy {
    func add(item: IceCreamPart) -> Double // the price of that item
}

class fullPriceStrategy: BillingStrategy {
    
    func add(item: IceCreamPart) -> Double {
        switch item{
        case .scoop(let count):
            return Double(count) * item.price
        default:
            return item.price
        }
    }
}


//*** lets say the manager wants to offer a promotion. If a customer buys more than two scoops of icecream, toppings will be offered at half price. lets add that strategy as well:

class HalfPriceToppings: fullPriceStrategy{
    override func add(item: IceCreamPart) -> Double {
        if case .candyTopping = item{
            return item.price / 2.0
        }
        return super.add(item: item)
    }
}

// now we will have a strategy that we can mutate externally, as well as the ability to add ice-creams, compute the total and print the receipt:

struct Bill{
    var strategy: BillingStrategy
    var items = [(IceCreamPart, Double)]()
    
    init(strategy: BillingStrategy){
        self.strategy = strategy
    }
    
    mutating func add(item: IceCreamPart){
        let price = strategy.add(item: item)
        items.append((item, price))
    }
    
    func total() -> Double{
        return items.reduce(0, { (total, item) -> Double in
            return total + item.1
        })
    }
}

extension Bill: CustomStringConvertible{
    var description: String{
        return items.map { (item) -> String in
            return item.0.description
                + " $\(item.1)"
            }.joined(separator: "\n")
            + "\n-------"
            + "\nTotal $\(total())\n"
    }
}

//#First Customer
// now lets welcome the first customer, and start a new bill:
var bill = Bill(strategy: fullPriceStrategy())
// The First customer wants a waffer
bill.add(item: .waffer)
//then he'll add a single scoop
bill.add(item: .scoop(1))
//then he'll add the candy toppings
bill.add(item: .candyTopping)
print(bill.description)



// now lets welcome the second customer, and start a new bill:

bill = Bill(strategy: fullPriceStrategy())
// this one will be in a cup
bill.add(item: .cup)
//3 scoops!
bill.add(item: .scoop(3))
//hooray!, toppings are half off
bill.strategy = HalfPriceToppings()
bill.add(item: .candyTopping)
print(bill)




//*** now the store manager has introduces a loyalty program. When a customer buys 5 icecreams, they'll get a sixth one for half price. Thanks to the strategyPattern, its very simple to implement this new price strategy a follows:

class HalfPriceStrategy: fullPriceStrategy{
    override func add(item: IceCreamPart) -> Double {
        return super.add(item: item) / 2.0
    }
}

// Now halfPriceStrategy can be applied for loyalty customers:

bill = Bill(strategy: HalfPriceStrategy())
bill.add(item: .waffer)
bill.add(item: .scoop(1))
bill.add(item: .candyTopping)
print(bill)

// as we can see, we've been able to add a new strategy on the fly to perform the calculations, without cluttering up Bill or IceCreamPart.
