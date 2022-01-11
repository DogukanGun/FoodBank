//
//  FoodListProtocols.swift
//  FoodBank
//
//  Created by Dogukan Gundogan on 1/11/22.
//

import Foundation



protocol ViewToPresenterFoodListProtocol{
    var interactor:PresenterToInteractorFoodListProtocol? {get set}
    var view:PresenterToViewFoodListProtocol? {get set}
    func getData()
}
protocol PresenterToInteractorFoodListProtocol{
    var presenter:InteractorToPresenterFoodListProtocol? {get set}
    func getData()
}

protocol InteractorToPresenterFoodListProtocol{
    func sendData(products:[Product])
}
protocol PresenterToViewFoodListProtocol{
    func sendData(products:[Product])
}

protocol PresenterToRouterFoodListProtocol{
    static func createModule(ref:FoodListVC)
}
