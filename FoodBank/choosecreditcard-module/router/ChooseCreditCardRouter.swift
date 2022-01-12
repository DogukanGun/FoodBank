//
//  ChooseCreditCardRouter.swift
//  FoodBank
//
//  Created by Dogukan Gundogan on 13.01.2022.
//

import Foundation

class ChooseCreditCardRouter:PresenterToRouterChooseCreditCardProtocol{
    static func createModule(ref: ChooseCreditCardVC) {
        let presenter = ChooseCreditCardPresenter()
        
        ref.presenter = presenter
        ref.presenter?.interactor = ChooseCreditCardInteractor()
        ref.presenter?.view = ref
        ref.presenter?.interactor?.presenter = presenter
    }
     
}
