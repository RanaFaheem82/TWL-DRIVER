import Foundation
import UIKit
import StoreKit
import GoogleMaps

class Global {
    class var shared : Global {
        
        struct Static {
            static let instance : Global = Global()
        }
        return Static.instance
    }
    
    var vehicle : VehicleViewModel?
    var user:UserViewModel?
    var FCMToken:String? = ""
    var isLogedIn:Bool = false
    var fcmToken:String? = "fuifhesdiiodo"
    var url: String  = "http://110.36.237.219"
    var systemVersion = UIDevice.current.systemVersion
    var deviceModel = UIDevice.modelName
    var drawerController: KYDrawerController?
    var fcmNotification: FCMNotificationViewModel?
    var controllerTitle = ""
    var requestId = ""
    var isInRide : Bool = false
       var currentNavigationController = ""
       var currentStoryBoard = ""
    var lat : CLLocationDegrees!
    var lng : CLLocationDegrees!
    var date : Date!
       
    
  }

