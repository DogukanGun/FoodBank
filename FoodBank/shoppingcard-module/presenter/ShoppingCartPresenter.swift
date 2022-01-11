//
//  ShoppingCartPresenter.swift
//  FoodBank
//
//  Created by Dogukan Gundogan on 1/10/22.
//

import Foundation


class ShoppingCartPresenter:ViewToPresenterShoppingCartProtocol{
    var interactor: PresenterToInteractorShoppingCartProtocol?
    
    var view: PresenterToViewShoppingCartProtocol?
    
    func deleteProductFromShoppingList(deleteFoodRequest: DeleteFoodRequest) {
        interactor?.deleteProductFromShoppingList(deleteFoodRequest: deleteFoodRequest)
    }
    
    func getShoppingList(userId: String) {
        interactor?.getShoppingList(userId: userId)
    }
    
    func updateShoppingList(newShoppingList: [ShoppingCart],oldShoppingList:[ShoppingCart]) {
        interactor?.updateShoppingList(newShoppingList: newShoppingList,oldShoppingList: oldShoppingList)
    }
    
}

extension ShoppingCartPresenter:InteractorToPresenterShoppingCartProtocol{
    func returnDeleteResponse(response: Bool) {
        view?.returnDeleteResponse(response: response)
    }
    
    func returnShoppingList(shoppingList: [ShoppingCart]) {
        view?.returnShoppingList(shoppingList: shoppingList)
    } 
}
