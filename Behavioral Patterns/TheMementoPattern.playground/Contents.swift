import UIKit

//The Memento Pattern

//the Originator - two responsibilites: create mementos for caretaker and restore its state using the setMemento method
protocol Originator{
    associatedtype MementoType //allows you to use the containing type as a substitute like a shared()
    
    func createMemento() -> MementoType
    mutating func setMemento(_ memento: MementoType)
}


//Caretaker
protocol CareTaker{
    associatedtype OriginatorType: Originator //allows you to use originator values
    
    var originator: OriginatorType { get set } //uses originator functions
    var mementos: [OriginatorType.MementoType] { get set }
    
    mutating func save()
    mutating func restore()
}


extension CareTaker{
    mutating func save(){
        mementos.append(originator.createMemento())
    }
    
    mutating func restore(){
        guard let memento = mementos.popLast() else { //removes the element
            return
        }
        originator.setMemento(memento)
        //print(memento)
    }
}
//end...

//implementing the memento pattern

struct Item {
    var name: String
    var done: Bool = false
}

extension Array: Originator{
    func createMemento() -> [Element] {
        return self
    }
    
    mutating func setMemento(_ memento: [Element]) {
        self = memento
    }
}


class ShoppingList: CareTaker{
    var list = [Item]()
    
    var mementos: [[Item]] = []
    var originator: [Item]{
        get {
            return list
        }
        set {
            list = newValue
        }
    }
    
    func add(_ name: String){
        list.append(Item(name: name, done: false))
        //print(list)
    }
    
    func toggle(itemAt index: Int){
            list[index].done.toggle()
    }
}


extension String{
    var strikeThrough: String{
        return self.reduce("") {
            (res, char) -> String in
            return res + "\(char)" + "\u{0336}"
        }
    }
}

extension Item: CustomStringConvertible{
    var description: String{
        return done ? name.strikeThrough: name
    }
}

extension ShoppingList: CustomStringConvertible{
    var description: String{
        return list.map{
           $0.description
        }.joined(separator: "\n")
    }
}


//ACTIONS

//create a shopping list
var shoppingList = ShoppingList()
// add some fish
shoppingList.add("Fish") //Action
//save to memento
shoppingList.save()
//add the karrots with a typo
shoppingList.add("Karrots") //Action

//restore to the previous state
shoppingList.restore() //undo


//Check the contents
print("1--\n\(shoppingList)\n\n")

//Add the proper carrots
shoppingList.add("Carrots") //Action
print("2 --\n\(shoppingList)\n\n")
shoppingList.save()

//Mark them pickedUp
shoppingList.toggle(itemAt: 1) //Action
print("3--\n\(shoppingList)\n\n")

//and restore (didnt pick the right one)
shoppingList.restore() //undo
print("4--\n\(shoppingList)\n\n")



