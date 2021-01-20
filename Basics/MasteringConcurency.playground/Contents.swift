import UIKit

class CreditCard{
    private let queue = DispatchQueue(label: "synchronization.queue")
    private var _balance: Int = 0
    var balance: Int {
        get{
            return queue.sync{ _balance}
        }
        set {
            queue.sync{ _balance = newValue }
        }
    }
}
