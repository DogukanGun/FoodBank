//
//  ShoppingCartInteractor.swift
//  FoodBank
//
//  Created by Dogukan Gundogan on 1/10/22.
//

import Foundation

class ShoppingCartInteractor:PresenterToInteractorShoppingCartProtocol{
    var presenter: InteractorToPresenterShoppingCartProtocol?
    
    func deleteProductFromShoppingList(productId: String) {
        
    }
    
    func getShoppingList(userId: String) {
        let list = [Product]()
        presenter?.returnShoppingList(shoppingList: list)
    }
    
    func updateShoppingList(shoppingList: [Product]) {
        
    }
    
    
}
