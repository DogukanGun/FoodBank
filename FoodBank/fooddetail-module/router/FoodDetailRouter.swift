//
//  FoodDetailRouter.swift
//  FoodBank
//
//  Created by Dogukan Gundogan on 1/10/22.
//

import Foundation

class FoodDetailRouter:PresenterToRouterFoodDetailProtocol{
    static func createModule(ref: FoodDetailVC) {
        ref.presenter = FoodDetailPresenter()
        ref.presenter?.interactor = FoodDetailInteractor()
    }
    
    
}
