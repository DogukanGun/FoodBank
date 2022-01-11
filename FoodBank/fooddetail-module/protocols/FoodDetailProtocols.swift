//
//  FoodDetailProtocols.swift
//  FoodBank
//
//  Created by Dogukan Gundogan on 1/10/22.
//

import Foundation

protocol ViewToPresenterFoodDetailProtocol{
    var interactor:PresenterToInteractorFoodDetailProtocol? {get set}
    func addBasket(product:Product)
}
protocol PresenterToInteractorFoodDetailProtocol{
    func addBasket(product:Product)
}

protocol PresenterToRouterFoodDetailProtocol{
    static func createModule(ref:FoodDetailVC)
}
