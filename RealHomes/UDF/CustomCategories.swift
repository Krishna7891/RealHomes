//
//  BTextField.swift
//  BlueCoupon
//
//  Created by Impero IT on 03/06/16.
//  Copyright © 2016 Impero IT. All rights reserved.
//

import UIKit
import CoreLocation
import SystemConfiguration
//import SWMessages
//import ObjectMapper
//import Alamofire
//import SwiftyJSON
//import Kingfisher
var sharedManager = Globals.sharedInstance


public func setUserDefaults(value : AnyObject, key : String) {
    UserDefaults.standard.set(value, forKey: key)
    UserDefaults.standard.synchronize()
}
public func getUserDefaults(key : String) -> AnyObject {
    let result = UserDefaults.standard.value(forKey: key)
    return result as AnyObject
}
public func deleteUserDefaults(key : String) {
    if(UserDefaults.standard.object(forKey: key) != nil) {
        UserDefaults.standard.removeObject(forKey: key)
    }
}

extension UITextView {
    
     open override func awakeFromNib() {
          if Constants.DeviceType.Is_IPhone_5 {
               self.font=UIFont(name: (self.font?.fontName)!, size: (self.font?.pointSize)! - 1 )
          }
          if Constants.DeviceType.Is_IPhone_6 {
               self.font=UIFont(name: (self.font?.fontName)!, size: (self.font?.pointSize)! + 3)
               
          }
          if Constants.DeviceType.Is_IPhone_6P {
               self.font=UIFont(name: (self.font?.fontName)!, size: (self.font?.pointSize)! + 4)
          }
          if Constants.DeviceType.Is_IPad {
               self.font=UIFont(name: (self.font?.fontName)!, size: (self.font?.pointSize)! + 7)
          }
     }
     
     
}



func isInternetAvailable() -> Bool
{
    var zeroAddress = sockaddr_in()
    zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
    zeroAddress.sin_family = sa_family_t(AF_INET)
    
    let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
        $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
            SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
        }
    }
    
    var flags = SCNetworkReachabilityFlags()
    if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
        return false
    }
    let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
    let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
    return (isReachable && !needsConnection)
}
func isValidEmail(Emailid:String) -> Bool {
     let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
     
     let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
     return emailTest.evaluate(with: Emailid)
}
func isValidPassword(Password:String) -> Bool {
     let regularExpression = "^(?=.*[0-9]+.*)(?=.*[a-zA-Z]+.*)[0-9a-zA-Z]{6,}$"
     let passwordValidation = NSPredicate.init(format: "SELF MATCHES %@", regularExpression)
     
     return passwordValidation.evaluate(with: Password)
}
extension UIView {
     func fadeIn(_ duration: TimeInterval = 1.0, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
               self.alpha = 1.0
          }, completion: completion)  }
     
     func fadeOut(_ duration: TimeInterval = 1.0, delay: TimeInterval = 0.0, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
               self.alpha = 0.0
          }, completion: completion)
     }
}
extension UILabel
{
     var optimalHeight : CGFloat
          {
          get
          {
               let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: CGFloat.greatestFiniteMagnitude))
               label.numberOfLines = 0
               label.lineBreakMode = self.lineBreakMode
               label.font = self.font
               label.text = self.text
               
               label.sizeToFit()
               
               return label.frame.height
          }
     }
}
extension UITextField {
    
     open override func awakeFromNib() {
          if Constants.DeviceType.Is_IPhone_5 {
               self.font=UIFont(name: (self.font?.fontName)!, size: (self.font?.pointSize)! - 1 )
          }
          if Constants.DeviceType.Is_IPhone_6 {
               self.font=UIFont(name: (self.font?.fontName)!, size: (self.font?.pointSize)! + 3)
               
          }
          if Constants.DeviceType.Is_IPhone_6P {
               self.font=UIFont(name: (self.font?.fontName)!, size: (self.font?.pointSize)! + 4)
          }
          if Constants.DeviceType.Is_IPad {
               self.font=UIFont(name: (self.font?.fontName)!, size: (self.font?.pointSize)! + 7)
          }
     }
}
extension UITextField{
     @IBInspectable var placeHolderColor: UIColor? {
          get {
               return self.placeHolderColor
          }
          set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
          }
     }
}

extension String {
    //Date to milliseconds
    
    func getDate(date:Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM,yyyy hh:mm a"
        return dateFormatter.string(from: date)
    }
    func getDate1(date:String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy, hh:mm a"
        return dateFormatter.date(from: date)!
    }
    func heightWithWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let maxSize = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let actualSize = self.boundingRect(with: maxSize, options: [.usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font: font], context: nil)
        return actualSize.height
    }
    func WidfthWithHeight(height: CGFloat, font: UIFont) -> CGFloat {
        let maxSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: height)
        let actualSize = self.boundingRect(with: maxSize, options: [.usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font: font], context: nil)
        return actualSize.width
    }
    func stringToDate() -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd,MMM,yyyy"
        let dateObj = dateFormatter.date(from: self)
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
        let str = dateFormatter.string(from: dateObj!)
        print(str)
       // dateFormatter.timeZone = TimeZone.current
        
       // let date = dateFormatter.date(from: str)
        return str
    }
    func DeliveryDate(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy | hh:mm"
        let DateObj = dateFormatter.string(from: date)
        return DateObj
    }
    
   
    func VersionDate(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        let DateObj = dateFormatter.string(from: date)
        return DateObj
    }
    func dateConvaer() -> Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd,MMM,yyyy"
        let dateObj = dateFormatter.date(from: self)
        
        let str = dateFormatter.string(from: dateObj!)
        dateFormatter.timeZone = TimeZone.current
        
        let date = dateFormatter.date(from: str)
        return date!
    }
   
    func dateFormateBirthDate() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd,MMM,yyyy"
        let dateObj = dateFormatter.date(from: self)
        dateFormatter.dateFormat = "yyyy-MMM-dd"
        let str = dateFormatter.string(from: dateObj!)
        return str
    }
    func stingtoBirthdate() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
        let dateObj = dateFormatter.date(from: self)
        dateFormatter.dateFormat = "dd,MMM,yyyy"
        return dateFormatter.string(from: dateObj!)
    }
    func getDayID() -> String{
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat  = "EEEE"
        let dayInWeek = dateFormatter.string(from: date)
        if dayInWeek == "Sunday"{
            return "0"
        }else if dayInWeek == "Monday"{
            return "1"
        }else if dayInWeek == "Tuesday"{
            return "2"
        }else if dayInWeek == "Wednesday"{
            return "3"
        }else if dayInWeek == "Thursday"{
            return "4"
        }else if dayInWeek == "Friday"{
            return "5"
        }else if dayInWeek == "Saturday"{
            return "6"
        }else{
            return "0"
        }
    }
    func anchorComponentsDay(date:Date) -> String{
        let calendar = Calendar.current
        let anchorComponents = calendar.dateComponents([.day, .month, .year], from: date)
        var day  = "\(anchorComponents.day!)"
        switch (day) {
        case "1" , "21" , "31":
            day.append("st")
        case "2" , "22":
            day.append("nd")
        case "3" ,"23":
            day.append("rd")
        default:
            day.append("th")
        }
        return day
    }
    mutating func dateFormateBirth(date:Date){
       // let date2 = date.stringToDate()
        
        let dateFromatter = DateFormatter()
        dateFromatter.dateFormat = "MMM"
        let month = dateFromatter.string(from: date)
        dateFromatter.dateFormat = "yyyy"
        let year = dateFromatter.string(from: date)
        
        let day = anchorComponentsDay(date: date)
        
        self = day + "," + month + "," + year
    }
    mutating func getTime(startDate:String , endDate:String){
        let dateFromatter = DateFormatter()
        dateFromatter.dateFormat = "HH:mm:ss"
        let startTime = dateFromatter.date(from: startDate)
        let endTime = dateFromatter.date(from: endDate)
        dateFromatter.dateFormat = "hh:mm a"
        let stime = dateFromatter.string(from: startTime!)
        let etime = dateFromatter.string(from: endTime!)
        self = "\(stime)" + " TO " + "\(etime)"
    }
    mutating func getTimeD(startDate:String , endDate:String){
        let dateFromatter = DateFormatter()
        dateFromatter.dateFormat = "HH:mm:ss"
        let startTime = dateFromatter.date(from: startDate)
        let endTime = dateFromatter.date(from: endDate)
        dateFromatter.dateFormat = "hh:mm a"
        let stime = dateFromatter.string(from: startTime!)
        let etime = dateFromatter.string(from: endTime!)
        self = "\(stime)" + " - " + "\(etime)"
    }
    mutating func getDateCheckIN(date:Date){
        let dateFromatter = DateFormatter()
        dateFromatter.dateFormat = "EEEE"
        let dayName = dateFromatter.string(from: date)
        let day = anchorComponentsDay(date: date)
        dateFromatter.dateFormat = "MMMM"
        let month = dateFromatter.string(from: date)
        dateFromatter.dateFormat = "yyyy"
        let year = dateFromatter.string(from: date)
        self = dayName + ", " + day + " " + month + " " + year
    }
    mutating func mapAPIDistance(lat:Double,lng:Double,value:String,isDistance:Bool){
      //  https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=22.9980888380569,72.4993523713682&rankby=distance&type=restaurant%7Ccasino%7Ccampground%7Cchurch%7Crestaurant%7Cairport%7Camusement_park%7Cbar%7Cbowling_alley%7Ccafe%7Claundry%7Clibrary%7Cmeal_takeaway%7Cmovie_theater%7Cmuseum%7Cnight_club%7Cpark%7Cuniversity%7Cgym&key=AIzaSyD6VRK0lLh53t-CTX-B04c0_PhpfnhorXM
        
        let Url  = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=" + "\(lat),\(lng)&"
        let type = "&type=restaurant%7Ccasino%7Ccampground%7Cchurch%7Crestaurant%7Cairport%7Camusement_park%7Cbar%7Cbowling_alley%7Ccafe%7Claundry%7Clibrary%7Cmeal_takeaway%7Cmovie_theater%7Cmuseum%7Cnight_club%7Cpark%7Cuniversity%7Cgym"
        
       // let Url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=" + "\(lat)," + "\(lng)" + "&type=casino%7Ccampground%7Cchurch%7Crestaurant%7Cairport%7Camusement_park%7Cbar%7Cbowling_alley%7Ccafe%7Claundry%7Clibrary%7Cmeal_takeaway%7Cmovie_theater%7Cmuseum%7Cnight_club%7Cpark%7Cuniversity%7Cgym&"
        let keys = "&key=" + Constants.MAPAPIKEY
        if isDistance{
            self = Url + "rankby=" + value + type + keys
        }else{
            self = Url + "radius=" + value + "000" + type + keys
        }
    }
    mutating func getMapImage(str:String){
        self = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=" + str + "&key=" + Constants.MAPAPIKEY
    }
    mutating func mapAPISearch(str:String,lat:Double,lng:Double,value:String,isDistance:Bool){
        let url = "https://maps.googleapis.com/maps/api/place/textsearch/json?query=" + str + "&location=" + "\(lat)," + "\(lng)" + "&type=casino%7Ccampground%7Cchurch%7Crestaurant%7Cairport%7Camusement_park%7Cbar%7Cbowling_alley%7Ccafe%7Claundry%7Clibrary%7Cmeal_takeaway%7Cmovie_theater%7Cmuseum%7Cnight_club%7Cpark%7Cuniversity%7Cgym&"
        let keys = "&key=" + Constants.MAPAPIKEY
        if isDistance{
            let str1 = (url + "rankby=" + value + keys).encodeEmoji
            self = str1.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        }else{
            let str1 = (url + "radius=" + value + "000" + keys).encodeEmoji
            self = str1.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        }
    }
    func stringFromHtml(string: String) -> NSAttributedString? {
        do {
            let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
            if let d = data {
                let str = try NSAttributedString(data: d,
                                                 options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
                                                 documentAttributes: nil)
                return str
            }
        } catch {
        }
        return nil
    }
    func dayLeft(str:String) -> Int{
        let calendar = NSCalendar.current

        let dateFromatter = DateFormatter()
        dateFromatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        let date = dateFromatter.date(from: str)
        let date1 = calendar.startOfDay(for: date!)
        let date2 = calendar.startOfDay(for: Date())
        let total  = calendar.dateComponents([.day,.year], from: date2, to: date1)
        print(total.day!)
        return total.day!
    }
    var decodeEmoji: String{
        let data = self.data(using: String.Encoding.utf8);
        let decodedStr = NSString(data: data!, encoding: String.Encoding.nonLossyASCII.rawValue)
        if let str = decodedStr{
            return str as String
        }
        return self
    }
    var encodeEmoji: String{
        if let encodeStr = NSString(cString: self.cString(using: .nonLossyASCII)!, encoding: String.Encoding.utf8.rawValue){
            return encodeStr as String
        }
        return self
    }
    func trim() -> String
    {
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
    }
    var containsWhitespace : Bool {
        return(self.rangeOfCharacter(from: .whitespacesAndNewlines) != nil)
    }
    
    //endode decode for password
    func base64EncodedString() -> String? {
        return data(using: .utf8)?.base64EncodedString()
    }
    
    func base64DecodedString() -> String? {
        guard let data = Data(base64Encoded: self) else { return nil }
        return String(data: data, encoding: .utf8)
    }
   
}

extension NSAttributedString {
    func heightWithWidth(width: CGFloat) -> CGFloat {
        let maxSize = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let actualSize = boundingRect(with: maxSize, options: [.usesLineFragmentOrigin], context: nil)
        return actualSize.height
    }
}
extension Bundle {
    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
}
enum VersionError: Error {
    case invalidResponse, invalidBundleInfo
}
func isUpdateAvailable() throws -> Bool {
    guard let info = Bundle.main.infoDictionary,
        let currentVersion = info["CFBundleShortVersionString"] as? String,
        let identifier = info["CFBundleIdentifier"] as? String,
        let url = URL(string: "http://itunes.apple.com/lookup?bundleId=\(identifier)") else {
            throw VersionError.invalidBundleInfo
    }
    let data = try Data(contentsOf: url)
    guard let json = try JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? [String: Any] else {
        throw VersionError.invalidResponse
    }
    if let result = (json["results"] as? [Any])?.first as? [String: Any], let version = result["version"] as? String {
        return version != currentVersion
    }
    throw VersionError.invalidResponse
}
extension Dictionary {
    func jsonString() -> NSString? {
        let jsonData = try? JSONSerialization.data(withJSONObject: self, options: [])
        guard jsonData != nil else {return nil}
        let jsonString = String(data: jsonData!, encoding: .utf8)
        guard jsonString != nil else {return nil}
        return jsonString! as NSString
    }
    
}
extension UILabel {
    func heightWithWidth(width: CGFloat) -> CGFloat {
        guard let text = text else {
            return 0
        }
        return text.heightWithWidth(width: width, font: font)
    }
    
    func heightWithAttributedWidth(width: CGFloat) -> CGFloat {
        guard let attributedText = attributedText else {
            return 0
        }
        return attributedText.heightWithWidth(width: width)
    }
    
    
    func setMyLabelText(myLabel: UILabel ,Str: String , SuperScript : String) {
        if let largeFont = UIFont(name: "ProximaNova-Regular", size: 18), let superScriptFont = UIFont(name: "ProximaNova-Regular", size:15) {
            let numberString = NSMutableAttributedString(string: Str, attributes: [.font: largeFont])
            numberString.append(NSAttributedString(string: SuperScript, attributes: [.font: superScriptFont, .baselineOffset: 13]))
            myLabel.attributedText = numberString
        }
    }
    
}

extension UILabel {
    open override func awakeFromNib() {
        if Constants.DeviceType.Is_IPhone_5 {
            self.font=UIFont(name: (self.font?.fontName)!, size: (self.font?.pointSize)!-1)
        }
        if Constants.DeviceType.Is_IPhone_6 || Constants.DeviceType.Is_IPhone_X {
               self.font=UIFont(name: (self.font?.fontName)!, size: (self.font?.pointSize)! + 3)
        }
        if Constants.DeviceType.Is_IPhone_6P {
            self.font=UIFont(name: (self.font?.fontName)!, size: (self.font?.pointSize)! + 4)
        }
        if Constants.DeviceType.Is_IPad {
            self.font=UIFont(name: (self.font?.fontName)!, size: (self.font?.pointSize)! + 7)
        }
    }
  
}

extension UIButton {
    open override func awakeFromNib() {
        if Constants.DeviceType.Is_IPhone_5 {
            self.titleLabel?.font=UIFont(name: (self.titleLabel!.font?.fontName)!, size: (self.titleLabel!.font?.pointSize)!-1)
        }
        if Constants.DeviceType.Is_IPhone_6 {
            self.titleLabel?.font=UIFont(name: (self.titleLabel!.font?.fontName)!, size: (self.titleLabel!.font?.pointSize)!+3)
        }
        else if Constants.DeviceType.Is_IPhone_6P {
            self.titleLabel?.font=UIFont(name: (self.titleLabel!.font?.fontName)!, size: (self.titleLabel!.font?.pointSize)!+4)
        }
        else if Constants.DeviceType.Is_IPad {
          self.titleLabel?.font=UIFont(name: (self.titleLabel!.font?.fontName)!, size: (self.titleLabel!.font?.pointSize)!+7)
     }
   }
    func setShadow(){
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = 5
    }
    
    
}

extension Int {
    func format(f: String) -> String {
        return String(format: "%\(f)d", self)
    }
}
extension Double {
    func format(f: String) -> String {
        return String(format: "%\(f)f", self)
    }
}
extension Float {
    func format(f: String) -> String {
        return String(format: "%\(f)f", self)
    }
    
}
extension String {
    var length: Int {
        return (self as NSString).length
    }
    
}
extension UIImage {
    convenience init(view: UIView) {
        UIGraphicsBeginImageContext(view.frame.size)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: false)
        // view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: (image?.cgImage!)!)
    }
    func imageWithGradient() -> UIImage{
        let img = self
        
        UIGraphicsBeginImageContext(img.size)
        let context = UIGraphicsGetCurrentContext()
        
        img.draw(at: CGPoint(x: 0, y: 0))
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let locations:[CGFloat] = [0.50, 1.0]
        //1 = opaque
        //0 = transparent
        let bottom = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8).cgColor
        let top = UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        
        let colors = [top,bottom
            ] as CFArray
        
        let gradient = CGGradient(colorsSpace: colorSpace,
                                  colors: colors, locations: locations)
        
        
        let startPoint = CGPoint(x: img.size.width/2,y: 0)
        let endPoint = CGPoint(x: img.size.width/2,y: img.size.height)
        
        context!.drawLinearGradient(gradient!, start: startPoint, end: endPoint, options: CGGradientDrawingOptions.init(rawValue: 0))
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        return image!
        
    }
    func compressForUpload(original:UIImage, withHeightLimit heightLimit:CGFloat, andWidthLimit widthLimit:CGFloat)->UIImage{
        
        let originalSize = original.size
        var newSize = originalSize
        
        if originalSize.width > widthLimit && originalSize.width > originalSize.height {
            
            newSize.width = widthLimit
            newSize.height = originalSize.height*(widthLimit/originalSize.width)
        }else if originalSize.height > heightLimit && originalSize.height > originalSize.width {
            
            newSize.width = 800
            newSize.height = originalSize.height*(widthLimit/originalSize.width)
        }
        
        // Scale the original image to match the new size.
        UIGraphicsBeginImageContext(newSize)
        
        original.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let compressedImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return compressedImage!
    }
   
}
func blur(image: UIImage) -> UIImage {
    let radius: CGFloat = 10;
    let context = CIContext(options: nil);
    let inputImage = CIImage(cgImage: image.cgImage!);
    let filter = CIFilter(name: "CIGaussianBlur");
    filter?.setValue(inputImage, forKey: kCIInputImageKey);
    filter?.setValue("\(radius)", forKey:kCIInputRadiusKey);
    let result = filter?.value(forKey: kCIOutputImageKey) as! CIImage;
    let rect = CGRect(x: radius * 2, y: radius * 2, width: image.size.width - radius * 4, height: image.size.height - radius * 4)
    let cgImage = context.createCGImage(result, from: rect);
    let returnImage = UIImage(cgImage: cgImage!);
    return returnImage;
}

extension UIView {
    func roundCornersView(_ corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    func setBorderCorner( borderWidth : CGFloat, borderColor : UIColor, radius : CGFloat)
    {
        self.layer.borderWidth = borderWidth
        self.layer.cornerRadius = radius
        self.layer.borderColor = borderColor.cgColor
    }
    func kkShadow()
    {
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 2.0
        layer.shadowColor = UIColor.lightGray.cgColor
    }
    func dropShadow(scale: Bool = true) {
        
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 5
    }
    func fadeIn(duration: TimeInterval = 0.5, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in }) {
        self.alpha = 0.0
        
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.isHidden = false
            self.alpha = 1.0
        }, completion: completion)
    }
    
    func fadeOut(duration: TimeInterval = 0.5, delay: TimeInterval = 0.0, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in }) {
        self.alpha = 1.0
        
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 0.0
        }) { (completed) in
            self.isHidden = true
            completion(true)
        }
    }
    
    
    
}
extension UITableView {
    func reloadTableview(completion: @escaping ()->()) {
        UIView.animate(withDuration: 0, animations: { self.reloadData() })
        { _ in completion() }
    }
    
}
extension UIViewController {
    
    func setStatusBarBackgroundColor(color: UIColor)
    {
        guard  let statusBar = (UIApplication.shared.value(forKey: "statusBarWindow") as AnyObject).value(forKey: "statusBar") as? UIView
            else
        {
            return
        }
        statusBar.backgroundColor = color
    }
    func backToRootAction() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    func backToViewControllerAction(strViewControllerName : String, isAnimated : Bool) {
        let objVC = self.storyboard?.instantiateViewController(withIdentifier: strViewControllerName)
        if (self.navigationController?.viewControllers.contains(objVC!))! {
            self.navigationController?.popToViewController(objVC!, animated: isAnimated)
        } else {
            self.navigationController?.popViewController(animated: isAnimated)
        }
    }
    func navigateVC(strViewControllerName : String, isAnimated : Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let objVC = self.storyboard?.instantiateViewController(withIdentifier: strViewControllerName)
        let nav : UINavigationController = appDelegate.window?.rootViewController as! UINavigationController
        nav.pushViewController(objVC!, animated: isAnimated)
    }
    //-----kk-----
    func AskConfirmation (title:String, message:String, completion:@escaping (_ result:Bool) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.view.tintColor = UIColor.black//Constants.THEME.NAVIGATION_BAR_COLOR
        self.present(alert, animated: true, completion: nil)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            completion(true)
        }))
        
        //        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
        //            completion(false)
        //        }))
    }
    func popBack<T: UIViewController>(toControllerType: T.Type) {
        if var viewControllers: [UIViewController] = self.navigationController?.viewControllers {
            viewControllers = viewControllers.reversed()
            for currentViewController in viewControllers {
                if currentViewController .isKind(of: toControllerType) {
                    self.navigationController?.popToViewController(currentViewController, animated: false)
                    break
                }
            }
        }
    }
    func add_child(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    func remove_add_child() {
        guard parent != nil else {
            return
        }
        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }
    func scrollToTop(animated: Bool) {
        if let tv = self as? UITableViewController {
            tv.tableView.setContentOffset(CGPoint.zero, animated: animated)
        } else if let cv = self as? UICollectionViewController{
            cv.collectionView?.setContentOffset(CGPoint.zero, animated: animated)
        } else {
            for v in view.subviews {
                if let sv = v as? UIScrollView {
                    sv.setContentOffset(CGPoint.zero, animated: animated)
                }
            }
        }
    }
    
    func RemovePath(){
        let fileManager = FileManager.default
        
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        print("Directory: \(paths)")
        
        do
        {
            let fileName = try fileManager.contentsOfDirectory(atPath: paths)
            
            for file in fileName {
                // For each file in the directory, create full path and delete the file
                let filePath = URL(fileURLWithPath: paths).appendingPathComponent(file).absoluteURL
                try fileManager.removeItem(at: filePath)
            }
        }catch let error {
            print(error.localizedDescription)
        }
    }

    func distanceBetweenTwoLocationsKm(source:CLLocation,destination:CLLocation) -> Double{
        let distanceMeters = source.distance(from: destination)
        let distanceKM = distanceMeters / 1000
        print(distanceKM)
        // let roundedTwoDigit = distanceKM.rounded()
        let miles : Double = Double(distanceKM*0.62137)
        _ = String(format: "%.2f", miles)
        print(miles)
        _ = String(format: "%.2f",distanceKM)
        return miles
    }
    func currentTimeInMiliseconds(SelectDate: Date) -> Int {
        let currentDate = SelectDate
        let since1970 = currentDate.timeIntervalSince1970
        return Int(since1970 * 1000)
    }
    //let shareManager : Globals = Globals.sharedInstance
    //var shareManger : Globals = Globals.sharedInstance
    public func showAlert(title: String?, message: String?, preferredStyle: UIAlertController.Style, alertActions: [UIAlertAction]) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        
        for alertAction in alertActions {
            alertController.addAction(alertAction)
        }
        
        self.present(alertController, animated: true, completion: nil)
    }
    func openUrl(string:String){
        guard let url = URL(string: string) else {
            return //be safe
        }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    func openCallNumber(str:String){
        let str1 = str.removingWhitespaces()
        if let url = URL(string: "tel://\(str1)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    func navigationBackSwipe(){
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    func gotoSettings(){
        let alert = UIAlertController(title: "Location is Disabled", message:"Go to your Settings App > Privacy > Location Services", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default , handler:{ (UIAlertAction)in
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(URL(string:"App-Prefs:root=General")!, options: [:], completionHandler: nil)
            } else {
                // Fallback on earlier versions
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    func shareAPP(appId:String){
//        let val = sharedManager.MankoRoot.Result.AppShareLink + appId
//        let vc = UIActivityViewController.init(activityItems:[val], applicationActivities: nil)
//        self.present(vc, animated: true, completion: nil)
    }
    func rateApp(appId: String, completion: @escaping ((_ success: Bool)->())) {
        guard let url = URL(string : "itms-apps://itunes.apple.com/app/" + appId) else {
            completion(false)
            return
        }
        guard #available(iOS 10, *) else {
            completion(UIApplication.shared.openURL(url))
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: completion)
    }
    func navigtionBarHidden(){
        self.navigationController?.isNavigationBarHidden = true
    }
    func showNavigationBar(title:String,isShadow:Bool){
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = title
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.NAVIGATIONTITLE_COLOR,
             NSAttributedString.Key.font: UIFont(name: "SFUIText-Bold", size: 15)!]
        self.navigationItem.hidesBackButton = true
        if isShadow{
           // self.navigationController?.navigationBar.isTranslucent = false
            setShadowNavigationbar()
        }else{
            //self.navigationController?.navigationBar.isTranslucent = true
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
           self.navigationController?.navigationBar.shadowImage = UIImage()
        }
    }
    func showNavigationBarWITHImg(title:String,img:UIImage){
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = title
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
       // self.navigationController?.navigationBar.backIndicatorImage = img
        self.navigationController?.navigationBar.backItem?.title = ""
       // self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = img
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = UIColor.NAVIGATIONTITLE_COLOR
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.NAVIGATIONTITLE_COLOR,
             NSAttributedString.Key.font: UIFont(name: "OpenSans-Bold", size: 20)!]
    }
    func setShadowNavigationbar(){
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize.zero
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.5
        self.navigationController?.navigationBar.layer.shadowRadius = 5
    }
    func popNavigation(){
        _ = self.navigationController?.popViewController(animated: true)
    }
    func locationCheck() -> Bool{
        if CLLocationManager.locationServicesEnabled() {
            switch(CLLocationManager.authorizationStatus()) {
            case .notDetermined, .restricted, .denied:
                return false
            case .authorizedAlways, .authorizedWhenInUse:
                print("Access")
                return true
            }
        } else {
            print("Location services are not enabled")
            return false
        }
    }
    func distanceBetweenTwoLocations(source:CLLocation,destination:CLLocation) -> String{
        let distanceMeters = source.distance(from: destination)
        let distanceKM = distanceMeters / 1000
        // let roundedTwoDigit = distanceKM.rounded()
        let miles : Double = Double(distanceKM*0.62137)
        _ = String(format: "%.2f", miles)
        let kmstr = String(format: "%.2f",distanceKM)
        return kmstr
    }
    func distanceBetweenTwoLocationsMiles(source:CLLocation,destination:CLLocation) -> String{
        let distanceMeters = source.distance(from: destination)
        let distanceKM = distanceMeters / 1000
        // let roundedTwoDigit = distanceKM.rounded()
        let miles : Double = Double(distanceKM*0.62137)
        _ = String(format: "%.2f", miles)
        let kmstr = String(format: "%.2f",miles)
        return kmstr
    }
    func createAttributedString(fullString: String, fullStringColor: UIColor, subString: String, subStringColor: UIColor , lable : UILabel,label1:UILabel) -> NSMutableAttributedString
    {
        let result = NSMutableAttributedString()
        let attributes = [NSAttributedString.Key.font: UIFont(name: lable.font.fontName, size: lable.font.pointSize + 5)!,NSAttributedString.Key.foregroundColor: fullStringColor]
        let str = NSAttributedString(string: fullString, attributes: attributes)
        
        let attributes1 = [NSAttributedString.Key.font: UIFont(name: label1.font.fontName, size: lable.font.pointSize)!,NSAttributedString.Key.foregroundColor: subStringColor]
        let str1 = NSAttributedString(string: subString, attributes: attributes1)
        result.append(str)
        result.append(str1)
        return result
    }

    //Loader
    
    
}

extension UIColor{
    static let NAVIGATIONTITLE_COLOR = UIColor.white
    static let NAVIGATIONBACKTINTCOLOR = UIColor(red: 24/255.0, green: 49/255.0, blue: 89/255.0, alpha: 1.0)
}
extension String {
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
}
extension Date {
    func toWebString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self)
    }
    func toDisplayString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        return dateFormatter.string(from: self)
    }
    func toCalenderHeaderString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM-dd"
        return dateFormatter.string(from: self)
    }
    func timeFormate() -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        let dateObj = dateFormatter.string(from: self)
        return dateObj
    }
    func stringToDate(date:Date) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
        let dateObj = dateFormatter.string(from: date)
        return dateObj
    }
    
}

extension Dictionary
{
    public init(keys: [Key], values: [Value])
    {
        precondition(keys.count == values.count)
        
        self.init()
        
        for (index, key) in keys.enumerated()
        {
            self[key] = values[index]
        }
    }
}

extension UIView {
    func constrainToEdges(_ subview: UIView) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        let topContraint = NSLayoutConstraint(
            item: subview,
            attribute: .top,
            relatedBy: .equal,
            toItem: self,
            attribute: .top,
            multiplier: 1.0,
            constant: 0)
        
        let bottomConstraint = NSLayoutConstraint(
            item: subview,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: self,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 0)
        
        let leadingContraint = NSLayoutConstraint(
            item: subview,
            attribute: .leading,
            relatedBy: .equal,
            toItem: self,
            attribute: .leading,
            multiplier: 1.0,
            constant: 0)
        
        let trailingContraint = NSLayoutConstraint(
            item: subview,
            attribute: .trailing,
            relatedBy: .equal,
            toItem: self,
            attribute: .trailing,
            multiplier: 1.0,
            constant: 0)
        
        addConstraints([
            topContraint,
            bottomConstraint,
            leadingContraint,
            trailingContraint])
    }
    func addShadow(){
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 5
        self.layer.shouldRasterize = true
    }
    
    
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func AddShadowinImageview(){
        let outerView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        outerView.clipsToBounds = false
        outerView.layer.shadowColor = UIColor.black.cgColor
        outerView.layer.shadowOpacity = 1
        outerView.layer.shadowOffset = CGSize.zero
        outerView.layer.shadowRadius = 10
        outerView.layer.shadowPath = UIBezierPath(roundedRect: outerView.bounds, cornerRadius: 10).cgPath
    }
    func addDashedBorder() {
        let color = UIColor.red.cgColor
        
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
        
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = 2
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = [6,3]
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 5).cgPath
        self.layer.addSublayer(shapeLayer)
    }
    func setRounded()
    {
        self.layer.cornerRadius = (self.frame.height / 2.0)
        self.clipsToBounds = true
    }
}

extension UITableView
{
    func SetTableViewBlankLable(count:Int,str:String)
    {
        if(count==0)
        {
            removeOldLable()
          
            let lblText:UILabel = UILabel()
            // lblText.frame = CGRectMake(0, 0, self.frame.width, self.frame.height)
            lblText.frame = self.frame
            lblText.numberOfLines = 0
            lblText.text = str
            lblText.textAlignment = .center
            lblText.textColor = UIColor(red: 255/255.0, green: 175/255.0, blue: 36/255.0, alpha: 1.0)
              lblText.font  = UIFont(name: sharedManager.FontSemiBold, size: 15.0)
            self.backgroundColor = UIColor.clear
            self.separatorStyle = .none
            lblText.tag = 987654
           
            self.superview!.insertSubview(lblText, belowSubview: self)
        }
        else
        {
            removeOldLable()
            self.separatorStyle = .singleLine
        }
    }
    func removeOldLable()
    {
        for view in self.superview!.subviews
        {
            if(view is UILabel)
            {
                if(view.tag == 987654)
                {
                    view.removeFromSuperview()
                }
            }
        }
    }
}
extension UICollectionView
{
    func SetColletionViewLable(count:Int,str:String, color:UIColor)
    {
        if(count==0)
        {
            removeOldLable()
            let imgSmilye : UIImageView = UIImageView()
            imgSmilye.image = #imageLiteral(resourceName: "SadSmily")
            imgSmilye.frame.size.height = 100
            imgSmilye.frame.size.width = 100
            imgSmilye.frame.origin.x = Constants.ScreenSize.SCREEN_WIDTH / 2.6
            imgSmilye.frame.origin.y = Constants.ScreenSize.SCREEN_HEIGHT / 2.4
            let lblText:UILabel = UILabel()
          //  lblText.frame = CGRectMake(0, 0, self.frame.width, self.frame.height)
            lblText.frame = self.frame
           
            lblText.numberOfLines = 0
            lblText.text = str
            lblText.textAlignment = .center
            lblText.textColor = color
            lblText.font  = UIFont(name: sharedManager.FontSemiBold, size: 15.0)
            self.backgroundColor = UIColor.clear
            //self.separatorStyle = .none
            lblText.tag = 987654
            //self.superview!.insertSubview(imgSmilye, belowSubview: self)
            self.superview!.insertSubview(lblText, belowSubview: self)
        }
        else
        {
            removeOldLable()
            // self.separatorStyle = .singleLine
        }
    }
    func removeOldLable()
    {
        for view in self.superview!.subviews
        {
            if(view is UILabel)
            {
                if(view.tag == 987654)
                {
                    view.removeFromSuperview()
                }
            }
        }
    }
}
typealias ButtonAction = () -> Void

fileprivate struct AssociatedKeys {
    static var touchUp = "touchUp"
}

fileprivate class ClosureWrapper {
    var closure: ButtonAction?
    
    init(_ closure: ButtonAction?) {
        self.closure = closure
    }
}
extension UIControl {
    @objc private func performTouchUp() {
        guard let action = action else {
            return
        }
        action()
    }
    var action: ButtonAction? {
        get {
            let closure = objc_getAssociatedObject(self, &AssociatedKeys.touchUp)
            guard let action = closure as? ClosureWrapper else{
                return nil
            }
            return action.closure
        }
        set {
            if let action = newValue {
                let closure = ClosureWrapper(action)
                objc_setAssociatedObject(
                    self,
                    &AssociatedKeys.touchUp,
                    closure as ClosureWrapper,
                    .OBJC_ASSOCIATION_RETAIN_NONATOMIC
                )
                self.addTarget(self, action: #selector(performTouchUp), for: .touchUpInside)
            } else {
                self.removeTarget(self, action: #selector(performTouchUp), for: .touchUpInside)
            }
            
        }
    }
}
//func Status(controller : UIViewController ,title : String, subtitle : String, type : SWMessageNotificationType, duration : Int, atPosition : SWMessageNotificationPosition,canBeDismissedByUser : Bool ) {
//    SWMessage.sharedInstance.showNotificationInViewController(controller, title: title, subtitle: subtitle, image: nil, type: type, duration: .custom(TimeInterval(duration)), callback: nil, buttonTitle: nil, buttonCallback: nil, atPosition: atPosition, canBeDismissedByUser: canBeDismissedByUser)
//}
func getPath() -> String {
    let plistFileName = "Maanko.plist"
    let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
    let documentPath = paths[0] as NSString
    let plistPath = documentPath.appendingPathComponent(plistFileName)
    return plistPath
}
func DecimalFractions(amount: Double) -> String{
    let numberFormatter = NumberFormatter()
    numberFormatter.groupingSeparator = ","
    numberFormatter.groupingSize = 3
    numberFormatter.usesGroupingSeparator = true
    numberFormatter.decimalSeparator = "."
    numberFormatter.numberStyle = .currency
    numberFormatter.maximumFractionDigits = 2
    numberFormatter.minimumFractionDigits = 2
    
    return numberFormatter.string(from: amount as NSNumber)!
}
extension NSMutableAttributedString {

    
    
    @discardableResult func bold(_ text: String) -> NSMutableAttributedString {
        let attrs: [NSAttributedString.Key: Any] = [.font: UIFont(name: sharedManager.FontSemiBold, size: CGFloat(AttributedfontSize()))!]
        let boldString = NSMutableAttributedString(string:text, attributes: attrs)
        append(boldString)
        
        return self
    }
    
    @discardableResult func normal(_ text: String) -> NSMutableAttributedString {
        let normal = NSAttributedString(string: text)
        append(normal)
        
        return self
    }
    
    
    
    @discardableResult func UnderlinedText(_ text: String, Fontsize : CGFloat, FontName : String) -> NSMutableAttributedString {
        let yourAttributes : [NSAttributedString.Key: Any] =
            [NSAttributedString.Key.font : UIFont(name: FontName, size: Fontsize)!,
             NSAttributedString.Key.foregroundColor : UIColor.black,
             NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue]
        let UnderlinedText = NSMutableAttributedString(string:text, attributes: yourAttributes)
        append(UnderlinedText)
        return self
    }
    @discardableResult func Normal(_ text: String, Fontsize : CGFloat , FontName : String) -> NSMutableAttributedString {
        let attrs: [NSAttributedString.Key: Any] = [.font: UIFont(name: FontName, size: Fontsize)!, NSAttributedString.Key.foregroundColor: UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0) ]
        let boldString = NSMutableAttributedString(string:text, attributes: attrs)
        append(boldString)
        return self
    }
}



func NormaltoUnderlined(Normal : String, UnderLinedText : String,fontsize : CGFloat, FontName : String) -> NSMutableAttributedString {
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.alignment = .center
    paragraphStyle.lineSpacing = 1
    paragraphStyle.paragraphSpacing = 1
    let formattedString = NSMutableAttributedString()
    formattedString
        .Normal(Normal, Fontsize: fontsize, FontName: FontName)
        .UnderlinedText(UnderLinedText, Fontsize: fontsize, FontName: FontName)
    formattedString.addAttributes([NSAttributedString.Key.paragraphStyle: paragraphStyle], range: NSRange(location: 0, length: formattedString.length))
    return formattedString
}
func AttributedfontSize() -> Float
{
    if Constants.DeviceType.Is_IPhone_5 {
        return 12
    }
    else if Constants.DeviceType.Is_IPhone_6 || Constants.DeviceType.Is_IPhone_X {
        return 14
    }
    else if Constants.DeviceType.Is_IPhone_6P {
        return 16
    }
    else{
        return 20
    }
}
