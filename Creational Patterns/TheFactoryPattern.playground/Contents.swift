import UIKit

//The factory Pattern - “The factory method pattern is designed to solve the following design problems:

//1. How to create different implementations of your objects, based on the creator class
//2. How to let subclasses define how to instantiate your objects”

//“The factory method pattern lets you decouple the call site from the instantiation site in your code. This makes it easier to refactor, update, or change the instantiation of the target object without compromising the consuming part of your code.”

// Let's say you're building an app that let users poke, message, or call their contacts, as follows:

enum ContactAction{
    case call
    case message
    case poke
}

class ContactController: UIViewController{
    
    // The Problematic Fixed Button Attributes - will have to write everytime you create a new button:
    
    //let callButton = UIButton(title: "Call", target: self, action: #selector(processAction(from:)))
    //let messageButton = UIButton(title: "Message", target: self, action: #selector(processAction(from:)))
    //let pokeButton = UIButton(title: "Poke", target: self, action: #selector(processAction(from:)))
    
    
    //refactored code from above^ - creating the button
    lazy var callButton = makeButton(for: .call)
    lazy var messageButton = makeButton(for: .message)
    lazy var pokeButton = makeButton(for: .poke)
    
    //refactored code for above^ function for making the button
    func makeButton(for action: ContactAction)-> UIButton{

        let button = UIButton()
        button.titleLabel?.text = action.localizedTitle
        button.addTarget(self, action: #selector(processAction(from:)), for: .touchUpInside)
        // additional common configuration for the button
        return button
    }
    
    /*
    @objc func processAction(from button: UIButton){
        let action = self.action(for: button)
        let controller: UIViewController?
        
        switch action {
        case .call:
            controller = callController()
        case .message:
            controller = messageController()
        case .poke:
            controller = pokeController()
            // TODO: confirm the poke is sent
            controller = nil
        }
        
        guard let viewController = controller else {
            return
        }
        presentViewControllerAsModalWindow(viewController)
    }
 */
    
    //refactored code for above^ - function which handles the action of the button
    @objc private func processAction(from button: UIButton){
        handle(action: action(for: button))
    }
    
    // sends which Contact Action the button is, to be acted upon
    private func action(for button: UIButton) -> ContactAction{
        switch button {
        case callButton:
            return .call
        case messageButton:
            return .message
        case pokeButton:
            return .poke
        default:
            fatalError("Unknown button")
        }
    }
    
    
    //------------------
    
    /*func handle(action: ContactAction){
        let controller: UIViewController?
        switch action {
        case .call:
            controller = CallController()
        case .message:
            controller = MessageController()
        case .poke:
            controller = PokeController()
            // TODO: confirm the poke is sent
            controller = nil
        }
        
        guard let viewController = controller else {
            return
        }
        presentViewControllerAsModalWindow(viewController)
    }*/
    
    
    //refactoring the code above^ - handles the type of ContactAction which is passed through
    func handle(action: ContactAction) {
        guard action != .poke else {
            // handle the poke
            return
        }
        guard let controller = controller(for: action) else {
            return
        }
        presentViewControllerAsModalWindow(controller)
    }
    
    
    //------------------
    
    // the place that the view is passed to by reading the action of ContactAction
    func controller(for action: ContactAction) -> UIViewController?{
        switch action {
        case .call:
            return CallController()
        case .message:
            return MessageController()
        default:
            return nil
        }
    }
    
    // presents the new viewController a modal
    private func presentViewControllerAsModalWindow(_ controller: UIViewController){
        present(controller, animated: true, completion: nil)
    }
}


//refactoring the code above^ - passes the localized title of the action called
extension ContactAction{
    private var buttonTitle: String{
        switch self {
        case .call:
            return "Call"
        case .message:
            return "Message"
        case .poke:
            return "Poke"
        }
    }
    
    var localizedTitle: String{
        return NSLocalizedString(buttonTitle, comment: "\(self) button title")
    }
}

//For example, in our button case, if you're visiting your own profile, you may not want to call yourself. It is easily solved in a subclass with the following implementation:

class CallController: ContactController{
    override func makeButton(for action: ContactAction) -> UIButton {
        let button = super.makeButton(for: action)
        button.isEnabled = true
        return button
    }
}

class MessageController: ContactController{
    override func makeButton(for action: ContactAction) -> UIButton {
        let button = super.makeButton(for: action)
        button.isEnabled = true
        return button
    }
}

class MyContactController: ContactController{
    override func makeButton(for action: ContactAction) -> UIButton {
        let button = super.makeButton(for: action)
        button.isEnabled = false
        return button
    }
}



// Advanced Usage of the Factory method pattern
//“Let's see how we can apply this with the popular iOS view controller UIAlertController. This controller is used to display a message to the user, either in the form of an alert or an action sheet.”



class UIAlertControllerFactory{
    static let sharedFactory = UIAlertControllerFactory()
    
    private init(){
        
    }
    
    //func  alertControllerFor(error: Error, onOk handler: @escaping (UIAlertAction) -> Void) -> UIAlertController{
        /* implementation goes here */
    //}
}


extension UIAlertControllerFactory{
        // this can be displayed anywhere in the controller
    static func forError(_ error: Error, onOk handler: @escaping (UIAlertAction)-> Void) -> UIAlertController
    {
        let title = NSLocalizedString("There was an error", comment: "Error alert title")
        let mesage = error.localizedDescription
        let ok = NSLocalizedString("OK", comment: "Error alert OK button title")
        
        let controller = UIAlertController(title: title, message: mesage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: ok, style: .cancel, handler: handler)
        
        controller.addAction(okAction)
        return controller
    }
}


//refactoring the code above^
extension UIAlertController{
    convenience init(forError error: Error, onOk handler: @escaping (UIAlertAction) -> Void) {
        let title = NSLocalizedString("There was an error", comment: "Error alert title")
        let mesage = error.localizedDescription
        let ok = NSLocalizedString("OK", comment: "Error alert OK button title")
        
        self.init(title: title, message: mesage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: ok, style: .cancel, handler: handler)
        addAction(okAction)
    }
}

/*call these
do {
    // call something that may fail...
}catch let e{
    present(UIAlertController.forError(e) { (action) in
        // User tapped OK
    }, animated: true, completion: nil)
}


//refactoring the code above^
do{
    //call something that may fail...
}catch let e {
    present(UIAlertController.forError(e, onOk: { (action) in
        //user tapped ok
    }, animated: true, completion: nil))
}
*/

/*
“In order to implement the factory method pattern you will need to:

1. Identify in your code the areas that produce similar objects. In our case, these are String, NSButton, and NSViewController.
2. Find the common denominator for the generation of those objects. For String this was ContactAction and enum; it was ContactController for NSButtons and NSViewControllers.
3. Replace all the call sites where you were creating the instances with the factory method calls.”

*/



