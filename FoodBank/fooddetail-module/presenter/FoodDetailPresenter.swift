//
//  FoodDetailPresenter.swift
//  FoodBank
//
//  Created by Dogukan Gundogan on 1/10/22.
//

import Foundation

class FoodDetailPresenter:ViewToPresenterFoodDetailProtocol{
    var view: PresenterToViewFoodDetailProtocol?
    var interactor: PresenterToInteractorFoodDetailProtocol?
    
    func addBasket(product: Product) {
        interactor?.addBasket(product: product)
    }
}

extension FoodDetailPresenter:InteractorToPresenterFoodDetailProtocol{
    func foodAddingResponse(response: String) {
        view?.foodAddingResponse(response: response)
    }
    
    
}
