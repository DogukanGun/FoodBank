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

    var variables = ProductTableViewCellVariable()
    @IBOutlet weak var wrapper: UIView!
    @IBOutlet weak var foodRate: UILabel!
    @IBOutlet weak var foodPrice: UILabel!
    @IBOutlet weak var foodTitle: UILabel!
    @IBOutlet weak var addBasketButton: UIButton!
    @IBOutlet weak var foodImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        wrapper.layer.cornerRadius = variables.cellRadious
        let path = UIBezierPath(roundedRect:addBasketButton.bounds, byRoundingCorners:[.topLeft, .bottomRight], cornerRadii: CGSize(width: variables.addBasketButtonRadious, height: variables.addBasketButtonRadious))
        let maskLayer = CAShapeLayer()

        maskLayer.path = path.cgPath
        addBasketButton.layer.mask = maskLayer 
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func refresh(product:Product){
        foodTitle.text = product.yemekAdi
        foodPrice.text = "\(product.yemekFiyat) TL"
        let random = Double.random(in: 1...5)
        foodRate.text = String(Double(round(10 * random) / 10))
    }
    
}
