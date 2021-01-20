//
//  Utils.swift
//  Q SportsStore
//
//  Created by Quinton Quaye on 10/4/20.
//

import Foundation

class Utils{
    class func currencyStringFromNumber(number: Double)-> String{
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.currency
        return formatter.string(from: NSNumber(value: number)) ?? ""
    }
}
//We have defined a type method (also known as a static method) called currencyStringFromNumber that accepts a Double value and returns a number formatted as a currency value. For example, the value 1000.1 would be formatted into the string $1,000.10. (The currency sign is applied based on the locale settings of the device. Outside of the United States, the dollar sign may be replaced with another symbol, such as those for the euro or the British pound.)

//We’ll use the new type method to the information displayed by the label at the bottom of the SportsStore layout.
