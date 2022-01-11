//
//  MainpageInteractor.swift
//  FoodBank
//
//  Created by Dogukan Gundogan on 1/10/22.
//

import Foundation
import Alamofire

class MainpageInteractor:PresenterToInteractorMainpageProtocol{
    
    var presenter: InteractorToPresenterMainpageProtocol?
    
    func addFoodToShoppingCart(shoppingCardItem: AddFoodToShoppingCartRequest) {
        AF.request(Network.addFood, method: .post, parameters: shoppingCardItem.getParameter()).response { data in
            if let response = data.response ,response.statusCode<300 && response.statusCode>199{
                self.presenter?.foodAddingResponse(response:"")
            }else{
                self.presenter?.foodAddingResponse(response: "\(shoppingCardItem.yemek_adi!) could not be added to your card")
            }
        }
    }
    
    func getData() {
        AF.request(Network.allFoods, method: .get).response { data in
            guard let data = data.data else {
                return
            }
            do{
                let json = try JSONDecoder().decode(GetFoodResponse.self, from: data)
                self.presenter?.sendData(products: json.yemekler)
            }catch{
                print(error.localizedDescription)
            }
            
        }
    }
}
