//
//  CategoryCollectionViewCell.swift
//  FoodBank
//
//  Created by Dogukan Gundogan on 1/10/22.
//

import UIKit

struct CategoryCollectionViewCellVariable{
    let wrapperRadious = CGFloat(20)
}


class CategoryCollectionViewCell: UICollectionViewCell {

    let variables = CategoryCollectionViewCellVariable()
    @IBOutlet weak var wrapper: UIView!
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var cellImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        wrapper.layer.cornerRadius = variables.wrapperRadious
    }
    
    func refresh(category:Category){
        if let categoryName = category.categoryName,let image = UIImage(named:categoryName){
            cellImage.image = image
            cellLabel.text = categoryName
        }
    }

}
