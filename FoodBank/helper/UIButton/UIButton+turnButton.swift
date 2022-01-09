//
//  UIButton+turnButton.swift
//  FoodBank
//
//  Created by Dogukan Gundogan on 1/9/22.
//

import Foundation
import UIKit

extension UIButton{
    func turnButton(ratio:Double){
        self.transform = self.transform.rotated(by: CGFloat(ratio))

    }
}
