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

    func confirmationDialog(title:String,message:String,okayButtonText:String,cancelButtonText:String?,okayButtonResult:DialogButtonPressed?,dialogType:UIAlertController.Style)
    {
        let titleFont = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 25)]
        let titleAttrString = NSMutableAttributedString(string: title, attributes: titleFont)
        let messageFont = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
        let messageAttrString = NSMutableAttributedString(string: message, attributes: messageFont)
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: dialogType)
        alert.setValue(titleAttrString, forKey: "attributedTitle")
        alert.setValue(messageAttrString, forKey: "attributedMessage") 
        let action = UIAlertAction(title: okayButtonText, style: .cancel) { action in
            okayButtonResult?.buttonPressed()
        }
        alert.addAction(action)
        
        guard let cancelButtonText = cancelButtonText else {
            self.navigationController?.present(alert, animated: true, completion: nil)
            return
        }
        
        let actionCancel = UIAlertAction(title: cancelButtonText, style: .default) { action in
            okayButtonResult?.buttonPressed()
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
    
    func userInputDialog(userInputType:UserInputType,value:Any?,result:@escaping  (String)->Void){
        var inputType = UITextContentType.name
        var returnedValue = ""
        if userInputType == .Setting{
            inputType = (value as! Setting).getTextFieldType()
            let alert = UIAlertController(title:(value as! Setting).settingType.uppercased(), message: "Please Enter Your \((value as! Setting).settingType)", preferredStyle: .alert)
            alert.addTextField { textField in
                textField.textContentType = inputType
            }
            alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { [weak alert] (_) in
                let textField = alert?.textFields![0]
                returnedValue = textField!.text!
                result(returnedValue)
            }))
            self.present(alert, animated: true,completion: nil)
        }
    }
     
}
