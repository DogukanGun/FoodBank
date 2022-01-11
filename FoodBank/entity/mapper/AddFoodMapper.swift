//
//  AddFoodMapper.swift
//  FoodBank
//
//  Created by Dogukan Gundogan on 1/11/22.
//

import Foundation


class AddFoodMapper{
    static func convertFrom(product:Product)->AddFoodToShoppingCartRequest?{
        guard let username = userDefaults.string(forKey: Constants.userDefaultsUsername) else{
            return nil
        }
        guard let foodPrice = Int(product.yemekFiyat) else{
            return nil
        }
        return AddFoodToShoppingCartRequest(yemek_adi: product.yemekAdi, yemek_resim_adi: product.yemekResimAdi, yemek_fiyat: foodPrice, yemek_siparis_adet: product.totalAmount, kullanici_adi: username)
    }
    
    static func convertFrom(shoppingCart:ShoppingCart)->AddFoodToShoppingCartRequest?{
        guard let username = userDefaults.string(forKey: Constants.userDefaultsUsername) else{
            return nil
        }
        guard let foodPriceText = shoppingCart.yemek_fiyat,let foodPrice = Int(foodPriceText) else{
            return nil
        }
        return AddFoodToShoppingCartRequest(yemek_adi: shoppingCart.yemek_adi!, yemek_resim_adi: shoppingCart.yemek_resim_adi!, yemek_fiyat: foodPrice, yemek_siparis_adet: Int(shoppingCart.yemek_siparis_adet!)! , kullanici_adi: username)
    }
}
