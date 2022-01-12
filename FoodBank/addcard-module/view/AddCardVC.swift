//
//  AddCardVC.swift
//  FoodBank
//
//  Created by Dogukan Gundogan on 12.01.2022.
//

import Foundation
import UIKit

struct AddCardVariable{
    let imageName = "creditCardImage"
    let cardNumberTag = 1001
    let monthNumberTag = 1002
    let yearNumberTag = 1003
    let cardWrapperCornerRadious = CGFloat(20)
}
class AddCardVC:UIViewController{
    
    @IBOutlet weak var addCardButton: UIButton!
    @IBOutlet weak var cardNumberTextField: UITextField!
    @IBOutlet weak var cardWrapper: UIView!
     
    @IBOutlet weak var monthTextField: UITextField!
    @IBOutlet weak var yearTextField: UITextField!
    
    let variables = AddCardVariable()
    var presenter:ViewToPresenterAddCardProtocol?
    var delegate:AddCardDelegate?
    
    override func viewDidLoad() {
        cardWrapper.layer.cornerRadius = variables.cardWrapperCornerRadious
        addCardButton.reshapeButton()
        cardNumberTextField.attributedPlaceholder = NSAttributedString(
            string: "1234 5678 1234 5678",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray4]
        )
        monthTextField.attributedPlaceholder = NSAttributedString(
            string: "01",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray4]
        )
        yearTextField.attributedPlaceholder = NSAttributedString(
            string: "2022",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray4]
        )
        cardNumberTextField.delegate = self
        cardNumberTextField.addTarget(self, action: #selector(self.textChange(_:)), for: .editingChanged)
        monthTextField.delegate = self
        yearTextField.delegate = self
        AddCardRouter.createModule(ref:self)
    }
    
    
    @IBAction func addCardButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        guard let cardNumber = cardNumberTextField.text, let month = monthTextField.text, let year = yearTextField.text else {
            return
        }
        let creditCardDto = CreditCardDto(cardNumber: cardNumber, cardExpiryDate: month+"/"+year)
        presenter?.saveData(creditCard: creditCardDto)
        delegate?.cardAddPressed()
    }
}

extension AddCardVC:UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                           replacementString string: String) -> Bool
    {
        guard let text = textField.text else {
            return true
        }
        if string == ""{
            return true
        }
        var maxLength = 0
        if textField.tag == variables.cardNumberTag{
            maxLength = 20
        }else if textField.tag == variables.monthNumberTag{
            maxLength = 2
        }else if textField.tag == variables.yearNumberTag{
            maxLength = 4
        }
        return text.count + string.count <= maxLength
    }
    
    @objc func textChange(_ textField: UITextField){
        guard var text = textField.text else {
            return
        }
        text = text.replacingOccurrences(of: " ", with: "")
        if text.count % 4 == 0{
            textField.text! += " "
        }
    }
}

protocol AddCardDelegate{
    func cardAddPressed()
}
