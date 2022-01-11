//
//  MainpageProtocols.swift
//  FoodBank
//
//  Created by Dogukan Gundogan on 1/10/22.
//

import Foundation

protocol ViewToPresenterMainpageProtocol{
    var interactor:PresenterToInteractorMainpageProtocol? {get set}
    var view:PresenterToViewMainpageProtocol? {get set}
    func getData()
    func addFoodToShoppingCart(shoppingCardItem:AddFoodToShoppingCartRequest)
}
protocol PresenterToInteractorMainpageProtocol{
    var presenter:InteractorToPresenterMainpageProtocol? {get set}
    func getData()
    func addFoodToShoppingCart(shoppingCardItem:AddFoodToShoppingCartRequest)
}

protocol InteractorToPresenterMainpageProtocol{
    func sendData(products:[Product])
    func foodAddingResponse(response:String)
}
protocol PresenterToViewMainpageProtocol{
    func sendData(products:[Product])
    func foodAddingResponse(response:String)
}

protocol PresenterToRouterMainpageProtocol{
    static func createModule(ref:MainpageVC)
}
