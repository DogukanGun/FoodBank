//
//  AddCardProtocols.swift
//  FoodBank
//
//  Created by Dogukan Gundogan on 12.01.2022.
//

import Foundation


protocol ViewToPresenterAddCardProtocol{
    var interactor:PresenterToInteractorAddCardProtocol? {get set}
    func saveData(creditCard:CreditCardDto)
}

protocol PresenterToInteractorAddCardProtocol{
    func saveData(creditCard:CreditCardDto)
}

protocol PresenterToRouterAddCardProtocol{
    static func createModule(ref:AddCardVC)
}
