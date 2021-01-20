//
//  BackupServer.swift
//  The Singleton Server
//
//  Created by Quinton Quaye on 10/7/20.
//

import Foundation

//Conventional Singleton
/*class BackupServer{
    let name: String
    
    var backupCount = 0
    private var data: [DataItemModelClass] = []
    
    
    init(name: String){
        self.name = name
        GlobalLogger.log(message: "Created new server named \(name)")
    }
    
    func backup(dataItem: DataItemModelClass){
        data.append(dataItem)
        backupCount += 1
        GlobalLogger.log(message: "\(name)Backed up with item: \(dataItem.type.rawValue)")
        //GlobalLogger.printLog()
    }
    
    func getData()->[DataItemModelClass]{
        for dataItem in data{
            print(dataItem.data)
        }
        return data
    }
}
*/

/*NestedSingleton
 final class BackupServer{
     let name: String
     
     var backupCount = 0
     private var data: [DataItemModelClass] = []
     
     
     private init(name: String){
         self.name = name
         GlobalLogger.log(message: "Created new server named \(name)")
     }
     
     func backup(dataItem: DataItemModelClass){
         data.append(dataItem)
         backupCount += 1
         GlobalLogger.log(message: "\(name)Backed up with item: \(dataItem.type.rawValue)")
         //GlobalLogger.printLog()
     }
     
     func getData()->[DataItemModelClass]{
         for dataItem in data{
             print(dataItem.data)
         }
         return data
     }
    
    
    class var server: BackupServer{
        struct SingletonWrapper{
            static let singleton = BackupServer(name: "Main Server")
        }
        return SingletonWrapper.singleton
    }
 }
*/

//-------------- Serializing Access -------------
/*
 Serializing Access
 To solve this problem, I need to ensure that only one block at a time is allowed to call the append method on the array.
 */
class DataItem{
    enum ItemType: String{
        case Email = "Email Address"
        case Phone = "Telephone Number"
        case Card = "Credit Card Number"
    }
    
    var type: ItemType
    var data: String
    
    init(type: ItemType, data: String){
        self.type = type
        self.data = data
    }
}


final class BackupServer{
    let name:String
    var backupCount = 0
    
    private var data: [DataItemModelClass] = []
    private let serialArrayQueue = DispatchQueue(label: "arrayQueue")
    private init(name: String){
        self.name = name
        GlobalLogger.log(message: "Created new server \(name)")
    }
    
    func backup(dataItem: DataItemModelClass){
        serialArrayQueue.sync {
            self.data.append(dataItem)
            backupCount += 1
            GlobalLogger.log(
                message: "\(self.name) backed up item of type \(dataItem.type.rawValue)")
        }
    }
    
    func getData() -> [DataItemModelClass]{
        return data
    }
    
    class var server: BackupServer{
        struct SingletonWrapper{
            static let singleton = BackupServer(name: "Main Server")
        }
        return SingletonWrapper.singleton
    }
}

