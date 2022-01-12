//
//  ChooseCreditCardProtocols.swift
//  FoodBank
//
//  Created by Dogukan Gundogan on 13.01.2022.
//

import Foundation

protocol ViewToPresenterChooseCreditCardProtocol{
    var interactor:PresenterToInteractorChooseCreditCardProtocol? {get set}
    var view:PresenterToViewChooseCreditCardProtocol? {get set}
    func getData()
    func deleteData(shoppingCards:[ShoppingCart])
}

protocol PresenterToInteractorChooseCreditCardProtocol{
    var presenter:InteractorToPresenterChooseCreditCardProtocol? {get set}
    func getData()
    func deleteData(shoppingCards:[ShoppingCart])
}

protocol InteractorToPresenterChooseCreditCardProtocol{
    func sendData(creditCards:[CreditCard])
}

protocol PresenterToViewChooseCreditCardProtocol{
    func sendData(creditCards:[CreditCard])
}

protocol PresenterToRouterChooseCreditCardProtocol{
    static func createModule(ref:ChooseCreditCardVC)
}
