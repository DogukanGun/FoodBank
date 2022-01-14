//
//  ProfileInteractor.swift
//  FoodBank
//
//  Created by Dogukan Gundogan on 14.01.2022.
//

import Foundation
import Firebase

class ProfileInteractor:PresenterToInteractorProfileProtocol{
    var presenter: InteractorToPresenterProfileProtocol?
    var ref = Database.database().reference()
    
    func getData() {
        let status = userDefaults.bool(forKey: Constants.userDefaultsFirstTime)
        if !status{
            getNotSavedUserData()
        }
        getSavedUserData()

    }
    private func getNotSavedUserData(){
        ref.child("settings").child(userDefaults.string(forKey: Constants.userDefaultsUsername)!).childByAutoId().setValue(["setting_id":"","settingName":"Email","settingType":"mail","buttonName":"Edit","imageName":"mail.fill"])
        ref.child("settings").child(userDefaults.string(forKey: Constants.userDefaultsUsername)!).childByAutoId().setValue(["setting_id":"","settingName":"Birthday","settingType":"date","buttonName":"Edit","imageName":"calendar.circle.fill"])
        ref.child("settings").child(userDefaults.string(forKey: Constants.userDefaultsUsername)!).childByAutoId().setValue(["setting_id":"","settingName":"Gender","settingType":"switch","buttonName":"Change","imageName":"person.fill"])
        userDefaults.set(true, forKey: Constants.userDefaultsFirstTime)
    }
    private func getSavedUserData(){
        ref.child("settings").child(userDefaults.string(forKey: Constants.userDefaultsUsername)!).observe(.value) { snapshot in
            var list = [Setting]()
            if let databaseData = snapshot.value as? [String:AnyObject]{
                for index in databaseData{
                    if let dict = index.value as? NSDictionary{
                        let settingId = index.key
                        let settingName = dict["settingName"] as? String ?? ""
                        let settingType = dict["settingType"] as? String ?? ""
                        let settingImageName = dict["imageName"] as? String ?? ""
                        let settingButtonName = dict["buttonName"] as? String ?? ""
                        let setting = Setting(settingId:settingId,iconImageText: settingImageName, settingLabel: settingName,settingType:settingType,settingButtonName: settingButtonName)
                        list.append(setting)
                    }
                }
                self.presenter?.sendData(settings: list)
            }
        }
    }
    func saveValue(setting:Setting){
        ref.child("settings").child(userDefaults.string(forKey: Constants.userDefaultsUsername)!).child(setting.settingId).updateChildValues(["settingName":setting.settingLabel])
        getData()

    }
}
