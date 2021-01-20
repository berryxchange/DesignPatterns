//
//  ViewController.swift
//  Q SportsStore
//
//  Created by Quinton Quaye on 10/2/20.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
  
    @IBOutlet weak var totalStockLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
        // prefer a light interface style with this:
            overrideUserInterfaceStyle = .light
        }
        displayStockTotal()
    }

//functions
    func writeMyProductDetails(product: (Name: String, Desciption: String, TypeofSport: String, Price: Double, Amount: Int)){
        print("Name: \(product.Name)")
        print("Description: \(product.Desciption)")
        print("Category: \(product.TypeofSport)")
        let formattedPrice = NSString(format: "$%2lf", product.Price)
        print("Price: \(formattedPrice)")
    }
    
    func displayStockTotal(){
        let stockTotal = exampleOfficialProducts.reduce(0, { (total, product) -> Int in
            //writeMyProductDetails(product: product)
            return total + product.productStockLevel
        });
         totalStockLabel.text = "\(stockTotal) Products in Stock"
    }
    
    
    // -----------------without a ModelObject-----------------
    func calculateTaxWithoutModelObject(product: (Name: String, Desciption: String, TypeofSport: String, Price: Double, Amount: Int))-> Double{
        return product.Price * 0.2
    }
    
    func calculateStockValueWithoutModelObject(tuples: [(Name: String, Desciption: String, TypeofSport: String, Price: Double, Amount: Int)])-> Double{
        
        return tuples.reduce(0) {
            (total, product) -> Double in
            return total + (product.3 * Double(product.4))
        }
    }
    
    
    //-----------------with ModelObject-----------------
    func calculateTaxWithModelObject(product: ProductModel)-> Double{
        return product.productPrice * 0.2
    }
    
    func calculateStockValueWithModelObject(productsArray:[ProductModel]) -> Double{
        return productsArray.reduce(0, { (total, product) -> Double in
            return total + (product.productPrice * Double(product.productStock))
        });
    }
    
    //-----------------with EncapsulatedModelObject-----------------
    
    func calculateStockValueWithEncapsulatedProductModel(productsArray:[EncapsulatedProductModel]) -> Double{
        return productsArray.reduce(0, { (total, product) -> Double in
            return total + product.stockValue
        });
    }
    
    //-----------------
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exampleOfficialProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let product = exampleOfficialProducts[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? ProductTableViewCell
        
        cell?.product = exampleOfficialProducts[indexPath.row]
        cell?.getProduct(product: (cell?.product)!)
        
        return cell!
    }
    
    
    
    //Actions
    @IBAction func stockLevelDidChange(_ sender: Any) {
        if var currentCell = sender as? UIView{
            while (true){
                currentCell = currentCell.superview!
                if let cell = currentCell as? ProductTableViewCell{
                    cell.setStepperData()
                    break
                }
            }
            displayStockTotal()
        }
    }
    
}

