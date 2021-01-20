import UIKit


//The Facade Pattern
    //Building a netword cache with the facade pattern - when building our applications or servers, we often need to avoid  repeatedly making the same network calls, impacting on the performance of our programs.

class Cache{
    func set(response: URLSession, data: Data, for request: URLRequest){
        //TODO: Implement me
    }
    func get(for request: URLRequest) -> (URLResponse, Data)?{
        //TODO: Implement me
    }
    func remove(for request: URLRequest){
        //TODO: Implement me
    }
    func allData()-> [URLRequest: (URLRequest, Data)]{
        return [:]
    }
}

// this CacheCleaner visits the Cache periodically to remove stale data

class CacheCleaner{
    let cache: Cache
    var isRunning: Bool{
        return timer != nil
    }
    
    private var timer: Timer?
    init(cache: Cache){
        self.cache = cache
    }
    
    func startIfNeeded(){
        if isRunning {
            return
        }
        timer = Timer.scheduledTimer(withTimeInterval: 10.0, repeats: true){ [unowned self] (timer) in
            let cachedData = self.cache.allData()
            //TODO: Inspect cache data, and remove cached elements that are too old...
        }
    }
    
    func stop(){
        timer?.invalidate()
        timer = nil
    }
}


//the facade
class CachedNetworking{
    let session: URLSession
    private let cache = Cache()
    private lazy var cleaner = CacheCleaner(cache: cache)
    
    init(configuration: URLSessionConfiguration){
        session = URLSession(configuration: configuration)
    }
    
    init(session: URLSession) {
        self.session = session
    }
    
    init(){
        self.session = URLSession.shared
    }
}
