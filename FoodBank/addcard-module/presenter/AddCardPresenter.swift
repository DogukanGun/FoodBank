//
//  AddCardPresenter.swift
//  FoodBank
//
//  Created by Dogukan Gundogan on 12.01.2022.
//

import Foundation

class AddCardPresenter:ViewToPresenterAddCardProtocol{
    var interactor: PresenterToInteractorAddCardProtocol?
    func saveData(creditCard: CreditCardDto) {
        interactor?.saveData(creditCard: creditCard)
    }
}


