import UIKit
import CoreLocation

//Using Delegation
class LocationAware: NSObject{
    let manager = CLLocationManager()
    
    override init(){
        super.init()
        manager.delegate = self
    }
}

extension LocationAware: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        // do something with the updated location
    }
    /* more delegation methods */
}



//Implementing Delegation

//Step - is mearly a simple abstraction over a recipe step

//3
protocol StepDelegate: NSObjectProtocol{
    func didComplete(step: Step)
}

protocol RecipeCookingManagerDelegate: NSObjectProtocol{// “RecipeCookingManagerDelegate is responsible for communicating back to the creator, application, or manager when the recipe is complete or the cooking is cancelled and the user wants to exit the current step”
    
    func manager(_ manager: RecipeCookingManager, didCookRecipe: Recipe)
    func manager(_ manager: RecipeCookingManager, didCancelRecipe: Recipe)
    
}



//1
class Step: Equatable{ //
    let instructions: String = ""
    weak var delegate: StepDelegate? // makes the object a weak connection for deallocation
}

//2
class Recipe{
    let steps: [Step]
    init(steps: [Step]) {
        self.steps = steps
    }
    
    func step(after: Step) -> Step? { /* Implement me */ }
    func step(before: Step) -> Step? { /* Implement me */ }
}

//5
class RecipeCookingManager: NSObject{ //“RecipeCookingManager is responsible for coordinating the user experience involved in cooking a recipe”
    
    weak var delegate: RecipeCookingDelegate?
    private let recipe: Recipe
    
    init(recipe: Recipe) {
        self.recipe = recipe
    }
    
    func start(){
        guard let step = recipe.steps.first else {
            fatalError()
        }
        run(step: step)
    }
    
    private func run(step: Step){
        step.delegate = self
        // Make the step available to the UI layer, present it etc....
        // When the user finishes the stepm ensure to call step.complete step.complete()
    }
}

//6
class AutomatedCooker: NSObject, RecipeCookingManagerDelegate{
    func cook(recipe: Recipe){
        let manager = RecipeCookingManager(recipe: recipe)
        manager.delegate = self // self is RecipeCookingManagerDelegate
        manager.start() // start cooking the first step should be in progress!
        
        /* complete all steps */
        recipe.steps.forEach{ $0.complete() }
        // the did cook method should have been called!
    }
    func manager(_ manager: RecipeCookingManager, didCookRecipe: Recipe){
        //we are done!
    }
    
    func manager(_ manager: RecipeCookingManager, didCancelRecipe: Recipe){
        //The user cancelled
    }
}

//4
extension Step{
    func complete(){
        delegate?.didComplete(step: self)
    }
}

extension RecipeCookingManager: StepDelegate{
    func didComplete(step: Step) {
        step.delegate = nil // no need for the delegate anymore
        if let nextStep = recipe.step(after: step){
            run(step: nextStep)
        }else {
            delegate?.manager(self, didComplete:recipe)
        }
    }
}


