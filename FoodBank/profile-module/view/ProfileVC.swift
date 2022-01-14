//
//  ProfileVC.swift
//  FoodBank
//
//  Created by Dogukan Gundogan on 14.01.2022.
//

import UIKit

struct ProfileVariable{
    let profileTableViewCellIdentifier = "ProfileTableViewCell"
    let profileTableViewCellNibName = "ProfileTableViewCell"

}

class ProfileVC: UIViewController {

    var variables = ProfileVariable()
    var presenter:ViewToPresenterProfileProtocol?
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var settingTableView: UITableView!
    var settings = [Setting]()
    override func viewDidLoad() {
        super.viewDidLoad()
        settingTableView.register(UINib(nibName: variables.profileTableViewCellNibName, bundle: nil), forCellReuseIdentifier: variables.profileTableViewCellIdentifier)
        settingTableView.delegate = self
        settingTableView.dataSource = self
        ProfileRouter.createModule(ref: self)
        let name = userDefaults.string(forKey: Constants.userDefaultsUsername)
        profileName.text = name
    }
    

    override func viewWillAppear(_ animated: Bool) {
        presenter?.getData()
    }

}

extension ProfileVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: variables.profileTableViewCellIdentifier, for: indexPath) as? ProfileTableViewCell else{
            return UITableViewCell()
        }
        let setting = settings[indexPath.row]
        cell.delegate = self
        cell.setting = setting
        changeImage(setting:setting)
        cell.selectionStyle = .none
        cell.refresh(setting: setting)
        return cell
    }
    
    private func changeImage(setting:Setting){
        if setting.iconImageText == "person.fill"{
            if setting.settingLabel.lowercased() == Gender.Male.rawValue.lowercased(){
                profileImage.image = UIImage(named:"avatar2")
            }else if setting.settingLabel.lowercased() == Gender.Female.rawValue.lowercased(){
                profileImage.image = UIImage(named:"avatar1")
            }else{
                profileImage.image = UIImage(named:"avatar1")
            }
        }
        
    }
}

extension ProfileVC:ProfileTableViewCellDelegate{
    func editButtonPressed(setting: Setting) {
        if setting.getInputType() == .TextField{
            textFieldPopup(setting: setting)
        }else if setting.getInputType() == .SwitchButton{
            switchPopUp(setting: setting)
        }
    }
    
    private func switchPopUp(setting:Setting){
        if setting.settingLabel.lowercased() == Gender.Male.rawValue.lowercased(){
            setting.settingLabel = Gender.Female.rawValue
            changeImage(setting:setting)
        }else if setting.settingLabel.lowercased() == Gender.Female.rawValue.lowercased(){
            setting.settingLabel = Gender.Male.rawValue
            changeImage(setting:setting)
        }else{
            setting.settingLabel = Gender.Female.rawValue
            changeImage(setting:setting)
        }
        presenter?.saveValue(setting: setting)
    }
    
    private func textFieldPopup(setting:Setting){
        userInputDialog(userInputType: .Setting, value: setting){
            returnedValue in
            if setting.getTextFieldType() == .emailAddress {
                if !returnedValue.contains("@"){
                    return
                }
            }else if setting.getTextFieldType() == .dateTime{
                if returnedValue.range(of: "^[^0-9.-/]*$", options: .regularExpression) != nil{
                    return
                }
            }
            let newSetting = Setting(settingId: setting.settingId, iconImageText: setting.iconImageText, settingLabel: returnedValue,settingType: setting.settingType,settingButtonName: setting.settingButtonName)
            self.presenter?.saveValue(setting: newSetting)
        }
    }
}

extension ProfileVC:PresenterToViewProfileProtocol{
    func sendData(settings: [Setting]) {
        self.settings = settings
        DispatchQueue.main.async {
            self.settingTableView.reloadData()
        }
    }
}
