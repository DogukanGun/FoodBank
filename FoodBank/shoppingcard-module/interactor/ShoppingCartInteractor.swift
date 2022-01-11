//
//  ShoppingCartInteractor.swift
//  FoodBank
//
//  Created by Dogukan Gundogan on 1/10/22.
//

import Foundation
import Alamofire

class ShoppingCartInteractor:PresenterToInteractorShoppingCartProtocol{
    
    
    var presenter: InteractorToPresenterShoppingCartProtocol?
    
    func deleteProductFromShoppingList(deleteFoodRequest: DeleteFoodRequest) {
        guard let parameters = deleteFoodRequest.getParameter() else {
            return
        }
        AF.request(Network.deleteFood, method: .post, parameters: parameters).response { data in
            guard let response = data.response else{
                self.presenter?.returnDeleteResponse(response: false)
                return
            }
            if response.statusCode>300 || response.statusCode<200 {
                self.presenter?.returnDeleteResponse(response: false)
                print("error")
            }
            self.presenter?.returnDeleteResponse(response: true)
        }
    }
    
    func getShoppingList(userId: String) {
        print(userId)
        let parameter:Parameters = ["kullanici_adi":userId]
        AF.request(Network.getFoodsInBasket, method: .post, parameters: parameter).response { data in
            guard let data = data.data else{
                return
            }
            
            do{
                let json = try JSONDecoder().decode(GetShoppingCartResponse.self, from: data)
                if let products = json.sepet_yemekler{
                    self.presenter?.returnShoppingList(shoppingList: products)
                }
            }catch{
                print(error.localizedDescription)
            }
        } 
    }
    
    func updateShoppingList(newShoppingList: [ShoppingCart], oldShoppingList: [ShoppingCart]) {
        for shoppingItem in oldShoppingList{
            deleteFood(shoppingItem)
        }
        for shoppingItem in newShoppingList {
            addFood(shoppingItem)
        }
        
    }
    
    private func addFood(_ shoppingItem:ShoppingCart){
        let addFoodRequest = AddFoodMapper.convertFrom(shoppingCart: shoppingItem)
        guard let addFoodRequest = addFoodRequest else {
            return
        }
        AF.request(Network.addFood, method: .post, parameters: addFoodRequest.getParameter()).response { data in
            if let response = data.response ,response.statusCode<300 && response.statusCode>199{
            
            }else{
            }
        }
    }
    
    private func deleteFood(_ shoppingItem:ShoppingCart){
        let deleteFoodRequest = DeleteFoodMapper.convertFrom(shoppingCart: shoppingItem)
        guard  let deleteFoodRequest = deleteFoodRequest,let parameters = deleteFoodRequest.getParameter() else {
            return
        }
        AF.request(Network.deleteFood, method: .post, parameters: parameters).response { data in
            guard let response = data.response else{
                return
            }
            if response.statusCode>300 || response.statusCode<200 {
                print("error")
            }
        }
    }
    
    
}
