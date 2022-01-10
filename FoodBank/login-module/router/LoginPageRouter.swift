//
//  LoginPageRouter.swift
//  FoodBank
//
//  Created by Dogukan Gundogan on 1/10/22.
//

import Foundation

class LoginPageRouter:PresenterToRouterLoginPageProtocol{
    static func createModule(ref: LoginVC) {
        ref.presenter = LoginPagePresenter()
        ref.presenter?.interactor = LoginPageInteractor()
    }
    
    
}
