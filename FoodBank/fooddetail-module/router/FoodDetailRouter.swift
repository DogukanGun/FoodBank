//
//  FoodDetailRouter.swift
//  FoodBank
//
//  Created by Dogukan Gundogan on 1/10/22.
//

import Foundation

class FoodDetailRouter:PresenterToRouterFoodDetailProtocol{
    static func createModule(ref: FoodDetailVC) {
        let presenter = FoodDetailPresenter()
        ref.presenter = presenter
        ref.presenter?.interactor = FoodDetailInteractor()
        ref.presenter?.view = ref
        ref.presenter?.interactor?.presenter = presenter
    }
    
    
}
