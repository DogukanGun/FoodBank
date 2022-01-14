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
    let minumumDeliveryPriceForFree = 50.0
    let segueToAddSplashScreen = "AddSplashScreenVC"
    let segueToChooseCreditCardScreen = "ChooseCreditCardVC"

}

class ShoppingCartVC:UIViewController{
    @IBOutlet weak var subtotalLabel: UILabel!
    @IBOutlet weak var taxLabel: UILabel!
    @IBOutlet weak var deliveryFeeLabel: UILabel!
    @IBOutlet weak var totalMoneyLabel: UILabel!
    @IBOutlet weak var procudeToCheckoutButton: UIButton!
    @IBOutlet weak var shoppingListTableView: UITableView!
    
    private var deletedItemIndexPath:IndexPath? = nil
    var shoppingList = [ShoppingCart]()
    var stableShoppingList = [ShoppingCart]()
    let variables = ShoppingCartVariable()
    var presenter:ViewToPresenterShoppingCartProtocol?
    var isUpdate = false
    
    override func viewDidLoad() {
        isUpdate = false
        procudeToCheckoutButton.reshapeButton()
        tableViewDelegate()
        ShoppingCartRouter.createModule(ref: self)
        changeBarColor(color: UIColor.black)
    }
    
    private func tableViewDelegate(){
        shoppingListTableView.register(UINib(nibName: variables.cellNibName, bundle: nil), forCellReuseIdentifier: variables.cellIdentifier)
        shoppingListTableView.delegate = self
        shoppingListTableView.dataSource = self
    }
    override func viewWillDisappear(_ animated: Bool) {
        if !isUpdate{
            presenter?.updateShoppingList(newShoppingList: shoppingList,oldShoppingList: stableShoppingList)
            deletePrices()
        }
    }
    
    private func deletePrices(){
        subtotalLabel.text = "0"
        deliveryFeeLabel.text = "0"
        totalMoneyLabel.text = "0"
        taxLabel.text = "0"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        isUpdate = false
        requestData()
    }
    private func requestData(){
        guard let username = userDefaults.string(forKey: Constants.userDefaultsUsername) else{
            return
        }
        presenter?.getShoppingList(userId: username)
    }
    @IBAction func procudeToCheckoutButtonPressed(_ sender: Any) {
        presenter?.updateShoppingList(newShoppingList: shoppingList,oldShoppingList:stableShoppingList)
        requestData()
        isUpdate = true
        if shoppingList.isEmpty{
            errorDialog(title: "Oppss", errorMessage: "Cart is empty", okayButtonText: "Okay")
        }else{
            if !userDefaults.bool(forKey: Constants.isAddedCard){
                performSegue(withIdentifier: variables.segueToAddSplashScreen, sender: nil)
            } 
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == variables.segueToAddSplashScreen{
            let vc = segue.destination as! AddSplashScreenVC
            vc.delegate = self
        }else if segue.identifier == variables.segueToChooseCreditCardScreen{
            let vc = segue.destination as! ChooseCreditCardVC
            vc.shoppingList = shoppingList
        }
    }
}

extension ShoppingCartVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let item = shoppingList[indexPath.row]
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { contextualAction, view, bool in
            let deleteProductRequest = DeleteFoodRequest(productId: item.sepet_yemek_id!)
            self.presenter?.deleteProductFromShoppingList(deleteFoodRequest: deleteProductRequest)
            self.deletedItemIndexPath = indexPath
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: variables.cellIdentifier,for: indexPath) as? ShoppingCartTableViewCell else{
            return UITableViewCell()
        }
        let shoppingItem = shoppingList[indexPath.row]
        cell.refresh(food: shoppingItem)
        cell.indexPath = indexPath
        cell.shoppingCardDelegate = self
        cell.selectionStyle = .none
        return cell
    }
    
    private func changePrice(){
        if shoppingList.isEmpty{
            deletePrices()
        }else{
            var deliveryPrice = 0.0
            var newPrice = 0.0
            var taxPrice = 0.0
            for shoppingItem in shoppingList{
                if let subtotalText = subtotalLabel.text,let subtotal = Double(subtotalText),let itemPriceText = shoppingItem.yemek_fiyat,let itemPrice = Double(itemPriceText){
                    newPrice += Double(Double(shoppingItem.yemek_siparis_adet!)!*itemPrice)
                    deliveryPrice += Double(newPrice*5/100)
                    taxPrice += Double(newPrice*8/100)
                    
                }
            }
            if newPrice > variables.minumumDeliveryPriceForFree{
                deliveryFeeLabel.text = "0"
                deliveryPrice = 0
            }else{
                deliveryFeeLabel.text = "\(String(deliveryPrice))"
            }
            taxLabel.text = "\(String(taxPrice))"
            totalMoneyLabel.text = "\(String(Double(newPrice)+taxPrice+deliveryPrice))"
            subtotalLabel.text = "\(String(newPrice))"
        }
        

    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
}

extension ShoppingCartVC:ShoppingCardDelegate{
    func changePrice(newShoppingCart: ShoppingCart) {
        for i in shoppingList{
            if i.sepet_yemek_id == newShoppingCart.sepet_yemek_id{
                i.yemek_siparis_adet = newShoppingCart.yemek_siparis_adet
            }
        }
        changePrice()
        for index in 0...shoppingList.count-1{
            if shoppingList[index].yemek_adi ?? "" == newShoppingCart.yemek_adi ?? ""{
                shoppingList[index] = newShoppingCart
            }
        }
    }
}
extension ShoppingCartVC:PresenterToViewShoppingCartProtocol{
    func returnDeleteResponse(response: Bool) {
        if response,let indexPath = deletedItemIndexPath{
            self.shoppingListTableView.beginUpdates()
            self.shoppingList.remove(at: indexPath.row)
            self.shoppingListTableView.deleteRows(at: [indexPath], with: .left)
            self.shoppingListTableView.endUpdates()
            changePrice()
        }else{
            errorDialog(title: "Oppss", errorMessage: "Food couldn't be deleted", okayButtonText: "Okay")
        }
    }
    
    func returnShoppingList(shoppingList: [ShoppingCart]) {
        self.shoppingList = shoppingList
        if isUpdate{
            performSegue(withIdentifier: variables.segueToChooseCreditCardScreen, sender: nil)
            return 
        }
        self.stableShoppingList = copyArray(from: shoppingList)
        if shoppingList.isEmpty{
            deletePrices()
        }
        changePrice()
        DispatchQueue.main.async {
            self.shoppingListTableView.reloadData()
        }
    }
    
    private func copyArray(from l1:[ShoppingCart])->[ShoppingCart]{
        var l2 = [ShoppingCart]()
        for i in l1{
            let shoppingCart = ShoppingCart(sepet_yemek_id: i.sepet_yemek_id!, yemek_adi: i.yemek_adi!, yemek_resim_adi: i.yemek_resim_adi!, yemek_fiyat: i.yemek_fiyat!, yemek_siparis_adet: i.yemek_siparis_adet!, kullanici_adi: i.kullanici_adi!)
            l2.append(shoppingCart)
        }
        return l2
    }
}

extension ShoppingCartVC:AddSplashScreenDelegate{
    func cardAdded() {
        if !shoppingList.isEmpty{
            performSegue(withIdentifier: variables.segueToChooseCreditCardScreen, sender: nil)
        }else{
            errorDialog(title: "Oppss", errorMessage: "Cart is empty", okayButtonText: "Okay")
        }
    }
}
