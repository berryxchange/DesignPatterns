import UIKit

//The Visitor Pattern - it is posible to abstract the visitor pattern through a series of protocols:

protocol Visitor{
    func visit<T>(element: T) where T: Visitable
}

protocol Visitable{
    func accept(visitor: Visitor)
}

//default implementation for our visitable nodes
extension Visitable{
    func accept(visitor: Visitor){
        visitor.visit(element: self)
    }
}

//Convenience on Array for visitable
extension Array: Visitable where Element: Visitable{
    func accept(visitor: Visitor) {
        visitor.visit(element: self)
        forEach{
            visitor.visit(element: $0)
        }
    }
}



//-------------

//Contributors, Thankyou notes & The Visitor Pattern

struct Contribution{
    let date: Date
    let author: String
    let email: String
    let details: String
}

// need to make the contribution object visitable so we can use the Visitors on them:

extension Contribution: Visitable{
    
}


// the logger visitor, This demonstrates the power of the visitor pattern - being able to swap the algorithym without touching the underlying objects. from a single dataset(the list of contributions), it is possible to design multiple algorithyms, as follows:

class LoggerVisitor: Visitor{
    func visit<T>(element: T) where T : Visitable {
        guard let contribution = element as? Contribution else{
            return
        }
        //print("\(contribution.author) / \(contribution.email)")
    }
}

let visitor = LoggerVisitor()

[
    Contribution(date: Date(), author: "Contributor", email: "my@email.com", details: ""),
    Contribution(date: Date(), author: "Contributor2", email: "my-other@email.com", details: "")
].accept(visitor: visitor)


// Now that we know how the protocol-base logic works, we can implement a proper visitor that will collect the contributor's cotact details in order to send them a nice thank you note:

let threeDaysAgo = Calendar.current.date(byAdding: .day, value: -3, to: Date())!
let fourDaysAgo = Calendar.current.date(byAdding: .day, value: -4, to: Date())!

class ThankYouVisitor: Visitor{
    var contributions = [Contribution]()
    
    func visit<T>(element: T) where T : Visitable {
        guard let contribution = element as? Contribution else{
            return
        }
        // Check that the contribution was done between 3 and 4 days ago
        
        if contribution.date <= threeDaysAgo && contribution.date >= fourDaysAgo{
            contributions.append(contribution)
        }
    }
    
    func sendThanks(_ visitor: Contribution){
        print("Thank You \(visitor.author) for your visit, please come back soon!")
    }

    func addVisitor(_ visitor: Contribution){
        contributions.append(visitor)
    }
}

// create an instance of the visitor
let thanksVisitor = ThankYouVisitor()

// Visit this contribution
let newContribution = Contribution(date: threeDaysAgo, author: "John Snow", email: "John@WhiteSnow.com", details: "...")

thanksVisitor.addVisitor(newContribution)

let allContributions: [Contribution] = [] // get all contributions

allContributions.accept(visitor: thanksVisitor) //visit all contributions

//send thanks!
thanksVisitor.contributions.forEach {
    thanksVisitor.sendThanks($0)
}

