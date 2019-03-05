//
//  Globals.swift
//  BlueCoupon
//
//  Created by Impero IT on 03/06/16.
//  Copyright © 2016 Impero IT. All rights reserved.
//

import UIKit
import SystemConfiguration
import CoreLocation

class Globals {
    static let sharedInstance = Globals()
    var deviceToken : String!
    var IsDownloadPdf = false
    var DownloadId = 0
    var URlString = ""
    
    var selectedTheme : Int = -1
    
    var currentCoordinate = CLLocationCoordinate2D()
//    var MankoUserLogin : MankoUser = MankoUser()
//    var MankoRoot : MaankoMaster = MaankoMaster()
//    var downloadedMagazines : [Magazines] = []
//    var MankoSplace : MagazineSplaceModel = MagazineSplaceModel()
//    var MankoSubscriptions : SubscriptionsResponse = SubscriptionsResponse()
    var FontBold = "ProximaNova-Bold"
    var FontRegular = "ProximaNova-Regular"
    var FontSemiBold = "ProximaNova-Semibold"
    var ButtonFontSize : CGFloat = 18
    var labelHeaderFontSize : CGFloat = 18
    var labelNormalFontSize : CGFloat = 18
    var ButtonCornerRadious : CGFloat = 10
    
    var HEADER_ICON_COLOR : String = "6EE9FF"
    var HEADER_TEXT_COLOR : String = "060012"
    var MAIN_BG_COLOR : String = "D4B400"
    var BUTTON_BG_COLOR : String = "6EE9FF"
    var BUTTON_TEXT_COLOR : String = "060012"
    var TEXT_LIGHT_COLOR : String = "007D7D"
    var LIST_BG_COLOR : String = "D4B400"
    var TEXT_DARK_COLOR : String = "007D7D"
    var TAG_BG_COLOR : String = ""
    var TAG_SELECTED_COLOR : String = ""
    
    
    
    private init() {
       currentCoordinate.latitude = 55.6761
       currentCoordinate.longitude = 12.5683
    }
}

func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }
    
    if ((cString.count) != 6) {
        return UIColor.gray
    }
    
    var rgbValue:UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

