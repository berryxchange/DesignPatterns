//
//  DataItemModel.swift
//  The Singleton Server
//
//  Created by Quinton Quaye on 10/7/20.
//

import Foundation


class DataItemModelClass{
    enum ItemType: String {
        case Email = "Email Address"
        case Phone = "Telephone Number"
        case Card = "Credit Card Number"
    }
    
    var type: ItemType
    var data: String
    
    init(type: ItemType, data: String) {
        self.type = type
        self.data = data
    }
}
