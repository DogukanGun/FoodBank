//
//  FoodListInteractor.swift
//  FoodBank
//
//  Created by Dogukan Gundogan on 1/11/22.
//

import Foundation
import Alamofire


class FoodListInteractor:PresenterToInteractorFoodListProtocol{
    var presenter: InteractorToPresenterFoodListProtocol?
    
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
