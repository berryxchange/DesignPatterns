//
//  ProductModel.swift
//  Q SportsStore
//
//  Created by Quinton Quaye on 10/3/20.
//

import Foundation

//Object Template Pattern class
class ProductModel{
    var productName: String
    var productDescription: String
    var productPrice: Double
    var productStock: Int
    var productCategory: String
    
    init(productName: String, productDescription: String, productPrice: Double, productStock: Int, productCategory: String){
        self.productName = productName
        self.productDescription = productDescription
        self.productPrice = productPrice
        self.productStock = productStock
        self.productCategory = productCategory
    }
}


//Object Template Pattern Decoupling changes made from ProductModel without errors from the model associations
class DecoupledProductModel{
    var productName: String
    var productPrice: Double
    var productStock: Int
    
    init(productName: String, productPrice: Double, productStock: Int){
        self.productName = productName
        self.productPrice = productPrice
        self.productStock = productStock
    }
}


//Object Template Pattern Encapsulation
class EncapsulatedProductModel{
    var productName: String
    var productDescription: String
    var productPrice: Double
    var productStock: Int
    var productCategory: String
    
    init(productName: String, productDescription: String, productPrice: Double, productStock: Int, productCategory: String){
        self.productName = productName
        self.productDescription = productDescription
        self.productPrice = productPrice
        self.productStock = productStock
        self.productCategory = productCategory
    }
    
    //-------------Internals-------------
    //get the tax of the product
    func calculateTax(rate: Double)-> Double{
        return productPrice * rate
    }
    
    //defines a maximum tax amount
    func calculateTaxWithMaxAmount(rate: Double)-> Double{
        return min(10, productPrice * rate)
    }
    
    // calculateStockValue
    var stockValue: Double{
        get {
            return productPrice * Double(productStock)
        }
    }
}


//Object Template Pattern Calculated Properties
class CalculatedProductModel{
    var productName: String
    var productPrice: Double
    private var stockBackingValue: Int = 0
    
    var productStock: Int{
        get{
            return stockBackingValue
        }
        set {
            stockBackingValue = max(0, newValue)
        }
    }
    
    init(productName: String, productPrice: Double, productStock: Int){
        self.productName = productName
        self.productPrice = productPrice
        self.productStock = productStock
    }
    
    func calculateTax(rate: Double)-> Double{
        return min(10, productPrice * rate)
    }
    
    var productStockValue: Double{
        get {
            return productPrice * Double(productStock)
        }
    }
}


//------------------  Official Product Model -------------

/*The private keyword hides whatever
it is applied to from code outside of the current file, and this has the effect of making the priceBackingValue and stockLevelBackingValue properties entirely invisible to the rest of the SportsStore application because the Product class is the only thing in the Product.swift file.
 
 Annotating a property with private(set) means that a property can be read from code in other files in the same module but set by code only in the Product.swift file. 
*/
class OfficialProductModel{
    private(set) var productName: String
    private(set) var productDescription: String
    private(set) var productCategory: String
    private var productStockLevelBackingValue: Int = 0
    private var productPriceBackingValue: Double = 0

    
    init(productName: String, productDescription: String, productCategory: String, productPrice: Double, productStockLevel: Int){
        
        self.productName = productName
        self.productDescription = productDescription
        self.productCategory = productCategory
        self.productPrice = productPrice
        self.productStockLevel = productStockLevel
    }
    
    var productStockLevel: Int{
        get{
            return productStockLevelBackingValue
        }set{
            return productStockLevelBackingValue = max(0, newValue)
        }
    }
    
    private(set) var productPrice: Double{
        get {
            return productPriceBackingValue
        }set{
            return productPriceBackingValue = max(1, newValue)
        }
    }

    var stockValue: Double{
        get {
            return productPrice * Double(productStockLevel)
        }
    }
}
