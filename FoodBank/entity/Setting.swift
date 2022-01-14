//
//  Setting.swift
//  FoodBank
//
//  Created by Dogukan Gundogan on 14.01.2022.
//

import Foundation
import UIKit


class Setting{
    var iconImageText = ""
    var settingLabel = ""
    var settingId = ""
    var settingButtonName = ""
    var settingType = ""
    
    init(settingId:String,iconImageText:String,settingLabel:String,settingType:String,settingButtonName:String){
        self.settingId = settingId
        self.iconImageText = iconImageText
        self.settingLabel = settingLabel
        self.settingButtonName = settingButtonName
        self.settingType = settingType
    }
    
    func getTextFieldType()->UITextContentType{
        if settingType.lowercased().contains("mail"){
            return UITextContentType.emailAddress
        }else if settingType.lowercased().contains("date"){
            return UITextContentType.dateTime
        }else{
            return UITextContentType.name
        }
    }
    
    
    func getInputType()->ViewType{
        if settingButtonName.lowercased() == "edit"{
            return ViewType.TextField
        }else if settingButtonName.lowercased() == "change"{
            return ViewType.SwitchButton
        }else{
            return ViewType.TextField
        }
    }
}
