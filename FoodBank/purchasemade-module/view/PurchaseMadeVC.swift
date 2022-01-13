//
//  PurchaseMadeVC.swift
//  FoodBank
//
//  Created by Dogukan Gundogan on 13.01.2022.
//

import Foundation
import UIKit
import Lottie

class PurchaseMadeVC:UIViewController{
    
    var animationView:AnimationView?
    
    override func viewDidLoad() {
        navigationController?.navigationItem.hidesBackButton = true
        animationView = .init(name:"purchase-made")
        animationView?.frame = view.bounds
        animationView?.loopMode = .repeat(3)
        view.addSubview(animationView!)
        animationView?.play(completion: { bool in
            if bool{
                self.navigationController?.popToRootViewController(animated: false)
            }
        })
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
}
