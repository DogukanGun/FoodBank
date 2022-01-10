//
//  FoodDetailInteractor.swift
//  FoodBank
//
//  Created by Dogukan Gundogan on 1/10/22.
//

import Foundation

class FoodDetailInteractor:PresenterToInteractorFoodDetailProtocol{
    let context = appDelegate.persistentContainer.viewContext
    func addBasket(product: Product) {
        let food = Food(context: context)
        food.foodName = product.yemekAdi
        food.foodId = product.yemekID
        food.totalPrice = product.yemekFiyat
        food.foodImageName = product.yemekResimAdi
        food.totalAmount = Int16(product.totalAmount)
    } 
}
