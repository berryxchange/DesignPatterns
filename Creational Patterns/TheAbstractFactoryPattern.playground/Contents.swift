import UIKit
import CoreLocation

//“The abstract factory pattern - You will probably find yourself needing to implement the abstract factory pattern when your program needs different concrete class implementations behind the same interface. Instead of writing the logic in terms of concrete classes, this will let you write programs based on exposed interfaces.”

//Let's focus on a simple case: registering for push notifications. We can abstract the intention of registering with the following protocol:


typealias ResultBlock = (Bool, Error?) -> Void

protocol PushNotifictionService{
    func register(_ done: ResultBlock)
}

protocol UserLocationService{
    func getUserLocation(done: (CLLocation) -> Void)
}


//create a ServicesFactoryType protocol that will represent all services and devices
/*protocol ServiceFactoryType {
    func getPushService() -> PushNotifictionService
    /* Add more services here as your project grows */
}
*/

//updated ServicesType with notifications^
protocol ServicesFactoryType{
    func getPushService() -> PushNotifictionService
    func getUserLocationService() -> UserLocationService
    /* Add more service here as your project grows */
}


//----- PushNotifictionService ---
//for iOS
struct iOSPushNotificationService: PushNotifictionService{
    func register(_ done: (Bool, Error?) -> Void) {
        /* Your implementation goes here */
    }
}

//for macOS
struct macOSPushNotificationService: PushNotifictionService{
    func register(_ done: (Bool, Error?) -> Void) {
        /* Your implementation goes here */
    }
}


//----- ServiceFactoryType ---
// factory service type for each platform
/*
struct macOSServicesFactory: ServicesFactoryType{
    func getPushService() -> PushNotifictionService {
        if #available(OSX 10.9, *) {// Mavericks and above only
            return macOSPushNotificationService()
        }
        /* add additional platform support here */
        fatalError("Push notifications are not supported on macOS < 10.9")
    }
}

struct iOSServicesFactory: ServicesFactoryType {
    func getPushService() -> PushNotifictionService {
        if #available(iOS 10.0, *) { // New API based on UNNotification
            return iOSPushNotificationService()
        }
        /* additional platform support here */
        fatalError("Push notifications are not supported on iOS < 10.0")
    }
}
*/

// macOSServicesFactory & iOSServicesFactory^ will need to be converted to class in order to inherit from ServicesFactory

class macOSServicesFactory: ServicesFactory{
    override func getPushService() -> PushNotifictionService {
        
        /* */
    }
}

class iOSServicesFactory: ServicesFactory{
    override func getPushService() -> PushNotifictionService {
        /* */
    }
}



//Default Implementations - Let's first start by adding a new service to our factory for registering for localization services. Luckily for us, CoreLocation is the same SDK for both iOS and macOS, so we're able to share our implementation between the two platforms, as follows:

struct CommonUserLocationService: UserLocationService{
    func getUserLocation(done: (CLLocation) -> Void) {
        // TODO: Implement me
    }
}


//----- keeps the factory in the dark ---

//let's abstract one further layer, so our application has no knowledge of which kind of factory there is for which kind of platform support
/*struct ServicesFactory{
    static let shared: ServicesFactoryType = {
        if #available(OSX 10.0, *){
            return macOSServicesFactory()
        }else if #available(iOS 1.0, *){
            return iOSServicesFactory()
        }
    }()
    private init(){
    }
}
 */

//refactored from code above^
class ServicesFactory: ServicesFactoryType{
    static let shared: ServicesFactoryType = {
        if #available(OSX 10.0, *){
            return macOSServicesFactory()
        }else if #available(iOS 1.0, *){
            return iOSServicesFactory()
        }
    }()
    
    internal init(){
    }

    func getPushService() -> PushNotifictionService {
        fatalError("abstract method, implement in subclasses")
    }
    
    func getUserLocationService() -> UserLocationService {
        return CommonUserLocationService()
    }
}
//--- our calls ---

    
let pushService = ServicesFactory.shared.getPushService()
pushService.register { (success, error) in
    // handle success
}


extension ServicesFactoryType{
    func getUserLocationServices() -> UserLocationService{
        return CommonUserLocationService()
    }
}

// “This strategy has one major drawback, however, compared to the inheritance strategy. In the specific iOS and macOS implementations of our ServicesFactoryType, it is impossible to access the default one, unlike with inheritance, where it's easy to call super. You can call extras on the extensions




/*“Checklist for using the factory method pattern

Before you start adding this pattern everywhere in your code, you need to understand that it solves certain issues, so it's helpful to encounter (and suffer from) those first.

The main use of this pattern is to ensure you do not need to write platform-specific code in your application, and that you keep those pesky #available and os() checks (or other compile time or runtime checks) hidden from the consumer.

1. First, ensure you have platform-specific code you need to abstract away (iOS vs tvOS, or iOS 9.0 vs iOS 12.0).
2. Define a common interface for the platform-specific objects, as we did with PushNotificationService and UserLocationService.
3. Implement platform-specific classes for each interface, such as iOSPushNotificationService.
4. Define and implement a common service factory interface, such as ServiceFactoryType, and implement platform-specific service factories.
5. Define a common and simple way to get the proper serviceFactory for the current context. In our scenario, it was the ServicesFactory.shared singleton, which was instantiated based on #availability APIs; in other contexts, this may be a method.
 6. Protect the visibility of your services or factories with proper accessors (private, internal, and so on), in order to prevent accidental instantiation. For example, we don't want the iOSPushNotificationService constructor to be used or available outside iOSServiceFactory.
 7.Replace all occurrences of creating those objects through their (now-unavailable) constructor by creating them through your new abstract factory.
 
 Now that you know everything about the factory method pattern, we can move on to the builder pattern.
 */
