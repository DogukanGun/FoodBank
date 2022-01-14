//
//  ProfileRouter.swift
//  FoodBank
//
//  Created by Dogukan Gundogan on 14.01.2022.
//

import Foundation

class ProfileRouter:PresenterToRouterProfileProtocol{
    static func createModule(ref: ProfileVC) {
        let presenter = ProfilePresenter()
        
        ref.presenter = presenter
        ref.presenter?.view = ref
        ref.presenter?.interactor = ProfileInteractor()
        ref.presenter?.interactor?.presenter = presenter
    }
    
    
}
