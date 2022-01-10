//
//  ShoppingCartRouter.swift
//  FoodBank
//
//  Created by Dogukan Gundogan on 1/10/22.
//

import Foundation


class ShoppingCartRouter:PresenterToRouterShoppingCartProtocol{
    static func createModule(ref: ShoppingCartVC) {
        let presenter = ShoppingCartPresenter()
        
        ref.presenter = presenter
        ref.presenter?.interactor = ShoppingCartInteractor()
        ref.presenter?.view = ref
        ref.presenter?.interactor?.presenter = presenter
    }
    
    
}
