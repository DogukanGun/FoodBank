//
//  Category.swift
//  FoodBank
//
//  Created by Dogukan Gundogan on 1/10/22.
//

import Foundation

class Category{
    var categoryName:String?
    var filter:FoodListFilter?
    
    init(categoryName:String,filter:FoodListFilter?){
        self.categoryName = categoryName
        self.filter = filter
    }
}
