//
//  FoodDetailProtocols.swift
//  FoodBank
//
//  Created by Dogukan Gundogan on 1/10/22.
//

import Foundation

protocol ViewToPresenterFoodDetailProtocol{
    var interactor:PresenterToInteractorFoodDetailProtocol? {get set}
    var view:PresenterToViewFoodDetailProtocol? {get set}
    func addBasket(product:Product)
}

protocol PresenterToInteractorFoodDetailProtocol{
    var presenter:InteractorToPresenterFoodDetailProtocol? {get set}
    func addBasket(product:Product)
}

protocol InteractorToPresenterFoodDetailProtocol{
    func foodAddingResponse(response:String)
}

protocol PresenterToViewFoodDetailProtocol{
    func foodAddingResponse(response:String)
}

protocol PresenterToRouterFoodDetailProtocol{
    static func createModule(ref:FoodDetailVC)
}
