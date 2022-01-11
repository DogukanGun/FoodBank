//
//  DeleteFoodMapper.swift
//  FoodBank
//
//  Created by Dogukan Gundogan on 1/11/22.
//

import Foundation


class DeleteFoodMapper{
    static func convertFrom(shoppingCart:ShoppingCart)->DeleteFoodRequest?{
        guard let foodId = shoppingCart.sepet_yemek_id else{
            return nil
        }
        return DeleteFoodRequest(productId: foodId)
    }
}
