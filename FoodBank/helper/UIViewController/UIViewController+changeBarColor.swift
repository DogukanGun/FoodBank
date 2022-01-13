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
    }
}
