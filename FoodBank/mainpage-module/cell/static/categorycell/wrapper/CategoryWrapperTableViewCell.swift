//
//  CategoryWrapperTableViewCell.swift
//  FoodBank
//
//  Created by Dogukan Gundogan on 1/10/22.
//

import UIKit

struct CategoryWrapperTableViewCellVariable{
    let cellIdentifier = "CategoryCollectionViewCell"
    let cellNibName = "CategoryCollectionViewCell"
    let itemSpace = CGFloat(10)
    var indexPath:IndexPath? = nil
    let itemPerRow = CGFloat(3)
}

class CategoryWrapperTableViewCell: UITableViewCell {

    var delegate:CategoryWrapperTableViewCellDelegate?
    var variables = CategoryWrapperTableViewCellVariable()
    var categoryList = [Category(categoryName: "Dessert",filter: .Dessert),Category(categoryName: "Burger",filter: .Food),Category(categoryName: "Drink",filter: .Drink)]
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        categoryCollectionView.register(UINib(nibName: variables.cellNibName, bundle: nil), forCellWithReuseIdentifier: variables.cellIdentifier)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension CategoryWrapperTableViewCell:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: variables.cellIdentifier, for: indexPath) as? CategoryCollectionViewCell else{
            return UICollectionViewCell()
        }
        let category = categoryList[indexPath.row]
        cell.refresh(category: category)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = categoryList[indexPath.row]
        delegate?.cellClicked(category: category)
    }
      
    private func desingCollectionView(){
        let design = UICollectionViewFlowLayout()
        design.minimumInteritemSpacing = variables.itemSpace
        let width = self.categoryCollectionView.frame.size.width
        let cellWidth = (width - (variables.itemSpace*CGFloat(2)))/variables.itemPerRow
        design.itemSize = CGSize(width: cellWidth, height: self.categoryCollectionView.frame.size.height)
        categoryCollectionView.collectionViewLayout = design
    }
}
  
protocol CategoryWrapperTableViewCellDelegate{
    func cellClicked(category:Category)
}


