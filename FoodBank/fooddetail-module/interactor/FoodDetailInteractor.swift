//
//  FoodDetailInteractor.swift
//  FoodBank
//
//  Created by Dogukan Gundogan on 1/10/22.
//

import Foundation
import Alamofire

class FoodDetailInteractor:PresenterToInteractorFoodDetailProtocol{
    var presenter: InteractorToPresenterFoodDetailProtocol?
    
    func addBasket(product: Product) {
        guard let addFoodRequest = AddFoodMapper.convertFrom(product: product) else {
            return
        }
        AF.request(Network.addFood, method: .post, parameters: addFoodRequest.getParameter()).response { data in
            if let response = data.response ,response.statusCode<300 && response.statusCode>199{
                self.presenter?.foodAddingResponse(response:"")
            }else{
                self.presenter?.foodAddingResponse(response: "\(addFoodRequest.yemek_adi!) could not be added to your card")
            }
        }
        
    } 
}
