//
//  Logger.swift
//  Q SportsStore
//
//  Created by Quinton Quaye on 10/12/20.
//

import Foundation


let GlobalLogger = Logger.instance

final class Logger {
    public static var instance = Logger(callback:{ p in
        print("Change: \(p.productName)")
    })
    
    private var data = [OfficialProductModel]()
    private var concurrentArrayQueue = DispatchQueue(label: "serialQueue")
    
    var callback: (OfficialProductModel) -> Void
    var callbackQueue = DispatchQueue(label: "callbackQueue")
    
    
    private init(callback: @escaping (OfficialProductModel) -> Void, protect: Bool = true){
        self.callback = callback
        if (protect){
            print("Item Protected")
            self.callback = {(item:OfficialProductModel) in
                DispatchQueue(label: "\(self.callbackQueue)").sync {() in
                        callback(item)
                }
            }
        }
        //do nothing - required to stop instances from creating new instances in other files
    }
    
    func log(product: OfficialProductModel){
        concurrentArrayQueue.sync {
            data.append(product)
            self.callback(product)
        }
    }
    
    func processItems(callback: (OfficialProductModel) -> Void){
        concurrentArrayQueue.sync {
            for item in self.data{
                callback(item)
            }
        }
    }
    
    func printLog(){
        for msg in data{
            print("Log: \(msg)")
        }
    }
}

