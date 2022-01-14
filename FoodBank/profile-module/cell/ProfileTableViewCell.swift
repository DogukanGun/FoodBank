//
//  ProfileTableViewCell.swift
//  FoodBank
//
//  Created by Dogukan Gundogan on 14.01.2022.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var settingLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    var setting:Setting?
    var delegate:ProfileTableViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        editButton.reshapeButton()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func refresh(setting:Setting){
        if let image = UIImage(systemName: setting.iconImageText){
            iconImage.image = image
            settingLabel.text = setting.settingLabel
            editButton.setTitle(setting.settingButtonName, for: .normal)
            self.setting = setting
        }
    }
    
    @IBAction func editButtonPressed(){
        guard let setting = setting else {
            return
        }
        delegate?.editButtonPressed(setting: setting)
    }
}

protocol ProfileTableViewCellDelegate{
    func editButtonPressed(setting:Setting)
}

