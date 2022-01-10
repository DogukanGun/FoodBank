//
//  MainpageRouter.swift
//  FoodBank
//
//  Created by Dogukan Gundogan on 1/10/22.
//

import Foundation


class MainpageRouter:PresenterToRouterMainpageProtocol{
    static func createModule(ref: MainpageVC) {
        let presenter = MainpagePresenter()
        
        ref.presenter = presenter
        ref.presenter?.view = ref
        ref.presenter?.interactor = MainpageInteractor()
        ref.presenter?.interactor?.presenter = presenter
    }
}
