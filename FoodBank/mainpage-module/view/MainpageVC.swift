//
//  MainpageVC.swift
//  FoodBank
//
//  Created by Dogukan Gundogan on 1/9/22.
//

import Foundation
import UIKit

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
    let sectionNumber = 3
    let segueIdentifierToFoodDetail = "FoodDetailVC"
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
    }
    
    @IBAction func logoutButtonPressed(_ sender: Any) {
        userDefaults.removeObject(forKey: Constants.userDefaultsUsername)
        changeRootView()
    }
    private func delegateTableView(){
        mainpageTableView.delegate = self
        mainpageTableView.dataSource = self
        mainpageTableView.register(UINib(nibName: variables.categoryWrapperCell, bundle: nil), forCellReuseIdentifier: variables.categoryWrapperNibName)
        mainpageTableView.register(UINib(nibName: variables.headerNibName, bundle: nil), forCellReuseIdentifier: variables.headerCell)
        mainpageTableView.register(UINib(nibName: variables.productNibName, bundle: nil), forCellReuseIdentifier: variables.productCell)
    }
    private func changeRootView(){
        let storyboard = UIStoryboard(name: Constants.mainStoryboardName, bundle: nil)
        let mainTabBarController = storyboard.instantiateViewController(identifier: Constants.loginPageName)
           
          (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
    }
}

extension MainpageVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return nil
        }else if section == 1{
            return "Categories"
        }else{
            return "Populars"
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let view = view as? UITableViewHeaderFooterView {
            let font = UIFont.boldSystemFont(ofSize: CGFloat(20))
            view.textLabel?.font = font
            view.textLabel?.textColor = UIColor.black
            view.textLabel?.numberOfLines = 0
        }
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
            cell.selectionStyle = .none
            return cell
            
        }else if indexPath.section == 1{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: variables.categoryWrapperCell, for: indexPath) as? CategoryWrapperTableViewCell else{
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            return cell
            
        }else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: variables.productCell, for: indexPath) as? ProductTableViewCell else{
                return UITableViewCell()
            }
            let product = products[indexPath.row]
            cell.refresh(product: product)
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
        }
    }
}
