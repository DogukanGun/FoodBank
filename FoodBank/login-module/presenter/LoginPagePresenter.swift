//
//  LoginPresenter.swift
//  FoodBank
//
//  Created by Dogukan Gundogan on 1/10/22.
//

import Foundation

class LoginPagePresenter:ViewToPresenterLoginPageProtocol{
    var interactor: PresenterToInteractorLoginPageProtocol?
    func saveName(name: String) {
        interactor?.saveName(name: name)
    }
}
