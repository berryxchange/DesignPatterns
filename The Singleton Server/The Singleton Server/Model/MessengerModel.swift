//
//  MessengerModel.swift
//  The Singleton Server
//
//  Created by Quinton Quaye on 10/10/20.
//

import Foundation

final class Mesenger{
    private var messages: [String] = []
    
    private var queue = DispatchQueue(label: "Message.Queque", attributes: .concurrent)
    
    var lastMessage: String? {
        return queue.sync {
            messages.last
        }
    }
    
    func postMessage(newMessage: String){
        queue.sync(flags: .barrier){
           messages.append(newMessage)
        }
    }
}

