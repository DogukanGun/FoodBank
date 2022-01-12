//
//  Array+filterFoods.swift
//  FoodBank
//
//  Created by Dogukan Gundogan on 12.01.2022.
//

import Foundation

extension String{
    func filterFoods(filterType:FoodListFilter)->Bool{
        let dessertFilter = ["Kadayıf","Baklava","Tiramusu"]
        let drinkFilter = ["Ayran","Fanta","Kahve","Su","Sütlaç"]
        switch filterType {
        case .All:
            return true
        case .Dessert:
            if dessertFilter.contains(self){
                return true
            }else{
                return false
            }
        case .Food:
            if drinkFilter.contains(self) || dessertFilter.contains(self){
                return false
            }else{
                return true
            }
        case .Drink:
            if drinkFilter.contains(self){
                return true
            }else{
                return false
            }
        }
    }
}
