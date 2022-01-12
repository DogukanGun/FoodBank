//
//  ChooseCreditCardPresenter.swift
//  FoodBank
//
//  Created by Dogukan Gundogan on 13.01.2022.
//

import Foundation

class ChooseCreditCardPresenter:ViewToPresenterChooseCreditCardProtocol{
    var interactor: PresenterToInteractorChooseCreditCardProtocol?
    
    var view: PresenterToViewChooseCreditCardProtocol?
    
    func getData() {
        interactor?.getData()
    }
    
    func deleteData(shoppingCards: [ShoppingCart]) {
        interactor?.deleteData(shoppingCards: shoppingCards)
    }
}

extension ChooseCreditCardPresenter:InteractorToPresenterChooseCreditCardProtocol{
    func sendData(creditCards: [CreditCard]) {
        view?.sendData(creditCards: creditCards)
    }
    
    
}
