//
//  ShoppingCartTableViewCell.swift
//  FoodBank
//
//  Created by Dogukan Gundogan on 1/10/22.
//

import UIKit
import SwiftUI

struct ShoppingCartTableViewCellVariable{
    let cellRadious = CGFloat(20)
}

class ShoppingCartTableViewCell: UITableViewCell {

    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var foodAmountLabel: UILabel!
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var decrementButton: UIButton!
    @IBOutlet weak var incrementButton: UIButton!
    
    let variables = ShoppingCartTableViewCellVariable()
    var indexPath:IndexPath? = nil
    var food:ShoppingCart? = nil
    var shoppingCardDelegate:ShoppingCardDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        editButtons()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    private func editButtons(){
        decrementButton.reshapeButton()
        incrementButton.reshapeButton()
        let path = UIBezierPath(roundedRect:deleteButton.bounds, byRoundingCorners:[.topLeft, .bottomRight], cornerRadii: CGSize(width: variables.cellRadious, height:variables.cellRadious))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        deleteButton.layer.mask = maskLayer
    }
    func refresh(food:ShoppingCart){
        if let totalPriceText = food.yemek_fiyat,let totalPrice = Int(totalPriceText),let totalAmountText = food.yemek_siparis_adet,let totalAmount = Int(totalAmountText){
            priceLabel.text = String(totalPrice * totalAmount)
            nameLabel.text = food.yemek_adi ?? ""
            foodAmountLabel.text = String(totalAmount)
            self.food = food
        } 
    }
    
    @IBAction func deleteButtonPressed(_ sender: Any) {
        if let food = food, let id = food.sepet_yemek_id,let indexPath = indexPath {
            shoppingCardDelegate?.deleteButtonPressed(foodId: String(id),indexPath: indexPath)
        }
    }
    @IBAction func decrementButtonPressed(_ sender: Any) {
        if let amountLabelText = foodAmountLabel.text,let amount = Int(amountLabelText),let food = food, let priceText = priceLabel.text,let price = Int(priceText){
            if amount-1 != 0{
                if let priceOfAFoodText = food.yemek_fiyat,let priceOfAFood = Int(priceOfAFoodText){
                    let newAmount = String(amount - 1)
                    let newPrice = String(price - priceOfAFood)
                    foodAmountLabel.text = String(newAmount)
                    priceLabel.text = String(newPrice)
                    food.yemek_siparis_adet = String(newAmount)
                    food.yemek_fiyat = String(newPrice)
                    shoppingCardDelegate?.changePrice(newShoppingCart: food)
                }
            }else{
                guard let id = food.sepet_yemek_id,let indexPath = indexPath else{
                    return
                }
                
                shoppingCardDelegate?.deleteButtonPressed(foodId: String(id),indexPath: indexPath)
            }
        }
    }
    @IBAction func incerementButtonPressed(_ sender: Any) {
        if let food = food,let amountLabelText = foodAmountLabel.text,let amount = Int(amountLabelText),let priceText = priceLabel.text,let price = Int(priceText) {
            if let priceOfAFoodText = food.yemek_fiyat,let priceOfAFood = Int(priceOfAFoodText){
                let newAmount = String(amount + 1)
                let newPrice = String(price + priceOfAFood)
                foodAmountLabel.text = newAmount
                priceLabel.text = newPrice
                food.yemek_siparis_adet = String(newAmount)
                food.yemek_fiyat = String(newPrice)
                shoppingCardDelegate?.changePrice(newShoppingCart:food)
            }
            
        } 
    }
}

protocol ShoppingCardDelegate{
    func deleteButtonPressed(foodId:String,indexPath:IndexPath)
    func changePrice(newShoppingCart:ShoppingCart)
}
