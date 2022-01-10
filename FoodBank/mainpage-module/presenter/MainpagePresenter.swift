//
//  MainpagePresenter.swift
//  FoodBank
//
//  Created by Dogukan Gundogan on 1/10/22.
//

import Foundation


class MainpagePresenter:ViewToPresenterMainpageProtocol{
    var interactor: PresenterToInteractorMainpageProtocol?
    var view: PresenterToViewMainpageProtocol?
    
    func getData() {
        interactor?.getData()
    }
}

extension MainpagePresenter:InteractorToPresenterMainpageProtocol{
    func sendData(products: [Product]) {
        view?.sendData(products: products)
    }
}
