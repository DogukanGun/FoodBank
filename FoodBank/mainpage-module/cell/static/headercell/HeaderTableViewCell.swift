//
//  HeaderTableViewCell.swift
//  FoodBank
//
//  Created by Dogukan Gundogan on 1/10/22.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var headerTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        changeColorOfText()
    }

    private func changeColorOfText(){
        let mutableString = NSMutableAttributedString(string: headerTitle.text!, attributes:nil)
        var keyWord = "Delivery"
        let langStr = Locale.current.languageCode
        if langStr != "en"{
            keyWord = "Teslim"
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
    }
}
