//
//  MainpagePresenter.swift
//  FoodBank
//
//  Created by Dogukan Gundogan on 1/10/22.
//

import Foundation


class MainpagePresenter:ViewToPresenterMainpageProtocol{
    
    
    var interactor: PresenterToInteractorMainpageProtocol?
    var view: PresenterToViewMainpageProtocol?
    
    func addFoodToShoppingCart(shoppingCardItem: AddFoodToShoppingCartRequest) {
        interactor?.addFoodToShoppingCart(shoppingCardItem: shoppingCardItem)
    }
    func getData() {
        interactor?.getData()
    }
}

extension MainpagePresenter:InteractorToPresenterMainpageProtocol{
    func foodAddingResponse(response: String) {
        view?.foodAddingResponse(response: response)
    }
    
    func sendData(products: [Product]) {
        var newProducts = [Product]()
        for index in 0...products.count/3 {
            newProducts.append(products[index])
        }
        view?.sendData(products: newProducts)
    }
}
