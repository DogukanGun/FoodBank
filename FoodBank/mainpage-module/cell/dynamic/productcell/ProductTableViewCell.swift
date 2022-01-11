//
//  ProductTableViewCell.swift
//  FoodBank
//
//  Created by Dogukan Gundogan on 1/10/22.
//

import UIKit

struct ProductTableViewCellVariable{
    let cellRadious = CGFloat(20)
    let addBasketButtonRadious = CGFloat(20)
}

class ProductTableViewCell: UITableViewCell {
    
    @IBOutlet weak var wrapper: UIView!
    @IBOutlet weak var foodRate: UILabel!
    @IBOutlet weak var foodPrice: UILabel!
    @IBOutlet weak var foodTitle: UILabel!
    @IBOutlet weak var addBasketButton: UIButton!
    @IBOutlet weak var foodImage: UIImageView!
    
    var variables = ProductTableViewCellVariable()
    var delegate:ProductTableViewCellDelegate? = nil
    var product:Product? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        wrapper.layer.cornerRadius = variables.cellRadious
        let path = UIBezierPath(roundedRect:addBasketButton.bounds, byRoundingCorners:[.topLeft, .bottomRight], cornerRadii: CGSize(width: variables.addBasketButtonRadious, height: variables.addBasketButtonRadious))
        let maskLayer = CAShapeLayer()

        maskLayer.path = path.cgPath
        addBasketButton.layer.mask = maskLayer 
    }

    @IBAction func addBasketButtonPressed(_ sender: Any) {
        if let product = product {
            product.totalAmount+=1
            delegate?.addProduct(product: product)
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func refresh(product:Product){
        foodTitle.text = product.yemekAdi
        foodPrice.text = "\(product.yemekFiyat) TL"
        let random = Double.random(in: 1...5)
        foodRate.text = String(Double(round(10 * random) / 10))
        self.product = product
    }
    
}


protocol ProductTableViewCellDelegate{
    func addProduct(product:Product)
}
