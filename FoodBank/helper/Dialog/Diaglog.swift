//
//  Diaglog.swift
//  FoodBank
//
//  Created by Dogukan Gundogan on 1/9/22.
//

import Foundation
import UIKit
 
protocol DialogButtonPressed{
    func buttonPressed()
}

extension UIViewController{

    func confirmationDialog(title:String,message:String,okayButtonText:String,cancelButtonText:String?,okayButtonResult:DialogButtonPressed)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: okayButtonText, style: .cancel) { action in
            okayButtonResult.buttonPressed()
        }
        alert.addAction(action)
        
        guard let cancelButtonText = cancelButtonText else {
            self.navigationController?.present(alert, animated: true, completion: nil)
            return
        }
        
        let actionCancel = UIAlertAction(title: cancelButtonText, style: .default) { action in
            okayButtonResult.buttonPressed()
        }

        alert.addAction(actionCancel)
        self.navigationController?.present(alert, animated: true, completion: nil)
        
    }
    
    func errorDialog(title:String,errorMessage:String,okayButtonText:String){
        let alert = UIAlertController(title: title, message: errorMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: okayButtonText, style: .cancel, handler: nil)
        alert.addAction(action)
        self.navigationController?.present(alert, animated: true, completion: nil)
 
    }
}
