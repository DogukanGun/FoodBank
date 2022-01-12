//
//  ChooseCreditCardTableViewCell.swift
//  FoodBank
//
//  Created by Dogukan Gundogan on 13.01.2022.
//

import UIKit

class ChooseCreditCardTableViewCell: UITableViewCell {

    @IBOutlet weak var creditCardNumber: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
       
    }
     
    func refresh(creditCard:CreditCard){
        guard let cardNumber = creditCard.cardNumber else {
            return
        }
        creditCardNumber.text = cardNumber
        if creditCard.isSelectedRow{
            self.accessoryType = .checkmark
        }else{
            self.accessoryType = .none
        }
    }
    
}
