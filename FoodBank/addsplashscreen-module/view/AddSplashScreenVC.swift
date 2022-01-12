//
//  AddSplashScreenVC.swift
//  FoodBank
//
//  Created by Dogukan Gundogan on 12.01.2022.
//

import Foundation
import UIKit

struct AddSplashScreenVariable{
    let segueToAddCard = "AddCardVC"
}

class AddSplashScreenVC:UIViewController{
    
    var type:AddType?
    @IBOutlet var addButtons: [UIButton]!
    @IBOutlet weak var addImage: UIImageView!
    var variables = AddSplashScreenVariable()
    
    override func viewDidLoad() {
        if let type = type {
            for button in addButtons {
                if Int(button.tag) == type.rawValue{
                    button.reshapeButton()
                }else {
                    button.isHidden = true
                }
            }
            
        }
    }
    
    @IBAction func addAddressButtonPressed(_ sender: UIButton) {
        if Int(sender.tag) == AddType.AddCard.rawValue{
            performSegue(withIdentifier: variables.segueToAddCard, sender: nil)
        }else if Int(sender.tag) == AddType.AddAddress.rawValue{
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == variables.segueToAddCard{
            let vc = segue.destination as! AddCardVC
            vc.delegate = self
        }
    }
    
}

extension AddSplashScreenVC:AddCardDelegate{
    func cardAddPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
