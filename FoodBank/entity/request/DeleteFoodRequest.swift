//
//  DeleteFoodRequest.swift
//  FoodBank
//
//  Created by Dogukan Gundogan on 1/11/22.
//

import Foundation
import Alamofire


class DeleteFoodRequest{
    
    var productId:String?
    
    init(productId:String){
        self.productId = productId
    }
    
    func getParameter()->Parameters?{
        if let productId = productId, let username = userDefaults.string(forKey: Constants.userDefaultsUsername) {
            return ["sepet_yemek_id":productId,"kullanici_adi":username]
        }
        
        return nil
    }
}
