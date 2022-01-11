//
//  HeaderTableViewCell.swift
//  FoodBank
//
//  Created by Dogukan Gundogan on 1/10/22.
//

import UIKit

struct HeaderTableViewCellVariable{
    let wrapperCornerRadious = CGFloat(20)
}

class HeaderTableViewCell: UITableViewCell {

    let variables = HeaderTableViewCellVariable()
    @IBOutlet weak var orderNowButton: UIButton!
    var delegate:HeaderTableViewCellDelegate?
    @IBOutlet weak var wrapper: UIView!
    @IBOutlet weak var headerTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        changeColorOfText()
        wrapper.layer.cornerRadius = variables.wrapperCornerRadious
        orderNowButton.reshapeButton()
    }

    private func changeColorOfText(){
        let mutableString = NSMutableAttributedString(string: headerTitle.text!, attributes:nil)
        var keyWord = "Food"
        let langStr = Locale.current.languageCode
        if langStr != "en"{
            keyWord = "Yemek"
        }
        let startIndex = headerTitle.text?.index(of: keyWord)
        if let startIndex = startIndex?.encodedOffset  {
            mutableString.addAttributes([NSAttributedString.Key.foregroundColor : UIColor(named: "PrimaryColor")], range: NSRange(location: startIndex, length: keyWord.count))
            headerTitle.attributedText = mutableString
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func orderNowButtonPressed(_ sender: Any) {
        delegate?.buttonPressed()
    }
}

protocol HeaderTableViewCellDelegate{
    func buttonPressed()
}
