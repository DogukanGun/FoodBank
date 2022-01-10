//
//  ShoppingCartVC.swift
//  FoodBank
//
//  Created by Dogukan Gundogan on 1/10/22.
//

import Foundation
import UIKit

struct ShoppingCartVariable{
    let cellIdentifier = "ShoppingCartTableViewCell"
    let cellNibName = "ShoppingCartTableViewCell"
}

class ShoppingCartVC:UIViewController{
    @IBOutlet weak var subtotalLabel: UILabel!
    @IBOutlet weak var taxLabel: UILabel!
    @IBOutlet weak var deliveryFeeLabel: UILabel!
    @IBOutlet weak var totalMoneyLabel: UILabel!
    @IBOutlet weak var procudeToCheckoutButton: UIButton!
    @IBOutlet weak var shoppingListTableView: UITableView!
    
    var shoppingList = [Product]()
    let variables = ShoppingCartVariable()
    var presenter:ViewToPresenterShoppingCartProtocol?
    
    override func viewDidLoad() {
        procudeToCheckoutButton.reshapeButton()
        shoppingListTableView.register(UINib(nibName: variables.cellNibName, bundle: nil), forCellReuseIdentifier: variables.cellIdentifier)
        ShoppingCartRouter.createModule(ref: self)
    }
    
    @IBAction func procudeToCheckoutButtonPressed(_ sender: Any) {
        presenter?.updateShoppingList(shoppingList: shoppingList)
    }
}

extension ShoppingCartVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: variables.cellIdentifier,for: indexPath) as? ShoppingCartTableViewCell else{
            return UITableViewCell()
        }
        let shoppingItem = shoppingList[indexPath.row]
        cell.refresh(food: shoppingItem)
        return cell 
    }
    
}

extension ShoppingCartVC:ShoppingCardDelegate{
    func deleteButtonPressed(foodId: String) {
        presenter?.deleteProductFromShoppingList(productId: foodId)
    } 
}
extension ShoppingCartVC:PresenterToViewShoppingCartProtocol{
    func returnShoppingList(shoppingList: [Product]) {
        self.shoppingList = shoppingList
        DispatchQueue.main.async {
            self.shoppingListTableView.reloadData()
        }
    }
    
    
}
