//
//  FoodDetailPresenter.swift
//  FoodBank
//
//  Created by Dogukan Gundogan on 1/10/22.
//

import Foundation

class FoodDetailPresenter:ViewToPresenterFoodDetailProtocol{
    var interactor: PresenterToInteractorFoodDetailProtocol?
    
    func addBasket(product: Product) {
        interactor?.addBasket(product: product)
    }
    
    
}
