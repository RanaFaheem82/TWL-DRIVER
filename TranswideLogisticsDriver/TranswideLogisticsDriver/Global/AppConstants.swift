import Foundation
import UIKit
struct ScreenSize
{
    static let SCREEN_WIDTH = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}
struct DeviceType
{
    static let IS_IPHONE_4_OR_LESS =  UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    
    static let IS_IPHONE_5 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_6 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_6P = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
    static let IS_IPHONE_X_All = (UIDevice.current.userInterfaceIdiom == .phone && (ScreenSize.SCREEN_MAX_LENGTH == 812 || ScreenSize.SCREEN_MAX_LENGTH == 896))
    static let IS_IPHONE_X = (UIDevice.current.userInterfaceIdiom == .phone && (ScreenSize.SCREEN_MAX_LENGTH == 812))
    static let IS_IPHONE_X_MAX = (UIDevice.current.userInterfaceIdiom == .phone && (ScreenSize.SCREEN_MAX_LENGTH == 896))
    static let IS_IPAD = UIDevice.current.userInterfaceIdiom == .pad
}

struct DictKeys{
    static let accept = "Accept"
    static let supplierId = "supplier_id"
    static let lat = "lat"
    static let lng = "lng"
    static let urlKey = ""
    static let formattedAddress = "formatted_address"
    static let results = "results"
    static let notificationStatus = "notification_status"
    static let description = "description"
    static let subject = "subject"
    static let notificationId        = "notification_id"
    static let comments             = "comments"
    static let rating               = "rating"
    static let page                  = "page"
    static let address                = "address"
    static let OrderId             = "order_id"
    static let apiUrl               = "apiurl"
    static let session              = "session"
    static let username             = "username"
    static let password             = "password"
    static let deviceToken          = "device_token"
    static let osVersion            = "os_version"
    static let deviceModel          = "device_model"
    static let os                   = "os"
    static let sessionId            = "session_id"
    static let offset               = "offset"
    static let limit                = "limit"
    static let status               = "status"
    static let bookingType          = "booking_type"
    static let bookingRef           = "booking_ref"
    static let email                = "email"
    static let fcmToken             = "fcm_token"
    static let categoryId           = "category_id"
    static let userId               = "user_id"
    static let name                 = "name"
    static let productid            = "product_id"
    static let isfavourite          = "is_favourite"
    static let Accept               = "Accept"
    static let Authorization        = "Authorization"
    static let ProductName          = "product_name"
    static let quantity             = "quantity"
    static let phoneNum             = "phone_num"
    static let image                = "image"
    static let pincode              = "pincode"
    static let ConfirmPassword      = "c_password"
    static let oldPassword          = "old_password"
    static let newPassword          = "new_password"
    static let creditCard           = "encryptedCardNumber"
    static let cvc                  = "encryptedSecurityCode"
    static let expiryMonth          = "expirationMonth"
    static let expiryYear           = "expirationYear"
    static let amount               = "amount"
    static let suppliers            = "suppliers"
    static let supID                = "sup_id"
    static let supTotal             = "sup_total"
    
    
}
struct TokenStartPoint{
    static let Bearer                 = "Bearer "
}

struct EndPoints {
    static let applicationJson = "application/json"
    static let createAuthCapture = "create-auth-capture"
    static let nearbySuppliers = "near-by"
    static let supplierProduct = "get-supplier-products"
    static let notificationSetting = "notification-enabled-disabled"
    static let addMessage = "add-message"
    static let ratingNotification = "rating-notification"
    static let completeNotification = "complete-notification"
    static let logout       = "logout"
    static let newPassword   = "new-password"
    static let getFavouritelist       = "get-favourite-list"
    static let remove_favourite         = "remove-favourite"
    static let BASE_URL                 = "http://9bef1412ae23.ngrok.io/"
    //static let BASE_URL                 = "http://mashghol.com/tawrid/public/api/"
    //static let logout                   = "\(Global.shared.url)/driverapi/logout"
    static let login                    = "driver/login"
    static let Register                 = "driver/signup"
    static let update_fcm_tocken        = "update_fcm_token"
    static let forgot_password          = "forget-password"
    static let update_profile           = "update_profile"
    static let allCategoryProducts      = "all-category"
    static let allProducts              = "all-products"
    static let place_order              = "place-order"
    static let add_favourite            = "add-favourite"
    static let orderList                = "order-list"
    static let subOrderList             = "sub-order-list"
    static let searchProduct            = "search-products"
    static let profileUpdate            = "profile-update"
    static let changePassword           = "change-password"
    static let online = "available"
    static let vehicle = "vehicle/getVehicle"
    static let upload = "upload"
    static let registerVehicle = "vehicle"
    static let documents = "documents"
    static let onlineStatus = "available/status"
    
    
    
    
    //    static let getBookingHistory        = "\(Global.shared.url)/driverapi/getBookingHistory"
    //    static let changeStatus             = 
    
}

//Default values for data types
let kBlankString = ""
let Plateform = "IOS"
let DeviceToken = "21321312"

let kInt0 = 0
let kIntDefault = -1

let kDouble0 = 0.0
let kDoubleDefault = -1.0

let kFileTypePDF = "pdf"
let kFileTypeJpeg = "jpeg"

let kMimeTypeImage = "image/png"
let kImageFileName = "file.png"

let kMimeTypePDF = "application/pdf"
let kPDFFileName = "document.pdf"
let currency = "AED"


