//
//  AddCardInteractor.swift
//  FoodBank
//
//  Created by Dogukan Gundogan on 12.01.2022.
//

import Foundation


class AddCardInteractor:PresenterToInteractorAddCardProtocol{
    let context = appDelegate.persistentContainer.viewContext
    func saveData(creditCard: CreditCardDto) {
        let creditCardEntity = CreditCard(context: context)
        guard let cardNumber = creditCard.cardNumber, let cardExpiryDate = creditCard.cardExpiryDate else{
            return
        }
        creditCardEntity.cardNumber = cardNumber
        creditCardEntity.cardExpiryDate = cardExpiryDate
        
        appDelegate.saveContext()
        
        
        if !userDefaults.bool(forKey: Constants.isAddedCard){
            userDefaults.set(true, forKey: Constants.isAddedCard)
        }
        
    }
    
    
}
