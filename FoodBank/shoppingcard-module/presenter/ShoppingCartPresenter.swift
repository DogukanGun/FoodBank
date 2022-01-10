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
    
    func deleteProductFromShoppingList(productId: String) {
        interactor?.deleteProductFromShoppingList(productId: productId)
    }
    
    func getShoppingList(userId: String) {
        interactor?.getShoppingList(userId: userId)
    }
    
    func updateShoppingList(shoppingList: [Product]) {
        interactor?.updateShoppingList(shoppingList: shoppingList)
    }
    
}

extension ShoppingCartPresenter:InteractorToPresenterShoppingCartProtocol{
    func returnShoppingList(shoppingList: [Product]) {
        view?.returnShoppingList(shoppingList: shoppingList)
    } 
}
