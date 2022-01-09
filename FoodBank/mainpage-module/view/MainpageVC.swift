//
//  MainpageVC.swift
//  FoodBank
//
//  Created by Dogukan Gundogan on 1/9/22.
//

import Foundation
import UIKit

class MainpageVC:UIViewController{

    @IBAction func logoutButtonPressed(_ sender: Any) {
        userDefaults.removeObject(forKey: Constants.userDefaultsUsername)
        changeRootView()
    }
    private func changeRootView(){
        let storyboard = UIStoryboard(name: Constants.mainStoryboardName, bundle: nil)
        let mainTabBarController = storyboard.instantiateViewController(identifier: Constants.loginPageName)
           
          (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
    }
}
