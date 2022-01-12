//
//  FoodListVC.swift
//  FoodBank
//
//  Created by Dogukan Gundogan on 1/11/22.
//

import Foundation
import UIKit

struct FoodListVariable{
    let cellIdentifier = "FoodListCollectionViewCell"
    let cellNibName = "FoodListCollectionViewCell"
    let cellRatio = CGFloat(20)
    let itemPerRow = 2
    let inset = CGFloat(10)
    let spacing = CGFloat(5)
    let segueToFoodDetailVC = "FoodDetailVC"
}

class FoodListVC:UIViewController{
    @IBOutlet weak var searchBar: UISearchBar!
    var foodListFilter:FoodListFilter?
    var presenter:ViewToPresenterFoodListProtocol?
    let variables = FoodListVariable()
    var foodList = [Product]()
    var notSearchedFoodList = [Product]()
    @IBOutlet weak var foodListCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        delegateCollectionView()
        searchBar.delegate = self
        FoodListRouter.createModule(ref: self)
        
    }
    
    private func delegateCollectionView(){
        foodListCollectionView.register(UINib(nibName: variables.cellNibName, bundle: nil), forCellWithReuseIdentifier: variables.cellIdentifier)
        foodListCollectionView.delegate = self
        foodListCollectionView.dataSource = self
        
        let design = UICollectionViewFlowLayout()
        design.sectionInset = UIEdgeInsets(top: variables.inset, left: variables.inset, bottom: variables.inset, right: variables.inset)
        design.minimumInteritemSpacing = variables.spacing
        design.minimumLineSpacing = variables.spacing
        
        let space = variables.inset*2 + CGFloat((variables.itemPerRow-1))*variables.spacing
        let genislik = view.frame.size.width
        design.itemSize = CGSize(width: CGFloat((Int(genislik)-Int(space))/variables.itemPerRow), height: CGFloat((Int(genislik)-Int(space))/variables.itemPerRow))
        
        foodListCollectionView.collectionViewLayout = design
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter?.getData()
    }
    
}


extension FoodListVC:UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return foodList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: variables.cellIdentifier, for: indexPath) as? FoodListCollectionViewCell else{
            return UICollectionViewCell()
        }
        let product = foodList[indexPath.row]
        cell.refresh(product: product)
        cell.layer.cornerRadius = variables.cellRatio
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = foodList[indexPath.row]
        performSegue(withIdentifier: variables.segueToFoodDetailVC, sender: product)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == variables.segueToFoodDetailVC{
            let vc = segue.destination as! FoodDetailVC
            let product = sender as! Product
            vc.food = product
        }
    }
    
}

extension FoodListVC:PresenterToViewFoodListProtocol{
    func sendData(products: [Product]) {
        self.foodList = filterList(products: products)
        self.notSearchedFoodList = foodList
        DispatchQueue.main.async {
            self.foodListCollectionView.reloadData()
        }
    }
    
    private func filterList(products: [Product])->[Product]{
        if let foodListFilter = foodListFilter{
            var newProductList = [Product]()
            for product in products {
                if product.yemekAdi.filterFoods(filterType: foodListFilter){
                    newProductList.append(product)
                }
            }
            return newProductList
        }
        return products
    }
}

extension FoodListVC:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        foodList = [Product]()
        if searchText == ""{
            for product in notSearchedFoodList{
                foodList.append(product)
            }
        }else{
            filterListBySearchBar(foodList:&foodList,text: searchText)
        }
        foodListCollectionView.reloadData()
    }
    
    private func filterListBySearchBar(foodList:inout [Product],text:String){
        for product in notSearchedFoodList{
            if(product.yemekAdi.lowercased().contains(text.lowercased())){
                foodList.append(product)
            }
        }
    }
}
