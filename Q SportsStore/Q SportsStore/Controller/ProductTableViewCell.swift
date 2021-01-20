//
//  ProductTableViewCell.swift
//  Q SportsStore
//
//  Created by Quinton Quaye on 10/2/20.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var stockStepper: UIStepper!
    @IBOutlet weak var stockTextField: UITextField!
    
    var product: OfficialProductModel?
    var productId: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func getProduct(product: OfficialProductModel){
        self.nameLabel.text = product.productName
        self.descriptionLabel.text = product.productDescription
        self.stockTextField.text = String(product.productStockLevel)
        self.stockStepper.value = Double(product.productStockLevel)
    }
    
    func setStepperData(){
        product!.productStockLevel = Int(stockStepper.value)
        
        stockStepper.value = Double(product!.productStockLevel)
        stockTextField.text = String(product!.productStockLevel)
        GlobalLogger.log(product: product!)
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
