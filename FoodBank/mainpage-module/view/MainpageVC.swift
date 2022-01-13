//
//  MainpageVC.swift
//  FoodBank
//
//  Created by Dogukan Gundogan on 1/9/22.
//

import Foundation
import UIKit
import SwiftUI

struct MainpageVariable{
    let headerCell = "HeaderTableViewCell"
    let categoryWrapperCell = "CategoryWrapperTableViewCell"
    let productCell = "ProductTableViewCell"
    let headerNibName = "HeaderTableViewCell"
    let categoryWrapperNibName = "CategoryWrapperTableViewCell"
    let productNibName = "ProductTableViewCell"
    let headerCellHeight = CGFloat(156)
    let categoryCellHeight = CGFloat(210)
    let productCellHeight = CGFloat(250)
    let tableViewHeaderIdentifier = "TableViewSectionHeaderTableViewCell"
    let tableViewNibName = "TableViewSectionHeaderTableViewCell"
    let sectionNumber = 3
    let segueIdentifierToFoodDetail = "FoodDetailVC"
    let segueIdentifierToFoodList = "FoodListVC"
    let sectionOneTitle = "Categories"
    let sectionTwoTitle = "Populars"
}

class MainpageVC:UIViewController{

    var variables = MainpageVariable()
    var products = [Product]()
    @IBOutlet weak var mainpageTableView: UITableView!
    var presenter:ViewToPresenterMainpageProtocol? = nil
    override func viewDidLoad() {
        delegateTableView()
        MainpageRouter.createModule(ref: self)
        presenter?.getData()
        changeBarColor(color: UIColor.black)
    }
    private func delegateTableView(){
        mainpageTableView.delegate = self
        mainpageTableView.dataSource = self
        mainpageTableView.register(UINib(nibName: variables.tableViewNibName, bundle: nil), forHeaderFooterViewReuseIdentifier: variables.tableViewHeaderIdentifier)
        mainpageTableView.register(UINib(nibName: variables.categoryWrapperCell, bundle: nil), forCellReuseIdentifier: variables.categoryWrapperNibName)
        mainpageTableView.register(UINib(nibName: variables.headerNibName, bundle: nil), forCellReuseIdentifier: variables.headerCell)
        mainpageTableView.register(UINib(nibName: variables.productNibName, bundle: nil), forCellReuseIdentifier: variables.productCell)
    }
    
}

extension MainpageVC:UITableViewDelegate,UITableViewDataSource{
   
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let customHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: variables.tableViewHeaderIdentifier) as? TableViewSectionHeaderTableViewCell else {
            return UITableViewHeaderFooterView()
        }
        if section == 1{
            customHeader.refresh(title: variables.sectionOneTitle)
        }else if section == 2{
            customHeader.refresh(title: variables.sectionTwoTitle)
        }else{
            customHeader.refresh(title:"")
        }
        return customHeader
        

    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 2{
            return products.count
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: variables.headerCell, for: indexPath) as? HeaderTableViewCell else{
                return UITableViewCell()
            }
            cell.delegate = self
            cell.selectionStyle = .none
            return cell
            
        }else if indexPath.section == 1{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: variables.categoryWrapperCell, for: indexPath) as? CategoryWrapperTableViewCell else{
                return UITableViewCell()
            }
            cell.delegate = self
            cell.selectionStyle = .none
            return cell
            
        }else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: variables.productCell, for: indexPath) as? ProductTableViewCell else{
                return UITableViewCell()
            }
            let product = products[indexPath.row]
            cell.refresh(product: product)
            cell.delegate = self
            cell.selectionStyle = .none
            return cell
            
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2{
            let product = products[indexPath.row]
            performSegue(withIdentifier: variables.segueIdentifierToFoodDetail, sender: product)
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return variables.sectionNumber
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return variables.headerCellHeight
        }else if indexPath.section == 1{
            return variables.categoryCellHeight

        }else{
            return variables.productCellHeight
        }
    }
    
}
 
extension MainpageVC:PresenterToViewMainpageProtocol{
    func foodAddingResponse(response: String) {
        errorDialog(title: "Adding Food", errorMessage: response, okayButtonText: "Okay")
    }
    
    func sendData(products: [Product]) {
        self.products = products
        DispatchQueue.main.async {
            self.mainpageTableView.reloadData()
        }
    } 
}

extension MainpageVC{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == variables.segueIdentifierToFoodDetail{
            let vc = segue.destination as! FoodDetailVC
            let product = sender as! Product
            vc.food = product
        }else if segue.identifier == variables.segueIdentifierToFoodList{
            let vc = segue.destination as! FoodListVC
            let filterType = sender as! FoodListFilter
            vc.foodListFilter = filterType
        }
    }
}

extension MainpageVC:ProductTableViewCellDelegate{
    func addProduct(product: Product) {
        let addFoodRequest = AddFoodMapper.convertFrom(product: product)
        if let addFoodRequest = addFoodRequest {
            presenter?.addFoodToShoppingCart(shoppingCardItem: addFoodRequest)
        }
    } 
}

extension MainpageVC:HeaderTableViewCellDelegate{
    func buttonPressed() {
        performSegue(withIdentifier: variables.segueIdentifierToFoodList, sender: FoodListFilter.All)
    }
}

extension MainpageVC:CategoryWrapperTableViewCellDelegate{
    func cellClicked(category: Category) {
        guard let filter = category.filter else {
            return
        }
        performSegue(withIdentifier: variables.segueIdentifierToFoodList, sender: filter)
    }
}

