import UIKit
import Foundation


struct AppColors {
    static let PinkColor = UIColor(rgbValues: 242, green: 0, blue: 80, alpha: 1)
    static let LightPurpleColor = UIColor(rgbValues: 200, green: 194, blue: 222, alpha: 1)
    
}


enum BookingStatus: String {
    case Assigned =  "assigned"
    case Arrived = "arrived"
    case Completed = "completed"
    case Rejected = "reject"
    case POB = "pob"
}
enum BookingType: String {
    case Return =  "return"
    case Departure = "departure"
}


enum NavigationControllerNames : String {
    case HOMEVC
    case EARNINGVC
    case TRIPVC
    case GIGVC
    case DELERYVC
    case JOBVC
    case ReviewVC
    case profileVC
    case AboutUsVC
    case GetInTouchVC
    case ProfileVC
    var rawValue : String {
        switch self {
        case .HOMEVC:
            return "HomeVC"
        case .EARNINGVC :
            return "EarningNavigationController"
        case .TRIPVC :
            return "BaseTripViewController"
        case .GIGVC :
            return "GigVC"
        case .DELERYVC :
            return "DELIVERYVC"
        case .JOBVC :
            return "JOBVC"
        case .ReviewVC :
            return "ReviewVC"
        case .profileVC :
            return "profileVC"
        case .AboutUsVC :
            return "AboutUsVC"
        case .GetInTouchVC :
            return "GetInTouch"
        case .ProfileVC :
            return "ProfileVC"

        }
      
        
        
        
    }
    
    
}


enum StoryBoardNames : String {
    case MAIN
    case HOME
    case Register
    var rawValue : String {
        switch self {
        case .MAIN:
            return "Main"
        case .HOME :
            return "Home"
        case .Register:
            return "Register"
        }
        
        
    }
    
}
