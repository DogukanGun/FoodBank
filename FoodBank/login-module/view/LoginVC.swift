//
//  LoginVC.swift
//  FoodBank
//
//  Created by Dogukan Gundogan on 1/9/22.
//

import Foundation
import UIKit

class LoginVC:UIViewController{
    
    @IBOutlet weak var loginWrapper: UIView!
    @IBOutlet var mainWrapper: UIView!
    
    override func viewDidLoad() {
        editBackground()
        loginWrapper.makeCircular()

    }
    
    private func editBackground(){
        if let image = UIImage(named: "BackgroundImage"){
            let imageView = UIImageView(frame: CGRect(x: 0, y: -20, width: mainWrapper.bounds.width, height: mainWrapper.bounds.height))
            imageView.contentMode = .scaleAspectFit
            imageView.image = image
            mainWrapper.addSubview(imageView)
            self.mainWrapper.sendSubviewToBack(imageView)
        }
    }
}
