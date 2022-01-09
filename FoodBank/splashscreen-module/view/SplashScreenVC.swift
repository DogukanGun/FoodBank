//
//  SplashScreenVC.swift
//  FoodBank
//
//  Created by Dogukan Gundogan on 1/9/22.
//

import Foundation
import UIKit


struct SplashScreenVariable{
    let bottomSheetRatio = CGFloat(80)
    let bottomSheetButtonCornerRadious = CGFloat(12)
}
class SplashScreenVC:UIViewController{
    @IBOutlet weak var titleOfBottomSheet: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var image: UIImageView!
    let splashScreenVariable = SplashScreenVariable()
    @IBOutlet weak var bottomSheet: UIView!
    
    override func viewDidLoad() {
        editBottomSheet()
    }
    
    private func editBottomSheet(){
        bottomSheet.drawRoundedEdge(ratio: splashScreenVariable.bottomSheetRatio)
        editBottomSheetTitle()
        editBottomSheetButton()
    }
    
    private func editBottomSheetButton(){
        button.layer.cornerRadius = splashScreenVariable.bottomSheetButtonCornerRadious
    }

    private func editBottomSheetTitle(){
        let mutableString = NSMutableAttributedString(string: titleOfBottomSheet.text!, attributes:nil)
        var keyWord = "Food"
        let langStr = Locale.current.languageCode
        if langStr != "en"{
            keyWord = "Yemek"
        }
        let startIndex = titleOfBottomSheet.text?.index(of: keyWord)
        if let startIndex = startIndex?.encodedOffset  {
            mutableString.addAttributes([NSAttributedString.Key.foregroundColor : UIColor(named: "PrimaryColor")], range: NSRange(location: startIndex, length: keyWord.count))
            titleOfBottomSheet.attributedText = mutableString
        }
    }
}
