//
//  MessageVC.swift
//  FirebaseChatDemo
//
//  Created by mac-pc2 on 24/10/18.
//  Copyright © 2018 mac-pc2. All rights reserved.
//  oQBlHbPTl1WDekEcvHLf4rDRr8F3

//public var _adminKey : String = "10EGzuDG0RcguHBpoER8flZw0Nw1"
public var _adminKey : String = ""

public var _badgeCount : Int = 0
public var _nowInChatScreen : Bool = false
//public var _FIR_USER_KEY : String = ""


private var xoAssociationKeyForBottomConstrainInVC: UInt8 = 0


import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth
import IQKeyboardManagerSwift


class cellSender: UITableViewCell
{
    @IBOutlet weak var lblMsg: UILabel!
    @IBOutlet weak var imgBG: UIImageView!
    @IBOutlet weak var lblTime: UILabel!
    
    override func awakeFromNib() {
//       imgBG.setBorderCorner(borderWidth: 0, borderColor: UIColor.clear, radius: 10)
    }
    
}

class cellReceiver: UITableViewCell
{
    @IBOutlet weak var lblMsg: UILabel!
    @IBOutlet weak var imgBG: UIImageView!
    @IBOutlet weak var lblTime: UILabel!
    
    override func awakeFromNib() {
//        imgBG.setBorderCorner(borderWidth: 0, borderColor: UIColor.clear, radius: 10)
    }
}


class MessageVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var sharedManager : Globals = Globals.sharedInstance

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tblMSG: UITableView!
    @IBOutlet weak var txtEnterMsg: UITextField!
    
    var messages = [Message]()
    let arrText = NSMutableArray()

    var _name : String = ""
    var _rid : String = ""
    var _sid : String = ""
    var isSended : Bool = false

    @IBOutlet weak var txtBottomConstraint: NSLayoutConstraint!
    
    //-------------------------------------------
    var CURRENT_USER_ID: String {
        let id = FIRAuth.auth()!.currentUser?.uid
        return id!
    }
    
    /** The base Firebase reference */
    let BASE_REF = FIRDatabase.database().reference()
    /* The user Firebase reference */
    let USER_REF = FIRDatabase.database().reference().child(USERdatabase)
    let FRIENDS_REF = FIRDatabase.database().reference().child(FRIENDdatabase)
    
    /** The Firebase reference to the current user tree */
    var CURRENT_USER_REF: FIRDatabaseReference {
        let id = FIRAuth.auth()!.currentUser!.uid
        return USER_REF.child("\(id)")
    }
    
    /** The Firebase reference to the current user's friend tree */
    var CURRENT_USER_FRIENDS_REF: FIRDatabaseReference {
        return CURRENT_USER_REF.child(FRIENDdatabase)
    }
    //-------------------------------------------
    
    var roomId : String = ""
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        print(_name)
        
        _nowInChatScreen = true
//        IQKeyboardManager.shared.enable = false
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
//        lblTitle.text = sharedManager.currentUser.userInfo?.firstName
        tblMSG.tableFooterView = UIView()
        tblMSG.rowHeight = UITableView.automaticDimension
        tblMSG.estimatedRowHeight = 60
        
        _adminKey = (sharedManager.currentUser.userInfo?.firebaseKey)!
        roomId = "\(CURRENT_USER_ID)_\(_adminKey)"

        
        //-------- check room exist or not -------
        let usersDB = FIRDatabase.database().reference().child(MESSAGEdatabase)
        usersDB.observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.hasChild(self.roomId) {
                print("roomId already taken.")
                self.fetchMessages(_rid: self.roomId)
            }else{
                print("roomId not taken.")
                self.fetchMessages(_rid: self.roomId)
            }
        })
        //----------------------------------------
        
        _badgeCount = 0
        
//        print(txtBottomConstraint)
        self.containerDependOnKeyboardBottomConstrain = txtBottomConstraint
        self.watchForKeyboard()
    }
    var containerDependOnKeyboardBottomConstrain :NSLayoutConstraint! {
        get {
            return objc_getAssociatedObject(self, &xoAssociationKeyForBottomConstrainInVC) as? NSLayoutConstraint
        }
        set(newValue) {
            objc_setAssociatedObject(self, &xoAssociationKeyForBottomConstrainInVC, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    func watchForKeyboard () {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown(notification:)), name:UIResponder.keyboardWillShowNotification, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(notification:)), name:UIResponder.keyboardWillHideNotification, object: nil);
    }
    @objc func keyboardWasShown(notification: NSNotification) {
        let info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.containerDependOnKeyboardBottomConstrain.constant = -keyboardFrame.height
            
            self.view.layoutIfNeeded()
        })
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.containerDependOnKeyboardBottomConstrain.constant = 0
            self.view.layoutIfNeeded()
        })
    }
    
    
    override func dismissKeyboard() {
        view.endEditing(true)
    }
    func fetchMessages(_rid : String)
    {
        
        let ref = FIRDatabase.database().reference().child(MESSAGEdatabase).child(_rid)
        ref.observe(.childAdded) { (snapshot) in

//            let timestamp = Date().currentTimeMillis()
//            print(timestamp!)
            
            if let dictionary = snapshot.value as? NSDictionary {
                
                let keyID = snapshot.key
                print("VIRAL",keyID)
                
                let msg = Message()
                print(dictionary)
                msg.deliveredTime = dictionary["deliveredTime"] as? NSNumber
                msg.idReceiver = dictionary["idReceiver"] as? String
                msg.idSender = dictionary["idSender"] as? String
                msg.isPending = dictionary["isPending"] as? String
                msg.isReceive = dictionary["isReceive"] as? String
                let _isSeen = dictionary["isSeen"] as? Bool
                msg.isSent = dictionary["isSent"] as? String
                let _key = keyID
                msg.readTime = dictionary["readTime"] as? NSNumber
                msg.text = dictionary["text"] as? String
                msg.timeStamp = dictionary["timeStamp"] as? NSNumber
                msg.isSeen = _isSeen
                msg.key = keyID
                
                self.arrText.add(msg.text!)
//                print(self.arrText)
                if _isSeen == false && msg.idSender != self.CURRENT_USER_ID{
                    print("VIRAL timestamp",msg.timeStamp)
                    let ref = FIRDatabase.database().reference().child(MESSAGEdatabase).child(self.roomId).child(_key)
                    ref.updateChildValues([
                        "deliveredTime" : msg.deliveredTime!,
                        "idReceiver" : self.roomId,
                        "idSender" : msg.idSender!,
                        "isPending" : true,
                        "isReceive" : false,
                        "isSeen" : true,
                        "isSent" : true,
                        "key" : _key,
                        "readTime" : msg.readTime!,
                        "text" : msg.text!,
                        "timeStamp" : msg.timeStamp!
                        ] as [String : Any])

                    
                }
                self.messages.append(msg)
                
                if self.isSended == true{
                    ref.cancelDisconnectOperations()
                }
                
                DispatchQueue.main.async( execute: {
                    self.tblMSG.reloadData()
                    self.scrollToBottom()
                })
            }
            
        }
    }
    
    //MARK:- Buttons action
    
    @IBAction func back_tapped(_ sender: UIButton)
    {
        IQKeyboardManager.shared.enable = true
        _nowInChatScreen = false
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func return_tapped(_ sender: UIControl)
    {
        IQKeyboardManager.shared.enable = true
        _nowInChatScreen = false
        self.navigationController?.popViewController(animated: true)
    }
//    @IBAction func back_tapped(_ sender: UIControl)
//    {
//        self.navigationController?.popViewController(animated: true)
//    }
    
    @IBAction func send_tapped(_ sender: UIButton)
    {
        if txtEnterMsg.text?.count != 0{
            sendFunction(room: roomId)
        }
    }
    
    func sendFunction(room: String)
    {
        let timestamp = Date().currentTimeMillis()
        print(timestamp!)
        
        isSended = true
        print("Sended room created....",room)
        let _id = FIRDatabase.database().reference().childByAutoId().key
        let ref = FIRDatabase.database().reference().child(MESSAGEdatabase).child(room).child(_id)
        
        let value = [
                "deliveredTime" : timestamp!,
                "idReceiver" : room,
                "idSender" : CURRENT_USER_ID,
                "isPending" : true,
                "isReceive" : false,
                "isSeen" : false,
                "isSent" : true,
                "key" : _id,
                "readTime" : timestamp!,
                "text" : txtEnterMsg.text!,
                "timeStamp" : timestamp!
            
            ] as [String : Any]
        txtEnterMsg.text = ""
        ref.updateChildValues(value)
        
        let _name = "\(self.sharedManager.currentUser.userInfo?.firstName! ?? "") \(self.sharedManager.currentUser.userInfo?.lastName! ?? "")"
        let refUser = FIRDatabase.database().reference().child(USERdatabase).child(CURRENT_USER_ID)
        let data = ["name": _name,
                    "email": sharedManager.currentUser.userInfo?.email! ?? "",
                    "userId": self.CURRENT_USER_ID,
                    "id": sharedManager.currentUser.userInfo?.id! ?? "1",
                    "isOnline" : true,
                    "timeStamp" : timestamp!,
                    "textStatus" : "Can't talk",
                    "avatar" : "default",
                    "lastMsgTime" : timestamp!,
                    "userType" : self.sharedManager.currentUser.userInfo?.usertype! ?? "1"
            ] as [String : Any]
        print("dataaaa", data)
        refUser.updateChildValues(data)
    }
    
    //MARK:- Tableview methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let msg = messages[indexPath.row]
        let _sender = msg.idSender
        
        if _sender == CURRENT_USER_ID{
            let cell : cellSender = tableView.dequeueReusableCell(withIdentifier: "cellSender", for: indexPath) as! cellSender
            cell.lblMsg.text = msg.text
            
            let timestampDate = NSDate(timeIntervalSince1970: Double(truncating: msg.timeStamp!)/1000)
            print(timestampDate)
        /*    //----------
            let timeStamp = Int(truncating: msg.timeStamp!) / 1000
            let _date = getDateFromTimeStamp(timeStamp: Double(timeStamp))
            
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MM-yyyy hh:mm"
            formatter.timeZone = NSTimeZone(abbreviation: "UTC") as TimeZone?
            
            let dateString = formatter.date(from: _date)
            print("date convert sender",dateString!)
            //----------  */
            
            let _timeAgo = timeAgoSince(timestampDate as Date)
            cell.lblTime.text = "\(_timeAgo)"
            
            DispatchQueue.main.async {
            cell.imgBG.roundCorners([.bottomLeft, .topRight, .topLeft], radius: 10)
            }
            
            return cell
        }else {
            let cell : cellReceiver = tableView.dequeueReusableCell(withIdentifier: "cellReceiver", for: indexPath) as! cellReceiver
            cell.lblMsg.text = msg.text
            
            let timestampDate = NSDate(timeIntervalSince1970: Double(truncating: msg.timeStamp!)/1000)
            print(timestampDate)
            
        /*    //----------
            let timeStamp = Int(truncating: msg.timeStamp!) / 1000
            let _date = getDateFromTimeStamp(timeStamp: Double(timeStamp))
            
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MM-yyyy hh:mm"
            formatter.timeZone = NSTimeZone(abbreviation: "UTC") as TimeZone?
            let dateString = formatter.date(from: _date)
            print("date convert receiver",dateString!)
            //----------  */
            
            let _timeAgo = timeAgoSince(timestampDate as Date)
            cell.lblTime.text = "\(_timeAgo)"
            
            
            
            DispatchQueue.main.async {
                cell.imgBG.roundCorners([.bottomRight, .topRight, .topLeft], radius: 10)
            }
            
            return cell
        }
        
    }
    
    func convertTimestamp(serverTimestamp: Double) -> String {
        let x = serverTimestamp / 1000
        let date = NSDate(timeIntervalSince1970: x)
        let formatter = DateFormatter()
       // formatter.dateFormat = "dd-MM-yyyy hh:mm"
        formatter.dateStyle = .long
        formatter.timeStyle = .medium
        
        return formatter.string(from: date as Date)
    }
    func getDateFromTimeStamp(timeStamp : Double) -> String {
        let date = NSDate(timeIntervalSince1970: timeStamp)
//        let date = NSDate(timeIntervalSinceNow: timeStamp)
        
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "dd-MM-yyyy hh:mm"//"dd-MMM-YY, hh:mm a"
//        dayTimePeriodFormatter.dateStyle = .long
//        dayTimePeriodFormatter.timeStyle = .medium
//        dayTimePeriodFormatter.timeZone = NSTimeZone(abbreviation: "UTC") as TimeZone?
        
        let dateString = dayTimePeriodFormatter.string(from: date as Date)
//        let dateString = dayTimePeriodFormatter.date(from: date as Date)
        return dateString
    }
    func scrollToBottom(){
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: self.arrText.count-1, section: 0)
            self.tblMSG.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    
    //MARK:- UDF
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return .lightContent
    }
    
}

//MARK:- For keyboard
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
extension UIView {
    func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}


extension UIViewController {
    
    
}




//Cell for row timestamp to timeago display
/*

 //----------
 let timeStamp = Int(truncating: msg.timeStamp!) / 1000
 let _date = getDateFromTimeStamp(timeStamp: Double(timeStamp))
 //            print(_date)
 
 let formatter = DateFormatter()
 formatter.dateFormat = "dd-MM-yyyy hh:mm"
 formatter.timeZone = NSTimeZone(abbreviation: "UTC") as TimeZone?
 
 let dateString = formatter.date(from: _date)
 print("date convert sender",dateString!)
 
 let _timeAgo = timeAgoSince(timestampDate as Date)
 cell.lblTime.text = "\(_timeAgo)"
 //----------
 
*/

