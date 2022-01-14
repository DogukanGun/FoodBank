//
//  ProfileProtocols.swift
//  FoodBank
//
//  Created by Dogukan Gundogan on 14.01.2022.
//

import Foundation

protocol ViewToPresenterProfileProtocol{
    var interactor:PresenterToInteractorProfileProtocol? {get set}
    var view:PresenterToViewProfileProtocol? {get set}
    func getData()
    func saveValue(setting:Setting)
}

protocol PresenterToInteractorProfileProtocol{
    var presenter:InteractorToPresenterProfileProtocol? {get set}
    func getData()
    func saveValue(setting:Setting)
}

protocol InteractorToPresenterProfileProtocol{
    func sendData(settings:[Setting])
}

protocol PresenterToViewProfileProtocol{
    func sendData(settings:[Setting])
}

protocol PresenterToRouterProfileProtocol{
    static func createModule(ref:ProfileVC)
}
