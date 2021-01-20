//
//  ViewController.swift
//  The Singleton Server
//
//  Created by Quinton Quaye on 10/7/20.
//

import UIKit
import Foundation

class ViewController: UIViewController {

   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //exampleSingletonOne()
        //server.getData()
        
        //exampleSingletonTwo()
        
        //exampleSingletonThree()
        
        exampleSingletonFourWithSerializedDispatchQueue()
        
        
    }
    
    
/*
     -----------Conventional Singletion ----------
    func exampleSingletonOne(){
        let server = BackupServer(name: "Backup Server #1")
        
        
        server.backup(
            dataItem: DataItemModelClass(
                type: .Email,
                data: "Saminoske2@yahoo.com"
            )
        )
        
        server.backup(
            dataItem: DataItemModelClass(
                type: .Phone,
                data: "(269) 635 - 0042"
            )
        )
        
        
        let otherServer = BackupServer(name: "Backup Server #2")
        otherServer.backup(
            dataItem: DataItemModelClass(
                type: .Email,
                data: "BlackDynamite@BlackDynamite.com"
            )
        )
    }
    
    
    func exampleSingletonTwo(){
        let server = BackupServer(name: "Backup Server #1")
        
        server.backup(
            dataItem: DataItemModelClass(
                type: .Email,
                data: "Example1@example.com"
            )
        )
        
        server.backup(
            dataItem: DataItemModelClass(
                type: .Phone,
                data: "(555) 123 - 4567"
            )
        )
        
        GlobalLogger.log(message: "Backed up \(server.backupCount) times to \(server.name)")
        
        
        let otherServer = BackupServer(name: "Other Server #1")
        
        otherServer.backup(
            dataItem: DataItemModelClass(
                type: .Email,
                data: "Blackula@Blood.com"
            )
        )
        
        GlobalLogger.log(message: "Backed up \(otherServer.backupCount) times to \(otherServer.name)")
        
        GlobalLogger.printLog()
    }
 */
    
    // -----------Nested Singletion ----------
    func exampleSingletonThree(){
        // this is the initializer
        let server = BackupServer.server
        
        server.backup(
            dataItem: DataItemModelClass(
                type: .Email,
                data: "Blade@FrostyBlade.com"
            )
        )
        
        server.backup(
            dataItem: DataItemModelClass(
                type: .Phone,
                data: "(269) 635 - 0042"
            )
        )
        
        
        let otherServer = BackupServer.server
        
        otherServer.backup(
            dataItem: DataItemModelClass(
                type: .Email,
                data: "Soapabublisious@sukka.com"
            )
        )
        
        completeLogRun(server: otherServer)
        
    }
    
    //---------------- Unsafe Concurrency ----------
    
    func exampleSingletonFourWithSerializedDispatchQueue(){
        let server = BackupServer.server
        
        let queue = DispatchQueue(label: "WorkQueue", attributes: .concurrent)
        let group = DispatchGroup()
        
        func runBackup(completion: () -> Void){
            completion()
        }
        
        for count in 0..<100{
            group.enter()
            
            runBackup() {
                queue.async {
                    server.backup(
                        dataItem: DataItemModelClass(
                            type: .Email,
                            data: "Blade\(count)@FrostyBlade.com"
                        )
                    )
                }
                
                group.leave()
                
            }
        }
        
        group.notify(queue: .main){
            print("\(server.getData().count) Items were backed up")
        }
    }
    //---------------
    
    
    func completeLogRun(server: BackupServer){
        GlobalLogger.log(message: "Backed up \(server.backupCount) times to \(server.name)")
        
        GlobalLogger.printLog()
    }

}

