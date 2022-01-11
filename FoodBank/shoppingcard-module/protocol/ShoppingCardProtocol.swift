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
    func deleteProductFromShoppingList(deleteFoodRequest: DeleteFoodRequest)
    
    func getShoppingList(userId:String)
    
    func updateShoppingList(newShoppingList:[ShoppingCart],oldShoppingList:[ShoppingCart])
}

protocol PresenterToInteractorShoppingCartProtocol{
    var presenter:InteractorToPresenterShoppingCartProtocol? {get set}
    
    func deleteProductFromShoppingList(deleteFoodRequest: DeleteFoodRequest)
    
    func getShoppingList(userId:String)
    
    func updateShoppingList(newShoppingList:[ShoppingCart],oldShoppingList:[ShoppingCart])
}

protocol InteractorToPresenterShoppingCartProtocol{
    func returnShoppingList(shoppingList:[ShoppingCart])
    func returnDeleteResponse(response:Bool)
}

protocol PresenterToViewShoppingCartProtocol{
    func returnShoppingList(shoppingList:[ShoppingCart])
    func returnDeleteResponse(response:Bool)
}

protocol PresenterToRouterShoppingCartProtocol{
    static func createModule(ref:ShoppingCartVC)
}
