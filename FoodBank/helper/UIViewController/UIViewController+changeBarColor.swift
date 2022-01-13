//
//  UIViewController+changeBarColor.swift
//  FoodBank
//
//  Created by Dogukan Gundogan on 13.01.2022.
//

import Foundation
import UIKit


extension UIViewController{
    func changeBarColor(color:UIColor){
        let apperance = UINavigationBarAppearance()
        apperance.backgroundColor = color
        
        self.navigationController?.navigationBar.standardAppearance = apperance
        self.navigationController?.navigationBar.compactAppearance = apperance
        self.navigationController?.navigationBar.scrollEdgeAppearance = apperance
        self.navigationController?.title = "Food Bank"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "power"), style: .plain, target: #selector(logout), action: .none)
    }
    
    @objc private func logout(){
        userDefaults.removeObject(forKey: Constants.userDefaultsUsername)
        changeRootView()
    }
    private func changeRootView(){
        let storyboard = UIStoryboard(name: Constants.mainStoryboardName, bundle: nil)
        let mainTabBarController = storyboard.instantiateViewController(identifier: Constants.loginPageName)
           
          (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
    }
}
