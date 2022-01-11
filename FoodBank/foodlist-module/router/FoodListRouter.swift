//
//  FoodListRouter.swift
//  FoodBank
//
//  Created by Dogukan Gundogan on 1/11/22.
//

import Foundation

class FoodListRouter:PresenterToRouterFoodListProtocol{
    static func createModule(ref: FoodListVC) {
        let presenter = FoodListPresenter()
        
        ref.presenter = presenter
        ref.presenter?.interactor = FoodListInteractor()
        ref.presenter?.interactor?.presenter = presenter
        ref.presenter?.view = ref
    }
    
    
}
