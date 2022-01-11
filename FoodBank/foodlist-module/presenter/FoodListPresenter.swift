//
//  FoodListPresenter.swift
//  FoodBank
//
//  Created by Dogukan Gundogan on 1/11/22.
//

import Foundation


class FoodListPresenter:ViewToPresenterFoodListProtocol{
    var interactor: PresenterToInteractorFoodListProtocol?
    
    var view: PresenterToViewFoodListProtocol?
    
    func getData() {
        interactor?.getData()
    }
}

extension FoodListPresenter:InteractorToPresenterFoodListProtocol{
    func sendData(products: [Product]) {
        view?.sendData(products: products)
    } 
}
