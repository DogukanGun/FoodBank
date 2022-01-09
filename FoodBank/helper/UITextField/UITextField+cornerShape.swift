//
//  UITextField+cornerShape.swift
//  FoodBank
//
//  Created by Dogukan Gundogan on 1/9/22.
//

import Foundation
import UIKit

extension UITextField{
    func cornerShape(cornerRadious:CGFloat = 25){
        //To apply corner
        self.layer.cornerRadius = cornerRadious
        
        //To apply border
        self.layer.borderWidth = 0.25
        self.layer.borderColor = UIColor.white.cgColor

        //To apply Shadow
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 3.0
        self.layer.shadowOffset = CGSize.zero // Use any CGSize
        self.layer.shadowColor = UIColor.gray.cgColor

        //To apply padding
        let paddingView : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = UITextField.ViewMode.always
        
        //To add image
        if let image = UIImage(systemName: "person"){
            
            let imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 20, height: 20))
            imageView.image = image
            let imageContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 55, height: 40))
            imageContainerView.addSubview(imageView)
            rightView = imageContainerView
            rightViewMode = .always
            self.tintColor = .lightGray
            
        }

    }
}
