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
    var food:Product? = nil
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
    func refresh(food:Product){
        if let totalPrice = Int(food.yemekFiyat){
            priceLabel.text = String(totalPrice * Int(food.totalAmount))
            nameLabel.text = food.yemekAdi
            foodAmountLabel.text = String(food.totalAmount)
            self.food = food
        } 
    }
    
    @IBAction func deleteButtonPressed(_ sender: Any) {
        if let food = food {
            shoppingCardDelegate?.deleteButtonPressed(foodId: food.yemekID)
        }
    }
    @IBAction func decrementButtonPressed(_ sender: Any) {
        if let amountLabelText = foodAmountLabel.text,let amount = Int(amountLabelText),let food = food {
            if amount-1 != 0{
                foodAmountLabel.text = String(amount - 1)
            }else{
                shoppingCardDelegate?.deleteButtonPressed(foodId: food.yemekID)
            }
        }
    }
    @IBAction func incerementButtonPressed(_ sender: Any) {
        if let amountLabelText = foodAmountLabel.text,let amount = Int(amountLabelText) {
            foodAmountLabel.text = String(amount + 1)
        } 
    }
}

protocol ShoppingCardDelegate{
    func deleteButtonPressed(foodId:String)
}
