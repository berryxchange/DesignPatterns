//
//  Logger.swift
//  The Singleton Server
//
//  Created by Quinton Quaye on 10/7/20.
//

import Foundation

/*class Logger{

    private var data: [String] = []
    
    func log(message: String){
        data.append(message)
    }
    
    func printLog(){
        for msg in data{
            print("Log: \(msg)")
        }
    }
}
*/

/*let GlobalLogger = Logger.instance

final class Logger {
    public static var instance = Logger()
    private var data = [String]()
    
    private init(){
        //do nothing - required to stop instances from creating new instances in other files
    }
    
    func log(message: String){
        data.append(message)
    }
    
    func printLog(){
        for msg in data{
            print("Log: \(msg)")
        }
    }
}
 */

/*
The first change we made is to define the global constant, which we have called globalLogger.
The Swift language makes two guarantees about global constants and variables.
 They will be initialized lazily, and that lazy initialization is thread-safe.
 These guarantees mean that the singleton object won’t be created until the value of the globalLogger constant is
read for the first time and that when it is read, only a single instance of the Logger class will be instantiated even if another thread tries to read the value while the singleton is being initialized.
 
 we marked the class as final to prevent subclasses from being defined and marked the initializer as private so that instances cannot be created from outside the Logger.swift file. Having defined the singleton and protected its class so that other instances cannot be created, I can update the BackupServer class
*/



//-------------Serial Queued Logger ----------

let GlobalLogger = Logger.instance

final class Logger {
    public static var instance = Logger()
    private var data = [String]()
    private let serialArrayQueue = DispatchQueue(label: "serialQueue")
    
    private init(){
        //do nothing - required to stop instances from creating new instances in other files
    }
    
    func log(message: String){
        serialArrayQueue.sync {
            data.append(message)
        }
    }
    
    func printLog(){
        for msg in data{
            print("Log: \(msg)")
        }
    }
}
