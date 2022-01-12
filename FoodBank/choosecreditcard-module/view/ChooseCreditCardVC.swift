//
//  ChooseCreditCardVC.swift
//  FoodBank
//
//  Created by Dogukan Gundogan on 13.01.2022.
//

import Foundation
import UIKit

struct ChooseCreditCardVariable{
    let cellNibName = "ChooseCreditCardTableViewCell"
    let cellIdentifier = "ChooseCreditCardTableViewCell"
    let segueToAddCreditCard = "AddCardVCFromChooseCreditCardVC"
    let segueToPurchaseMade = "PurchaseMadeVC"
}

class ChooseCreditCardVC:UIViewController{
    
    @IBOutlet weak var payButton: UIButton!
    
    @IBOutlet weak var creditCardTableView: UITableView!
    var variables = ChooseCreditCardVariable()
    var presenter:ViewToPresenterChooseCreditCardProtocol?
    var creditCards = [CreditCard]()
    var shoppingList = [ShoppingCart]()

    
    override func viewDidLoad() {
        creditCardTableView.register(UINib(nibName: variables.cellNibName, bundle: nil), forCellReuseIdentifier: variables.cellIdentifier)
        creditCardTableView.delegate = self
        creditCardTableView.dataSource = self
        ChooseCreditCardRouter.createModule(ref: self)
        payButton.reshapeButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter?.getData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == variables.segueToAddCreditCard{
            let vc = segue.destination as! AddCardVC
            vc.delegate = self
        }
    }
    
    @IBAction func payButtonPressed(_ sender: Any) {
        presenter?.deleteData(shoppingCards: shoppingList)
        performSegue(withIdentifier: variables.segueToPurchaseMade, sender: nil)
    }
    
}
extension ChooseCreditCardVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return creditCards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: variables.cellIdentifier, for: indexPath) as? ChooseCreditCardTableViewCell else {
            return UITableViewCell()
        }
        let creditCard = creditCards[indexPath.row]
        cell.refresh(creditCard: creditCard)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCreditCard = creditCards[indexPath.row]
        for creditCard in creditCards {
            if selectedCreditCard != creditCard {
                creditCard.isSelectedRow = false
            }else{
                selectedCreditCard.isSelectedRow = true
            }
        }
        tableView.reloadData()
    }
     
}
extension ChooseCreditCardVC:PresenterToViewChooseCreditCardProtocol{
    func sendData(creditCards: [CreditCard]) {
        self.creditCards = creditCards
        DispatchQueue.main.async {
            self.creditCardTableView.reloadData()
        }
    }
}

extension ChooseCreditCardVC:AddCardDelegate{
    func cardAddPressed() {
        presenter?.getData()
    }
}
