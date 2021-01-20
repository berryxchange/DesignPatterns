import UIKit

// Using Singletons - “A singleton is an object of which there can never be more than one instance in your program.”

class Earth{
    static let instance = Earth()
    
    private init() {
        
    }
    
    func spinAroundTheSun(){
        /* */
    }
}


let planetEarth = Earth.instance
planetEarth.spinAroundTheSun()


//1. Identify the class you want to refactor as a singleton, ensuring it doesn't grow in memory too much over time Make the initializer private. A singleton can never be instantiated from outside
//2. Add a static immutable member, which will be the single instance of your object
//3. Replace all occurrences of the now inaccessible constructor with the shared reference

