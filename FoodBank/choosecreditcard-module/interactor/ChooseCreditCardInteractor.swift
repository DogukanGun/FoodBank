//
//  ChooseCreditCardInteractor.swift
//  FoodBank
//
//  Created by Dogukan Gundogan on 13.01.2022.
//

import Foundation
import Alamofire

class ChooseCreditCardInteractor:PresenterToInteractorChooseCreditCardProtocol{
    let context = appDelegate.persistentContainer.viewContext
    var presenter: InteractorToPresenterChooseCreditCardProtocol?
    
    func getData() {
        do{
            let list = try context.fetch(CreditCard.fetchRequest())
            presenter?.sendData(creditCards: list)
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func deleteData(shoppingCards: [ShoppingCart]) {
        for shoppingCard in shoppingCards {
            delete(shoppingCard: shoppingCard)
        }
    }
    
    private func delete(shoppingCard:ShoppingCart){
        let deleteFoodRequest = DeleteFoodMapper.convertFrom(shoppingCart: shoppingCard)
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
