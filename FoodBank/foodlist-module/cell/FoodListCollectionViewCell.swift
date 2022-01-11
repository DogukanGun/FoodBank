//
//  FoodListCollectionViewCell.swift
//  FoodBank
//
//  Created by Dogukan Gundogan on 1/11/22.
//

import UIKit
import Kingfisher

class FoodListCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var foodPrice: UILabel!
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var foodImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func refresh(product:Product){
        DispatchQueue.main.async {
            self.foodImage.kf.setImage(with:URL(string: Network.imageOfFood+product.yemekResimAdi))
        }
        foodName.text = product.yemekAdi
        foodPrice.text = "\(product.yemekFiyat) TL"
    }
}
