import UIKit


//Using a burger example from the cashiers point of view

//lets define a basic protocol which will encapsulate the price and the different ingredients in the current burger. In the decorator pattern, this protocol will represent the object that will be decorated over and over


public protocol Burger{
    var price: Double { get }
    var ingredients: [String] { get }
}

//takes the burger and makes into a decoratable object
public protocol BurgerDecorator: Burger{
    var burger: Burger { get }
}

// when you want to decorate the burger use extensions for actions
extension BurgerDecorator{
    public var price: Double {
        return burger.price
    }
    public var ingredients: [String]{
        return burger.ingredients
    }
}

//create structs for each item needed to be on the stage for use

public struct BaseBurger: Burger{
    //initialize the data
    public var price: Double = 1.0
    public var ingredients: [String] = ["Buns"]
}

//the addaption to a burger
public struct WithCheese: BurgerDecorator{
    public var burger: Burger // the original object
    public var price: Double {
        return burger.price + 0.5 // the original object + 0.5
    }
    public var ingredients: [String] {
        return burger.ingredients + ["Cheese"]
    }
}

public struct WithIncredibleBurgerPatty: BurgerDecorator {
    public var burger: Burger // the original object
    public var price: Double{
        return burger.price + 2.0 // the original object + 2.0
    }
    
    public var ingredients: [String]{
        return burger.ingredients + ["Incredible Patty"]
    }
}

// for toppings
enum Topping: String {
    case ketchup
    case mayonnaise
    case lettuce
    case tomato
    case pickle
    case relish
    case onion
    case specialSauce
}

struct WithTopping: BurgerDecorator{
    let burger: Burger
    let topping: Topping
    var ingredients: [String]{
        return burger.ingredients + [topping.rawValue]
    }
    var price: Double{
        return burger.price + 0.5
    }
}

extension Burger{
    func withTax(burger: Burger) -> Double{
        return burger.price * 0.10 + burger.price
    }
}

var burger: Burger = BaseBurger()
burger = WithTopping(burger: burger, topping: .mayonnaise)
burger = WithTopping(burger: burger, topping: .lettuce)
burger = WithTopping(burger: burger, topping: .tomato)
burger = WithTopping(burger: burger, topping: .pickle)
burger = WithTopping(burger: burger, topping: .onion)
burger = WithTopping(burger: burger, topping: .specialSauce)
burger = WithCheese(burger: burger)
burger = WithIncredibleBurgerPatty(burger: burger)
burger.withTax(burger: burger)
print(burger.ingredients)
print(burger.price)




//Going Further with Decorator Patterns Learn this to save time!!!!!!
extension Topping{
    func decorate(burger: Burger) -> WithTopping{
        return WithTopping(burger: burger, topping: self)
    }
}


//Topping.ketchup.decorate(burger: burger)
var decorators = [(Burger) -> Burger]()
decorators.append(Topping.ketchup.decorate)
decorators.append(WithCheese.init)
decorators.append(WithIncredibleBurgerPatty.init)
decorators.append(Topping.lettuce.decorate)

let reducedBurger = decorators.reduce(into: BaseBurger()) { burger, decorate in
    burger = decorate(burger)
}

print(reducedBurger)



//example coding:
public protocol Person{
    var details: [String: String] { get }
}

public protocol PersonDetail: Person{
    var person: Person { get }
    
}

public extension PersonDetail{
    var personDetail: [String: String]{
        return person.details
    }
}

protocol NameProtocol: PersonDetail{
    var firstName: String { get }
    var lastName: String { get }
    
}

protocol AgeProtocol: PersonDetail{
    var age: String { get }
}

protocol AddressableProtocol: PersonDetail{
    var address: String { get }
    var city: String { get }
    var state: String { get }
}


public struct Member: PersonDetail{
    public var person: Person
    public var memberFirstName: String
    public var details: [String : String]{
        return person.details //+ ["firstName": memberFirstName]
    }
}

//var thisMember: Person = Member(member: <#Person#>)
