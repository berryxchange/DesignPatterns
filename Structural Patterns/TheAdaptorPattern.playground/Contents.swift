import UIKit

// in This you will want to track events with additional implementation of tracking with empty properties:

public protocol Tracking{
    func record(event: String)
    func record(event: String, properties: [String: String]?)
}

extension Tracking{
    public func record(event: String){
        record(event: event, properties: nil)
    }
}

public class Tracker: Tracking{
    //setup a singleton that can be accessed across the program
    public static let shared = Tracker()
    //keep a reference to the tracking adapter
    private var trackingAdapter: Tracking!
    
    //register the trackingAdapter
    public func set(trackingAdapter: Tracking){
        self.trackingAdapter = trackingAdapter
    }
    
    public func record(event: String, properties: [String : String]?) {
        trackingAdapter.record(event: event, properties: properties)
    }
}
