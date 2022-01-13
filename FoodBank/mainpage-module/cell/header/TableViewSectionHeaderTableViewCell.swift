//
//  TableViewSectionHeaderTableViewCell.swift
//  FoodBank
//
//  Created by Dogukan Gundogan on 13.01.2022.
//

import UIKit

class TableViewSectionHeaderTableViewCell: UITableViewHeaderFooterView {

    @IBOutlet weak var cellLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
 
    
    func refresh(title:String){
        cellLabel.text = title
    }
    
}
