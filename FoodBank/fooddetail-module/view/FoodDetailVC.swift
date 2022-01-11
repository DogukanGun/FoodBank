//
//  FoodDetailVC.swift
//  FoodBank
//
//  Created by Dogukan Gundogan on 1/10/22.
//

import Foundation
import UIKit
import Kingfisher

struct FoodDetailVariable{
    let incOrDecAmount = 1
    let addCardButtonCornerRadious = CGFloat(20)
}

class FoodDetailVC:UIViewController{
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var addCardButton: UIButton!
    @IBOutlet weak var deliverTime: UILabel!
    @IBOutlet weak var foodRate: UILabel!
    @IBOutlet weak var foodCalorie: UILabel!
    @IBOutlet weak var foodDetail: UILabel!
    @IBOutlet weak var decrementButton: UIButton!
    @IBOutlet weak var incrementButton: UIButton!
    @IBOutlet weak var totalFoodAmount: UILabel!
    @IBOutlet weak var foodPrice: UILabel!
    @IBOutlet weak var foodName: UILabel!
    
    var food:Product? = nil
    let variables = FoodDetailVariable()
    var presenter:ViewToPresenterFoodDetailProtocol? = nil
    
    override func viewDidLoad() {
        incrementButton.reshapeButton()
        decrementButton.reshapeButton()
        editButton()
        setFood()
        FoodDetailRouter.createModule(ref: self)
    }
    
    private func setFood(){
        if let food = food {
            foodPrice.text = food.yemekFiyat
            foodName.text = food.yemekAdi
            DispatchQueue.main.async {
                self.foodImage.kf.setImage(with:URL(string: Network.imageOfFood+food.yemekResimAdi))
            }
            if let detail = food.detail, let rate = food.rate, let transportHour = food.transportHour{
                deliverTime.text = String(transportHour)
                foodRate.text = String(rate)
                foodDetail.text = detail
            }
        }
    }
    
    private func editButton(){ 
        let path = UIBezierPath(roundedRect:addCardButton.bounds, byRoundingCorners:[.topLeft, .topRight], cornerRadii: CGSize(width: variables.addCardButtonCornerRadious, height:variables.addCardButtonCornerRadious))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        addCardButton.layer.mask = maskLayer
    }
    
    @IBAction func decrementFoodAmount(_ sender: Any) {
        if let totalAmountText = totalFoodAmount.text,let totalAmount = Int(totalAmountText),totalAmount != 0{
            totalFoodAmount.text = String(totalAmount-variables.incOrDecAmount)
            food?.totalAmount-=variables.incOrDecAmount
        }
    }
    
    
    @IBAction func addCardButtonPressed(_ sender: Any) {
        if let food = food,let totalAmountText = totalFoodAmount.text, let totalAmount = Int(totalAmountText), totalAmount != 0 {
            food.totalAmount = totalAmount
            presenter?.addBasket(product: food)
        }
    }
    @IBAction func incrementFoodAmount(_ sender: Any) {
        if let totalAmountText = totalFoodAmount.text,let totalAmount = Int(totalAmountText){
            totalFoodAmount.text = String(totalAmount+variables.incOrDecAmount)
            food?.totalAmount+=variables.incOrDecAmount
        }
    }
    
}

extension FoodDetailVC:PresenterToViewFoodDetailProtocol{
    func foodAddingResponse(response: String) {
        confirmationDialog(title: "Food Added", message: response, okayButtonText: "Okay", cancelButtonText: nil, okayButtonResult: nil)
    } 
}
