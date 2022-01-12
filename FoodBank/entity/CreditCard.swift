//
//  CreditCard.swift
//  FoodBank
//
//  Created by Dogukan Gundogan on 12.01.2022.
//

import Foundation

class CreditCardDto{
    
    var cardNumber:String?
    var cardExpiryDate:String?
    
    init(cardNumber:String,cardExpiryDate:String){
        self.cardNumber = cardNumber
        self.cardExpiryDate = cardExpiryDate
    }
}
