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
    let productCellHeight = CGFloat(156)
    let staticCellNumber = 2
}

class MainpageVC:UIViewController{

    var variables = MainpageVariable()
    var products = [Product]()
    @IBOutlet weak var mainpageTableView: UITableView!
    
    override func viewDidLoad() {
        mainpageTableView.delegate = self
        mainpageTableView.dataSource = self
        mainpageTableView.register(UINib(nibName: variables.categoryWrapperCell, bundle: nil), forCellReuseIdentifier: variables.categoryWrapperNibName)
        mainpageTableView.register(UINib(nibName: variables.headerNibName, bundle: nil), forCellReuseIdentifier: variables.headerCell)
        mainpageTableView.register(UINib(nibName: variables.productNibName, bundle: nil), forCellReuseIdentifier: variables.productCell)
    }
    @IBAction func logoutButtonPressed(_ sender: Any) {
        userDefaults.removeObject(forKey: Constants.userDefaultsUsername)
        
        changeRootView()
    }
    private func changeRootView(){
        let storyboard = UIStoryboard(name: Constants.mainStoryboardName, bundle: nil)
        let mainTabBarController = storyboard.instantiateViewController(identifier: Constants.loginPageName)
           
          (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
    }
}

extension MainpageVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count+variables.staticCellNumber
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: variables.headerCell, for: indexPath) as? HeaderTableViewCell else{
                return UITableViewCell()
            }
            return cell
            
        }else if indexPath.row == 1{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: variables.categoryWrapperCell, for: indexPath) as? CategoryWrapperTableViewCell else{
                return UITableViewCell()
            }
            return cell
            
        }else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: variables.productCell, for: indexPath) as? ProductTableViewCell else{
                return UITableViewCell()
            }
            let product = products[indexPath.row]
            cell.refresh(product: product)
            return cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return variables.headerCellHeight
        }else if indexPath.row == 1{
            return variables.categoryCellHeight

        }else{
            return CGFloat(156)

        }
    }
    
    
    
}


