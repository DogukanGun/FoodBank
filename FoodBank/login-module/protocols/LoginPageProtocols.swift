//
//  LoginPageProtocols.swift
//  FoodBank
//
//  Created by Dogukan Gundogan on 1/10/22.
//

import Foundation

protocol ViewToPresenterLoginPageProtocol{
    var interactor:PresenterToInteractorLoginPageProtocol? {get set}
    func saveName(name:String)
}

protocol PresenterToInteractorLoginPageProtocol{
    func saveName(name:String)
}

protocol PresenterToRouterLoginPageProtocol{
    static func createModule(ref:LoginVC)
}


