//
//  HeaderTableViewCell.swift
//  FoodBank
//
//  Created by Dogukan Gundogan on 1/10/22.
//

import UIKit
import Lottie

struct HeaderTableViewCellVariable{
    let wrapperCornerRadious = CGFloat(20)
}

class HeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var animationWrapper: UIView!
    var animationView:AnimationView?
    let variables = HeaderTableViewCellVariable()
    @IBOutlet weak var orderNowButton: UIButton!
    var delegate:HeaderTableViewCellDelegate?
    @IBOutlet weak var wrapper: UIView!
    @IBOutlet weak var headerTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        changeColorOfText()
        wrapper.layer.cornerRadius = variables.wrapperCornerRadious
        animationWrapper.frame.size = CGSize(width: animationWrapper.frame.width/1.2, height: animationWrapper.frame.height)
        animationView = .init(name:"delivery-service")
        animationView?.frame = animationWrapper.bounds
        animationView?.backgroundColor = UIColor(named: "SecondaryColarLight")
        animationView?.loopMode = .autoReverse
        animationWrapper.addSubview(animationView!)
        animationView?.play()
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
