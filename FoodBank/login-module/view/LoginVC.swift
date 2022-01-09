//
//  LoginVC.swift
//  FoodBank
//
//  Created by Dogukan Gundogan on 1/9/22.
//

import Foundation
import UIKit

struct LoginVariable{
    let faceIdButtonAngle = 1.1
    let registerButtonAngle = 1.55
    let callUsButtonAngle = 2.1
    let registerButtonText = "Register Now"
    let registerTitleText = "Register"
    let loginButtonText = "Login Now"
    let loginTitleText = "Login"
    let numberSet = CharacterSet(["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"])

}

class LoginVC:UIViewController{
    
    var loginVariable = LoginVariable()
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var loginTitle: UILabel!
    @IBOutlet weak var callUsButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var faceIdButton: UIButton!
    @IBOutlet weak var loginUsername: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginWrapper: UIView!
    @IBOutlet var mainWrapper: UIView!
    
    override func viewDidLoad() {
        editBackground()
        editButton()
    }
    
    @IBAction func startApplication(_ sender: Any) {
        
        if let text = loginUsername.text ,text == "" || text.rangeOfCharacter(from: loginVariable.numberSet) != nil {
            errorDialog(title: "Wrong Name", errorMessage: "Please control the username", okayButtonText: "Okay")
        }
        mainWrapper.addSubview(loadingIndicator)
        mainWrapper.bringSubviewToFront(loadingIndicator)
        loadingIndicator.startAnimating()
        let seconds = 3.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            userDefaults.set(self.loginUsername.text, forKey: Constants.userDefaultsUsername)
            self.changeRootView()
        }
        
    }
    
    @IBAction func callUsButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func registerButtonPressed(_ sender: Any) {            loginButton.setTitle(loginVariable.registerButtonText, for: .normal)
        loginTitle.text = loginVariable.registerTitleText
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(20), weight: .semibold)
    }
    
    @IBAction func faceIdButtonPressed(_ sender: Any) {
        loginButton.setTitle(loginVariable.loginButtonText, for: .normal)
        loginTitle.text = loginVariable.loginTitleText
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(20), weight: .semibold)
    }
}

extension LoginVC{
    private func editButton(){
        navigationItem.hidesBackButton = true
        loginButton.reshapeButton()
        registerButton.turnButton(ratio: loginVariable.registerButtonAngle)
        callUsButton.turnButton(ratio: loginVariable.callUsButtonAngle)
        faceIdButton.turnButton(ratio: loginVariable.faceIdButtonAngle)
        loginUsername.cornerShape()
        loginWrapper.makeCircular(width:UIScreen.main.bounds.width)
    }
    private func editBackground(){
        if let image = UIImage(named: "BackgroundImage"){
            let imageView = UIImageView(frame: CGRect(x: 0, y: -20, width: mainWrapper.bounds.width, height: mainWrapper.bounds.height+40))
            imageView.contentMode = .scaleAspectFit
            imageView.image = image
            mainWrapper.addSubview(imageView)
            self.mainWrapper.sendSubviewToBack(imageView)
        }
        loadingIndicator.stopAnimating()
    }
    
    private func changeRootView(){
        let storyboard = UIStoryboard(name: Constants.mainStoryboardName, bundle: nil)
        let mainTabBarController = storyboard.instantiateViewController(identifier: Constants.mainpageName)
           
          (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
    }
    
}
