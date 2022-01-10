//
//  LoginPageInteractor.swift
//  FoodBank
//
//  Created by Dogukan Gundogan on 1/10/22.
//

import Foundation

class LoginPageInteractor:PresenterToInteractorLoginPageProtocol{
    func saveName(name: String) {
        userDefaults.set(name, forKey: Constants.userDefaultsUsername)
    } 
}
