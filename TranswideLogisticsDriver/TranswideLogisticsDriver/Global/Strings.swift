
import Foundation
import UIKit


typealias ParamsAny = [String:Any]
typealias ParamsString = [String:String]

let ALERT_TITLE_APP_NAME = "TRANSWIDE LOGISTICS"
let EMAIL_REGULAR_EXPRESSION = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
let ERROR_NO_NETWORK = "Connection lost. Please check your internet connection and try again."
let NoInternet = "Network error"
let LOGOUT_MESSAGE = "Are you sure you want to logout?"
let REJECT_MESSAGE = "Are you sure you want to reject this booking?"
let CONFIRMATION = "Confirmation"
let YES = "Yes"
let CANCEL = "Cancel"
let EMPTY = ""

struct SideMenu {
    static let MENULIST = [["title":"Home","image":"home1"],["title":"My Order","image":"bag"],["title":"Help","image":"info"],["title":"Settings","image":"setting"],["title":"Notifications","image":"power"],["title":"Logout","image":"power"]]
}
struct APIKeys {
  static let googleApiKey = "AIzaSyBTfypSbx_zNMhWSBXMTA2BJBMQO7_9_T8"
}

struct PublicKey{
    static let publicKey = "10001$804ccb12f3da0baf7353ee586270fbac1f553511cd9c457d45102cf00e3bdc26a50bc93bc1719bc58403a0d6985106363ca4346c92f1a5bbff5001d3ace688f74a86c7b8a3fe9a7bf98c34c785255f62bc4dd65540e5c9210aa927c0b694b7d965193b179a7dc1b4c00e50100a34fab24f791a5c7e9505574c897a97ae63909be5d29629e7fa904777e2ade02aa6497d049b1bce762a6a595efb25a5ab999cd0b730c07aacc24f7129b033b0a4c4b3e968058c6b10316de7532403ae6dd6ac8b8b853e5ce88cac1d01b8ba3f24acb5657db94bd3e10694a23a26803f0b68d1cda7818a7ce4c94fa74b282fd7e5981f0f6e9c29081c6d2d61f570a4cc2ec6b77b"
}
struct MainContainerTitles {
    static let Setting = "Setting"
    static let Notifications = "Notifications"
    static let Profile = "Profile"
    static let FavoriteProducts = "Favorite Products"
    static let Home = "Home"
    static let Product = "Product"
    static let ProductDetails = "Product Details"
    static let ItemList = "Item List"
    static let PlaceOrder = "Place Order"
    static let Suppliers = "Suppliers"
    static let Supplier = "Supplier"
    static let MyOrders =  "MyOrders"
    static let SearchProduct = "Search Product"
    static let ChangePassword = "Change Password"
    static let Help = "Help"
    static let UpdateProfile = "Update Profile"
    
}


struct StoryboardNames {
    static let Main = "Main"
    static let Landing = "Landing"
    static let Register = "Register"
    static let Popup    = "Popup"
}

struct NavigationTitles {
    static let NewJob = "New Job"
}

struct NotificationName {
   static let UpdateBooking = "UpdateBooking"
}

struct AssetNames {
    static let backArrow = "back-1"
    static let logoutIcon = "logout icon"
    static let sideLogo = "sidemenu"
    static let backarrow = "backarrow"
    static let oval = "Oval"
  
}
struct ServiceMessage {
    static let LocationTitle = "Location Service Off"
    static let LocationMessage = "Turn on Location in Settings > Privacy to allow myLUMS to determine your Location"
    static let Settings = "Settings"
    static let CameraTitle = "Permission Denied"
    static let CameraMessage = "Turn on Camera in Settings"
}

struct ControllerIdentifier {
    static let NearbySuppliersViewController = "NearbySuppliersViewController"
    static let HelpViewController = "HelpViewController"
    static let RatingPopupViewController = "RatingPopupViewController"
    static let NotificationsViewController = "NotificationsViewController"
    static let VerfiyNumberViewController = "VerfiyNumberViewController"
    static let SearchPlacesViewController = "SearchPlacesViewController"
    static let LoginViewController = "LoginViewController"
    static let SupplierOrderDetailsViewController = "SupplierOrderDetailsViewController"
    static let SupplierDetailsViewController = "SupplierDetailsViewController"
    static let MyOrdersViewController = "MyOrdersViewController"
    static let KYDrawerController = "KYDrawerController"
    static let SWRevealViewController = "SWRevealViewController"
    static let MainContainerViewController = "MainContainerViewController"
    static let RegisterViewController = "RegisterViewController"
    static let HomeViewController = "HomeViewController"
    static var ProductViewController = "ProductViewController"
    static let ProductDetailViewController = "ProductDetailViewController"
    static let ResetPasswordViewController = "ResetPasswordViewController"
    static let ProfileViewController = "ProfileViewController"
    static let ItemListViewController = "ItemListViewController"
    static let PlaceOrderViewController = "PlaceOrderViewController"
    static let ProfileStatusViewController = "ProfileStatusViewController"
    static let ChangePasswordViewController = "ChangePasswordViewController"
    static let PasswordResetViewController  = "PasswordResetViewController"
    static let PaymentPopUpViewController = "PaymentPopUpViewController"

    
}
struct NevigationControllerIdentifiers{
    static let HomeVC = "HomeVC"
    static let CartVC = "CartVC"
    static let ProductVC = "ProductVC"
    static let MyOrdersVC = "MyOrdersVC"
    static let NotificationVC = "NotificationVC"
    static let HelpVC = "HelpVC"
    static let SettingVC = "SettingVC"
    static let ProfileVC = "ProfileVC"
    static let AddVehicleVC = "AddVehicleVC"
    static let PersonalDocumentVC = "PersonalDocumentVC"
}

struct ValidationMessages {
    static let EmptyCC = "Please Enter Credit Card Number"
    static let EmptyMonth = "Please Enter Month"
    static let EmptyYear = "Please Enter Year"
    static let EmptyCVC = "Please Enter CVC"
    static let EmptyAddress = "Please Enter Your Address"
    static let PlaceOrderSuccessfully = "Order Placed Successfully"
    static let loginSuccessfully = "You are logged in"
    static let EmptyName = "Please enter your username"
    static let EmptyEmail = "Please enter your email"
    static let EnterValidEmail = "Please enter valid email"
    static let EmptyPassword = "Password field cannot be empty"
    static let ShortPassword = "Password must be atleast 6 characters"
    static let ReTypePassword = "Please re-type password"
    static let NonMatchingPassword = "Password is not matching"
    static let ConfigurationUrl = "Please enter configuration url"
    static let ValidUrl = "Please enter valid url"
    static let EmptyPhonNumber = "Please enter phone number"
    static let AddedToCart = "Added To Cart Successfully"
    static let SomeThingWrong = "SomeThingWrong"
    static let EmptyField = "Search Field is Empty"
    static let WrondPinCode = "Please Enter A Valid VerificationCode"
    static let PhoneNumberVerified = "PhoneNumber Verified Successfully"
    static let VerifyNumber = "Please Verify Your Number"
    
}
struct CellIdentifier {
    static let SupplierCartDetails = "SupplierCartDetails"
    static let NearbySuppliersTableViewCell = "NearbySuppliersTableViewCell"
    static let NotificationsTableViewCell = "NotificationsTableViewCell"
    static let PlacesTableViewCell = "PlacesTableViewCell"
    static let SupplierOrderDetailsTableViewCell = "SupplierOrderDetailsTableViewCell"
    static let SupplierDetailsTableViewCell = "SupplierDetailsTableViewCell"
    static let JobTableViewCell = "JobTableViewCell"
    static let SideMenuTableViewCell = "SideMenuTableViewCell"
    static let SideMenuProfileTableViewCell = "SideMenuProfileTableViewCell"
    static let ProductCell = "ProductCell"
    static let fruitsCell = "fruitsCell"
    static let FruitDetailCell = "FruitDetailCell"
    static let ItemCell = "ItemCell"
    static var profileCell = "profileCell"
    static let MyOrdersTableViewCell = "MyOrdersTableViewCell"
}
struct PopupMessages {
    static let  unAuthorizedAccessMessage = "Session Expired Please Login Again"
    static let locationNotFound = "Location Not Found Make Sure Your GPS services is Enable"
    static let EmptyEmail =  "Please Enter Your Email"
    static let warning = "Warning"
    static let verification = "Verification Code Sent Again Successfully"
    static let sureToLogout = "Are you sure to logout"
    static let nothingToUpdate = "Nothing to update"
    static let cameraPermissionNeeded = "Camera permission needed to scan QR Code. Goto settings to enable camera permission"
    static let SomethingWentWrong = "SomethingWentWrong"
    static let cantSendMessage = "Cannot Send Message Please Try again later"
}

struct LocalStrings {
    static let emptyCart = "No item in cart"
    static let success = "Success"
    static let ok = "OK"
    static let Yes = "Yes"
    static let No = "No"
    static let Cancel = "Cancel"
    static let Camera = "Camera"
    static let NoDataFound = "No data found"
    static let EnterUsername = "Enter Username"
    static let EnterEmail = "Enter Email"
    static let EmptySubject = "Subject is Empty"
    static let EmptyMessage = "Please Enter Message"
    
}

struct AppFonts {
    static func CenturyGolthicBoldWith(size : CGFloat) -> UIFont {
        
        if let font = UIFont(name: "Century Gothic Bold", size: size) {
            return font
        }
        else {
            return UIFont.systemFont(ofSize: size)
        }
    }
    static func CenturyGolthicRegularWith(size : CGFloat) -> UIFont {
        
        if let font = UIFont(name: "Century Gothic Regular", size: size) {
            return font
        }
        else {
            return UIFont.systemFont(ofSize: size)
        }
    }
}
struct ApplicationColor{
    static let LightGray = UIColor.init(hexFromString: "0x969696", alpha: 0.61)
    static let LightBlue = UIColor.init(hexFromString: "0x093485", alpha: 0.61)//.init(hexFromString: "0x093485")
    static let Gray = UIColor.init(hexFromString: "0x969696")
    static let DarkBlue = UIColor.init(hexFromString: "0x093485")
}
