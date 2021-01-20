import UIKit
// ValueTypes

struct Box {
    var initValue: Int
}

let box = Box(initValue: 0)
var otherBox = box
otherBox.initValue = 10
assert(box.initValue == 0)
//these don't share the same references, one is referencing (Box), the other is referencing (box: copied)
//assert(otherBox.initValue == 10)


//Strong References

/*
 
class Child{
}

class Parent{
  let children: [Parent]
}

let c = MyClass()
let other = myOtherClass(class: c)
 
*/

//WeakReferences (important for tagging two or more references!!) - “With weak references, you can safely store a reference to another object without increasing its retain count. This prevents creating cycles with all of the required safety. ”


class Task{
    let description: String
    weak var worker: Worker?
    init(description: String){
        self.description = description
    }
}

class Worker{
    var name: String
    var currentTask: Task?
    init(name: String) {
        self.name = name
    }
}

let worker = Worker(name: "John Snow")
let task = Task(description: "Night's Watch Commander")
worker.currentTask = task
task.worker = worker

print(worker.name)
// John Snow is the night's watcher

worker.currentTask = nil
//the task will be deallocated



//Unowned References - “You can use unowned references when you can guarantee that the owner of another object will never exist when the reference is deallocated. Let's look at the following example:”


class CreditCard {
    let number: String
    let expiry: String
    unowned let owner: Person //the unowned removes the Person reference by deallocating it. Without (unowned), the creditCard and person would cause a memory leak, if there was no person.
    
    init(owner: Person, number: String) {
        self.owner = owner
        self.number = number//"XXXXXXXXXXXXXXXX"
        self.expiry = "XX/YY"
    }
}

class Person {
    let name: String
    var cards: [CreditCard] = []
    
    init(name: String) {
        self.name = name
    }
}

//Using the API

let me = Person(name: "Quinton Quaye")
let card = CreditCard(owner: me, number: "1234567890")
let otherCard = CreditCard(owner: me, number: "0987654321")
me.cards = [card, otherCard]

for card in me.cards{
    print(card.number)
}
