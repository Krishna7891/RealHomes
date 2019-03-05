//
//  SettingVC.swift
//  MyMedPack
//
//  Created by mac-pc2 on 05/10/18.
//  Copyright © 2018 Aadil keshwani. All rights reserved.
//

import UIKit
import ObjectMapper
import LocalAuthentication


class SettingVC: UIViewController {

    @IBOutlet weak var btnInitial: UIButton!
    @IBOutlet weak var appIcon: UIView!
    
    @IBOutlet weak var vwTouchID: UIControl!
    @IBOutlet weak var vwChangePass: UIControl!
    @IBOutlet weak var sw_touchId: UISwitch!

    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblVersion: UILabel!
    var sharedManager : Globals = Globals.sharedInstance
    
    @IBOutlet weak var vwChat: UIControl!
    @IBOutlet weak var imgChatIcon: UIImageView!
    @IBOutlet weak var lblBadgeCount: UILabel!
    
    @IBOutlet weak var lblPasscode: UILabel!
    @IBOutlet weak var reportsHEIGHTconstraint: NSLayoutConstraint!
    @IBOutlet weak var passcodeHEIGHTconstraint: NSLayoutConstraint!
    
    @IBOutlet weak var vwPasscode: UIControl!
    @IBOutlet weak var vwReports: UIControl!
    
    //MARK:- View didload
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(badgeCountChatSetting), name: Notification.Name("badgeCountChatSetting"), object: nil)

    }
    override func viewWillAppear(_ animated: Bool)
    {
        dictInfo = NSDictionary()
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(setupLayoutSettings), name: Notification.Name("setupLayoutSettings"), object: nil)
        
        self.tabBarController?.tabBar.isHidden = false
        setupLayoutSettings()
        
    }
    @objc func badgeCountChatSetting(){
        lblBadgeCount.text = String(_badgeCount)
        if _badgeCount == 0{
            lblBadgeCount.isHidden = true
        } else {
            lblBadgeCount.isHidden = false
        }
    }
    @objc func setupLayoutSettings()
    {
        
        deviceSupportsTouchId(success: {
            print("device not supported with touchID.......................................")
        }, failure: {_ in })
        
        btnInitial.setBorderCorner(borderWidth: 0, borderColor: Constants.THEME.BUTTON_BORDER_COLOR, radius: btnInitial.frame.size.height / 2)
        appIcon.setBorderCorner(borderWidth: 0, borderColor: Constants.THEME.BUTTON_BORDER_COLOR, radius: appIcon.frame.size.height / 4)
        sw_touchId.addTarget(self, action: #selector(SettingVC.switchChanged(_:)), for: UIControl.Event.valueChanged)
        
        vwChat.setBorderCorner(borderWidth: 0, borderColor: UIColor.white, radius: vwChat.frame.size.height / 2)
        vwChat.dropShadow()
        imgChatIcon.setImageColorByRendering(color: .white)
        
        lblBadgeCount.setBorderCorner(borderWidth: 0, borderColor: UIColor.white, radius: lblBadgeCount.frame.size.height / 2)
        lblBadgeCount.clipsToBounds = true
        badgeCountChatSetting()
        
        let fname = sharedManager.currentUser.userInfo?.firstName
        let lname = sharedManager.currentUser.userInfo?.lastName
        let ff = fname!.prefix(1)
        let ll = lname!.prefix(1)
        btnInitial.setTitle("\(ff.uppercased())\(ll.uppercased())", for: .normal)
        
        lblName.text = "\(fname!) \(lname!)"
        lblEmail.text = sharedManager.currentUser.userInfo?.email
        lblVersion.text = "Version : \(_AppVersion)"
        
        if sharedManager.currentUser.userInfo?.isTouchIdEnable == "0"{
            sw_touchId.setOn(false, animated: true)
        }else{
            sw_touchId.setOn(true, animated: true)
        }
        
        if sharedManager.currentUser.userInfo?.password != ""{
            vwChangePass.isHidden = false
        }else{
            vwChangePass.isHidden = true
        }
        
        //1 means Change Passcode & 2 means Generate Passcode
        if sharedManager.currentUser.userInfo?.passcode == "" || sharedManager.currentUser.userInfo?.passcode == nil{
            lblPasscode.text = "   Generate Passcode"
            UserDefaults.standard.set(2 as Any, forKey: Constants.KEYS.CURRENT_PASSCODE_STATE)
        } else {
            lblPasscode.text = "   Change Passcode"
            UserDefaults.standard.set(1 as Any, forKey: Constants.KEYS.CURRENT_PASSCODE_STATE)
        }
        
        if sharedManager.currentUser.userInfo?.usertype == "2"{
            reportsHEIGHTconstraint.constant = 60
            passcodeHEIGHTconstraint.constant = 60
            
            vwPasscode.isHidden = false
            vwReports.isHidden = false
            
        } else{
            reportsHEIGHTconstraint.constant = 0
            passcodeHEIGHTconstraint.constant = 0
            
            vwPasscode.isHidden = true
            vwReports.isHidden = true
        }
        
    }
    @IBAction func chat_tapped(_ sender: UIButton)
    {
        if sharedManager.FIR_USER_KEY.count != 0{
            self.navigateVC(strViewControllerName: "MessageVC", isAnimated: true)
        }
    }
    @IBAction func profile_tapped(_ sender: UIControl)
    {
        if sharedManager.currentUser.userInfo?.usertype == "1"{
            self.navigateVC(strViewControllerName: Constants.StoryboardID.PATIENTEDITPRODILE_VC, isAnimated: true)
        } else if sharedManager.currentUser.userInfo?.usertype == "3" || sharedManager.currentUser.userInfo?.usertype == "2" {
            self.navigateVC(strViewControllerName: Constants.StoryboardID.EDITPROFILE_VC, isAnimated: true)
        } else {
        }
        
    }
    @IBAction func changePassword_tapped(_ sender: UIControl)
    {
        self.navigateVC(strViewControllerName: Constants.StoryboardID.CHANGEPASS_VC, isAnimated: true)
    }
    @IBAction func passcode_tapped(_ sender: UIControl)
    {
        UserDefaults.standard.removeObject(forKey: Constants.KEYS.CURRENT_PASSCODE)
        UserDefaults.standard.removeObject(forKey: Constants.KEYS.NEW_PASSCODE)
        UserDefaults.standard.removeObject(forKey: Constants.KEYS.CONFIRM_PASSCODE)
        UserDefaults.standard.synchronize()
        
        strEnterPasscode = ""
        strNewPasscode = ""
        strConfirmPasscode = ""
        
        self.navigateVC(strViewControllerName: Constants.StoryboardID.PASSCODE_VC, isAnimated: true)
    }
    @IBAction func reports_tapped(_ sender: UIControl) {
        
//        UserDefaults.standard.set(2 as Any, forKey: Constants.KEYS.CURRENT_PASSCODE_STATE)
        strComeByReports = "yes"
        self.navigateVC(strViewControllerName: Constants.StoryboardID.PASSCODE_VC, isAnimated: true)
    }
    @IBAction func aboutUs_tapped(_ sender: UIControl)
    {
        self.navigateVC(strViewControllerName: Constants.StoryboardID.ABOUTUS_VC, isAnimated: true)
    }
    @IBAction func contactUs_tapped(_ sender: UIControl)
    {
        self.navigateVC(strViewControllerName: Constants.StoryboardID.CONTECTUS_VC, isAnimated: true)
    }
    @IBAction func rateTheApp_tapped(_ sender: UIControl)
    {
        openAppStore()
    }
    @IBAction func termsConditions_tapped(_ sender: UIControl)
    {
        self.navigateVC(strViewControllerName: Constants.StoryboardID.TC_VC, isAnimated: true)
    }
    @IBAction func privacyPlocy_tapped(_ sender: UIControl)
    {
        self.navigateVC(strViewControllerName: Constants.StoryboardID.PRIVACYPOLICY_VC, isAnimated: true)
    }
    @IBAction func deactivateProfile_tapped(_ sender: UIControl)
    {
        let vc : DeactivatePopupVC = self.storyboard?.instantiateViewController(withIdentifier: "DeactivatePopupVC") as! DeactivatePopupVC
        self.add_child(vc)
    }
    @IBAction func signout_tapped(_ sender: UIControl){
        if self.currentReachabilityStatus != .notReachable {
            signOutAPicall()
        }else{
//            self.view.makeToast(Constants.ALERT_MESSAGE.ERROR_INTERNET)
            AppDelegate.sharedInstance().NoInternectConnection()
        }
    }
    func signOutAPicall(){
        
        var param : [String : Any] = [:]
        param["id"] = sharedManager.currentUser.userInfo?.id
        
        print(param)
        print(Constants.URLS.SIGNOUT)
        showLoader()
        AFWrapper.registerPOSTURL(Constants.URLS.SIGNOUT, params: param as [String : Any], headers: nil,  success: {
            (JSONResponse) -> Void in
            self.hideLoader()
            let LoginResponse : Login = Mapper<Login>().map(JSONObject: JSONResponse.rawValue)!
            if LoginResponse.status == true{
                self.view.makeToast(LoginResponse.message!)
                
                DispatchQueue.main.async {
                UserDefaults.standard.removeObject(forKey: Constants.KEYS.kUSER_ID)
                UserDefaults.standard.removeObject(forKey: Constants.KEYS.kUSER_TYPE)
                UserDefaults.standard.removeObject(forKey: Constants.KEYS.kUSER_LOGIN)
                UserDefaults.standard.removeObject(forKey: Constants.KEYS.kTOUCU_ID)
                UserDefaults.standard.removeObject(forKey: Constants.KEYS.kAUTHORIZATION_TOKEN)
                UserDefaults.standard.removeObject(forKey: Constants.KEYS.kDOCTORIDCP)
                UserDefaults.standard.removeObject(forKey: Constants.KEYS.kPATIENT_RESPONSE)
                UserDefaults.standard.removeObject(forKey: Constants.KEYS.kWEBSTERPACLIST_RESPONSE)
                UserDefaults.standard.removeObject(forKey: Constants.KEYS.kNOTIFICATION_RESPONSE)
                //UserDefaults.standard.removeObject(forKey: Constants.KEYS.kLOGIN_RESPONSE)
                
                UserDefaults.standard.set(nil, forKey: Constants.KEYS.kUSER_ID)
                UserDefaults.standard.set(nil, forKey: Constants.KEYS.kUSER_TYPE)
                UserDefaults.standard.set(nil, forKey: Constants.KEYS.kUSER_LOGIN)
                UserDefaults.standard.set(nil, forKey: Constants.KEYS.kTOUCU_ID)
                UserDefaults.standard.set(nil, forKey: Constants.KEYS.kAUTHORIZATION_TOKEN)
                UserDefaults.standard.set(nil, forKey: Constants.KEYS.kDOCTORIDCP)
                UserDefaults.standard.set(nil, forKey: Constants.KEYS.kPATIENT_RESPONSE)
                UserDefaults.standard.set(nil, forKey: Constants.KEYS.kWEBSTERPACLIST_RESPONSE)
                UserDefaults.standard.set(nil, forKey: Constants.KEYS.kNOTIFICATION_RESPONSE)
                //UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
                    self.sharedManager.isLoggedOut = true;
                UserDefaults.standard.synchronize()
                    
                _doctorId = ""
                _doctorIdADDPATIENT = ""
                _patientId = ""
                _patientName = ""
                    
                if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                    appDelegate.pushToSignVC()
                }
                }
                
                
            }else{
                self.view.makeToast(LoginResponse.message!)
            }
        }) {
            (error) -> Void in
            self.hideLoader()
            self.view.makeToast(error.localizedDescription)
        }
        
    }
    @IBAction func switchToucuId_action(_ sender: UISwitch)
    {
        var _id : String = ""
        if currentReachabilityStatus != .notReachable {
            if sw_touchId.isOn{
                _id = "0"
                sender.setOn(false, animated: false)
            }else{
                _id = "1"
                sender.setOn(true, animated: false)
            }
        } else {
            self.view.makeToast(Constants.ALERT_MESSAGE.ERROR_INTERNET)
        }
    }
    @objc func switchChanged(_ mySwitch: UISwitch)
    {
        var _id : String = ""
        if currentReachabilityStatus != .notReachable {
        if sw_touchId.isOn {
            // handle on
            _id = "1"
        } else {
            // handle off
            _id = "0"
        }
        touchIdAPIcall(touchId: _id)
        } else {
            self.view.makeToast(Constants.ALERT_MESSAGE.ERROR_INTERNET)
        }
    }
    
   
    
    //MARK:- API functions
    func touchIdAPIcall(touchId : String)
    {
        var param : [String : Any] = [:]
        param["id"] = sharedManager.currentUser.userInfo?.id
        param["setEnable"] = touchId
        param["deviceToken"] = UserDefaults.standard.object(forKey: Constants.KEYS.kDEVICE_ID) as! String
        
        print(param)
        print(Constants.URLS.SETTOUCHID)
        showLoader()
        AFWrapper.registerPOSTURL(Constants.URLS.SETTOUCHID, params: param as [String : Any], headers: nil,  success: {
            (JSONResponse) -> Void in
            self.hideLoader()
            let LoginResponse : Login = Mapper<Login>().map(JSONObject: JSONResponse.rawValue)!
            self.sharedManager.currentUser = Mapper<Login>().map(JSONObject: JSONResponse.rawValue)!
            // save in udser default 
            print(LoginResponse)
            if LoginResponse.status == true{
                UserDefaults.standard.set(LoginResponse.userInfo?.id, forKey: Constants.KEYS.kUSER_ID)
                UserDefaults.standard.set(LoginResponse.userInfo?.deviceToken, forKey: Constants.KEYS.kAUTHORIZATION_TOKEN)
                UserDefaults.standard.set(LoginResponse.toJSON(), forKey: Constants.KEYS.kLOGIN_RESPONSE)
                UserDefaults.standard.synchronize()
                
                print("touchid API call success...")
                self.view.makeToast(LoginResponse.message!)
            }else{
                print("touchid API call getting errorrrrr...")
                self.view.makeToast(LoginResponse.message!)
            }
        }) {
            (error) -> Void in
            self.hideLoader()
            self.view.makeToast(error.localizedDescription)
        }
    }

    
    //MARK:- UDF
    fileprivate func openAppStore() {
        
//        let appIdentifierPrefix = Bundle.main.infoDictionary!["AppIdentifierPrefix"] as! String
//        print(appIdentifierPrefix)
        
        let appId = "1442791353"
        let url_string = "itms-apps://itunes.apple.com/app/id\(appId)"
        if let url = URL(string: url_string) {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    fileprivate func deviceSupportsTouchId(success: @escaping () -> (), failure: @escaping (NSError) -> ()) {
        let context = LAContext()
        var authError: NSError?
        let touchIdSetOnDevice = context.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &authError)
        
        if touchIdSetOnDevice {
            DispatchQueue.main.async {
                success()
                print("device supported with touchID.......................................")
                self.vwTouchID.isHidden = false
            }
        }
        else {
            DispatchQueue.main.async {
                failure(authError!)
                print("device not supported with touchID.......................................")
                self.vwTouchID.isHidden = true
            }
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return .lightContent
    }

    func deactivatedPopUp(){
        let appDel = UIApplication.shared.delegate as! AppDelegate
        let nav : UINavigationController = appDel.window?.rootViewController as! UINavigationController
        var deactivated : DeactivatedPopupVC = DeactivatedPopupVC()
        for vc in nav.viewControllers {
            if vc.isKind(of: DeactivatedPopupVC.classForCoder()) {
                deactivated = vc as! DeactivatedPopupVC;
            }
        }
        add_child(deactivated)
    }
}
