//
//  UIView+makeCircular.swift
//  FoodBank
//
//  Created by Dogukan Gundogan on 1/9/22.
//

import Foundation
import UIKit

extension UIView {
    func makeCircular() {
        self.layer.cornerRadius = min(self.frame.size.height, self.frame.size.width) / 2.0
        self.clipsToBounds = true
    }
}
