//
//  UIButton+reshape.swift
//  FoodBank
//
//  Created by Dogukan Gundogan on 1/9/22.
//

import Foundation
import UIKit

extension UIButton{
    func reshapeButton(cornerRadious:CGFloat = 12){
        self.layer.cornerRadius = cornerRadious
    }
}
