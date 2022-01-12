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
    
    @IBOutlet var addButtons: [UIButton]!
    @IBOutlet weak var addImage: UIImageView!
    var variables = AddSplashScreenVariable()
    var delegate:AddSplashScreenDelegate?
    override func viewDidLoad() {
    
    }
    
    @IBAction func addAddressButtonPressed(_ sender: UIButton) {
        if Int(sender.tag) == SplashScreen.AddCard.rawValue{
            performSegue(withIdentifier: variables.segueToAddCard, sender: nil)
        }else if Int(sender.tag) == SplashScreen.Pay.rawValue{
            
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
        self.navigationController?.popViewController(animated: false)
        delegate?.cardAdded()
    }
}

protocol AddSplashScreenDelegate{
    func cardAdded()
}
