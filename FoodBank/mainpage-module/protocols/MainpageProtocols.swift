//
//  MainpageProtocols.swift
//  FoodBank
//
//  Created by Dogukan Gundogan on 1/10/22.
//

import Foundation

protocol ViewToPresenterMainpageProtocol{
    var interactor:PresenterToInteractorMainpageProtocol? {get set}
    var view:PresenterToViewMainpageProtocol? {get set}
    func getData()
}
protocol PresenterToInteractorMainpageProtocol{
    var presenter:InteractorToPresenterMainpageProtocol? {get set}
    func getData()
}

protocol InteractorToPresenterMainpageProtocol{
    func sendData(products:[Product])
}
protocol PresenterToViewMainpageProtocol{
    func sendData(products:[Product])
}

protocol PresenterToRouterMainpageProtocol{
    static func createModule(ref:MainpageVC)
}
