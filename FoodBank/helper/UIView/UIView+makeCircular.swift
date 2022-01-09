//
//  UIView+makeCircular.swift
//  FoodBank
//
//  Created by Dogukan Gundogan on 1/9/22.
//

import Foundation
import UIKit

extension UIView {
    //UIScreen.main.bounds.width
    func makeCircular(width:CGFloat) {
        let newWidth:CGFloat = width*1.6
        self.frame = CGRect(x: 0,y: 0,width: newWidth,height: newWidth)
         self.layer.cornerRadius = newWidth/2
        
    }
}
