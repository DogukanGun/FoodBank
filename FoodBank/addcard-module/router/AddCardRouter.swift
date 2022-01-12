//
//  AddCardRouter.swift
//  FoodBank
//
//  Created by Dogukan Gundogan on 12.01.2022.
//

import Foundation


class AddCardRouter:PresenterToRouterAddCardProtocol{
    static func createModule(ref: AddCardVC) {
        ref.presenter = AddCardPresenter()
        ref.presenter?.interactor = AddCardInteractor()
    }
    
    
}
