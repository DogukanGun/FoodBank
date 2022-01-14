//
//  ProfilePresenter.swift
//  FoodBank
//
//  Created by Dogukan Gundogan on 14.01.2022.
//

import Foundation

class ProfilePresenter:ViewToPresenterProfileProtocol{
    
    var interactor: PresenterToInteractorProfileProtocol?
    
    var view: PresenterToViewProfileProtocol?
    
    func getData() {
        interactor?.getData()
    }
    
    func saveValue(setting: Setting) {
        interactor?.saveValue(setting: setting)
    }
}

extension ProfilePresenter:InteractorToPresenterProfileProtocol{
    func sendData(settings: [Setting]) {
        let newSettings = settings.sorted { s1, s2 in
            if s1.settingType>s2.settingType{
                return true
            }
            return false
        }
        view?.sendData(settings: newSettings)
    } 
}
