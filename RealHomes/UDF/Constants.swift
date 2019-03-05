//
//  Constants.swift
//  BlueCoupon
//
//  Created by Impero IT on 03/06/16.
//  Copyright © 2016 Impero IT. All rights reserved.
//

import UIKit

struct Constants {

static let buildName = "Goo2GoCustomer"
static let MAPAPIKEY = "AIzaSyD6VRK0lLh53t-CTX-B04c0_PhpfnhorXM"
    
struct magazine {
        static let magazineID = 1
        
}
struct ViewOnAppStoreLink {
    static let AppstoreLink = "https://itunes.apple.com/us/app/vegan-living-magazine/id642816633?ls=1&mt=8"
}
struct  FontName {
        static let FontRegular = "ProximaNova-Regular"
        static let FontBold = "ProximaNova-Bold"
        static let FontSemiBold = "ProximaNova-Semibold"
}
    
struct Default {
     static let ACCESS_TOKEN = UserDefaults.standard.value(forKey: "BearerToken") as! String!
     static let USERNAME = UserDefaults.standard.value(forKey: "UserName") as! String!
     static let USERTYPE = UserDefaults.standard.value(forKey: "UserType") as! String!
}
struct ScreenSize
{
     static let SCREEN_WIDTH = UIScreen.main.bounds.size.width
     static let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
     static let SCREEN_MAX_LENGTH = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
     static let SCREEN_MIN_LENGTH = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

struct DeviceType
{
     static let Is_IPhone_4_OR_Less =  UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
     static let Is_IPhone_5 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
     static let Is_IPhone_6 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
     static let Is_IPhone_6P = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
     static let Is_IPhone_X = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 812.0
     static let Is_IPad = UIDevice.current.userInterfaceIdiom == .pad
}

struct URLS
{
  //  static let BASE_URL = "http://ec2-54-201-65-63.us-west-2.compute.amazonaws.com/API/"
    static let BASE_URL = "http://admin2.maanko.com/API/"
    static let UserConnectByFacebook = BASE_URL + "WebService/UserConnectByFacebook" //login
    static let UserSignup = BASE_URL + "WebService/UserSignup" //UserSignup
    static let UserSignin = BASE_URL + "WebService/UserSignin" //UserSignin
    static let UserForgotPassword = BASE_URL + "WebService/UserForgotPassword" //login
    static let MasterApi = BASE_URL + "WebService/MagazineIssueList" //MasterApi
    static let UserNotificationList = BASE_URL + "WebService/UserNotificationList" //MasterApi
    static let UserNotificationSetting = BASE_URL + "WebService/UserNotificationSetting" //MasterApi
    static let UserInfo = BASE_URL + "WebService/UserInfo" //MasterApi
    static let UserSignout = BASE_URL + "WebService/UserSignout" //MasterApi
    static let PurchaseIssue = BASE_URL + "WebService/PurchaseIssue" //MasterApi
    static let SubscribeMagazineNew = BASE_URL + "WebService/SubscribeMagazineNew" //MasterApi
    static let UserProfileUpdate = BASE_URL + "WebService/UserProfileUpdate" //MasterApi
    static let MagazineSplashImage = BASE_URL + "WebService/MagazineSplashImage" //MasterApi
    static let FilterApi = BASE_URL + "WebService/MagazineIssueListbyFilter" //MasterApi
    static let UserChangePassword = BASE_URL + "WebService/UserChangePassword"
}
    
 
struct NavigationHeader {
    static let Login = "LOGIN"
    static let SignUp = "REGISTER"
    static let ForgotPassword = "FORGOT PASSWORD"
    static let FontName = "default"
    
}
    
struct DefaultMessages {
    static let POPUPTITLE = "Account"
    static let POPUPDESCREPTION = "Please add your profile in order to make any transaction."
    static let POPUPBUTTONTEXT = "PROCEED"

}
    
struct Errors {
    static let ERROR_INTERNTE = "No Internet available"
    static let ERROR_COMING_SOON = "Under Development"
    static let ERROR_TIMEOUT = "Server error. Please try again later"
    static let ERROR_NODATA = "No Data."
    static let ERROR_NAME = "Please enter your Name"
    static let ERROR_EMAIL = "Please enter your email address."
    static let ERROR_Company = "Please enter Company Name"
    static let ERROR_Tax = "Please enter Tax No"
    static let ERROR_VALIDEMAIL = "Please enter your valid email address."
    static let ERROR_Phone = "Please enter Phone Number"
    static let ERROR_VALIDPhone = "Please enter valid Phone Number"
    static let ERROR_PASSWORD = "Please enter password"
    static let ERROR_PASSWORDLENGTH = "password should be minimum 6 & maximum 12 character allowed"
    static let ERROR_CurrentPassword = "Please enter current password"
    static let ERROR_NewPassword = "Please enter new password"
    static let ERROR_CreatePassword =   "please create your password for the login access."
    static let ERROR_ConfirmPassword = "Please enter confirm password"
    static let ERROR_PasswordMatch = "New password and confirm password must be same"
}

struct ErrorRequired {
        static let ERROR_Email_Required = "Email Required"
        static let ERROR_Password_Required = "Password Required"
        static let ERROR_Name_Required = "Name Required"
}
   
struct LogoutPopupText {
        static let Title = "Are you sure you want to Log out ?"
        static let subtitle = "You will loose all the downloaded magazine in case if you logout. Although you can re-download it from the magazine screen."
    
}
struct ItunesUrl {
        static let Setting = "https://itunes.apple.com/us/developer/atom-apps-co-pty-ltd/id553197260"
        static let subscription = "https://buy.itunes.apple.com/WebObjects/MZFinance.woa/wa/manageSubscriptions"
        
}
struct  KEYS {
    static let LOGINKEY = "isLogin"
    static let USERINFO = "userInfo"
    static let LANGUAGE = "language"
    static let INTROVIEW = "intro"
    static let FIRTOKEN = "FirToken"
    static let TOKEN = "Token"
    static let Platform = "iOS"
    static let IsDashBoard = "IsDashboard"
    static let IsDashBoard1 = "IsDashboard1"
    static let isSpalce = "IsSpalce"
    static let isSubscription = "isSubscription"
    static let AppVersion = "1.0"
    static let PlatForm = "1"
    
    static let kHEADER_ICON_COLOR = "HEADER_ICON_COLOR"
    static let kHEADER_TEXT_COLOR = "HEADER_TEXT_COLOR"
    static let kMAIN_BG_COLOR = "MAIN_BG_COLOR"
    static let kBUTTON_BG_COLOR = "BUTTON_BG_COLOR"
    static let kBUTTON_TEXT_COLOR = "BUTTON_TEXT_COLOR"
    static let kTEXT_LIGHT_COLOR = "TEXT_LIGHT_COLOR"
    static let kLIST_BG_COLOR = "LIST_BG_COLOR"
    static let kTEXT_DARK_COLOR = "TEXT_DARK_COLOR"
    static let kTAG_BG_COLOR = "TAG_BG_COLOR"
    static let kTAG_SELECTED_COLOR = "TAG_SELECTED_COLOR"
    
}

struct  AppConstants {
     static let ktimer = 6
     static let ktime = 7
}
    
    


struct Notifications {
     static let BUDDYLISTREFRESHED = "buddyListRefreshed"
     static let MESSAGERECEIVED = "messageReceived"
     static let CHATHISTORYRETRIVED = "chatHistory"
}

struct ImagePaths {
     static let USERAVTAR = "myavtar"
}

struct THEME {
     static let BGCOLOR = UIColor.white
     
     static let BUTTON_BGCOLOR = UIColor.white
    
     static let NAVIGATIONTITLE_COLOR = UIColor(red: 172/255.0, green: 29/255.0, blue: 56/255.0, alpha: 1.0)
}

enum ErrorTypes: Error {
     case Empty
     case Short
}
}
