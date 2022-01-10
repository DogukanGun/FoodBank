//
//  ShoppingCardProtocol.swift
//  FoodBank
//
//  Created by Dogukan Gundogan on 1/10/22.
//

import Foundation

protocol ViewToPresenterShoppingCartProtocol{
    var interactor:PresenterToInteractorShoppingCartProtocol? {get set}
    var view:PresenterToViewShoppingCartProtocol? {get set}
    func deleteProductFromShoppingList(productId:String)
    
    func getShoppingList(userId:String)
    
    func updateShoppingList(shoppingList:[Product])
}

protocol PresenterToInteractorShoppingCartProtocol{
    var presenter:InteractorToPresenterShoppingCartProtocol? {get set}
    
    func deleteProductFromShoppingList(productId:String)
    
    func getShoppingList(userId:String)
    
    func updateShoppingList(shoppingList:[Product])
}

protocol InteractorToPresenterShoppingCartProtocol{
    func returnShoppingList(shoppingList:[Product])
}

protocol PresenterToViewShoppingCartProtocol{
    func returnShoppingList(shoppingList:[Product])
}

protocol PresenterToRouterShoppingCartProtocol{
    static func createModule(ref:ShoppingCartVC)
}
