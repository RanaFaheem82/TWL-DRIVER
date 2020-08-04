//
//  UserViewModel.swift
//  GirlsChase
//
//  Created by Rapidzz Macbook on 14/06/2019.
//  Copyright © 2019 Rapidzz. All rights reserved.
//

import Foundation
import SwiftyJSON


class UserViewModel:NSObject, NSCoding {
    
    var driverId: String
    var name: String
    var cnic: String
    var address: String
    var phoneNumber: String
    var fcmToken: String
    var profileImg: String
   
    
    
    
    override init() {
        self.driverId = ""
        self.name = ""
        self.cnic = ""
        self.phoneNumber = ""
        self.fcmToken = ""
        self.profileImg = ""
        self.address = ""
      
        
    }
    
    convenience init(objUser:JSON){
        self.init()
        let data = objUser["Data"]
        self.driverId = data["_id"].stringValue
        self.name = data["name"].stringValue
        self.cnic = data["cnic"].stringValue
        self.phoneNumber = data["phoneNumber"].stringValue
        self.fcmToken = data["fcmToken"].string ?? ""
        self.profileImg = data["profileImg"].stringValue
        self.address = data["address"].stringValue
       
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        self.init()
      
        self.name = aDecoder.decodeObject(forKey: "name") as?  String ?? ""
        self.driverId = aDecoder.decodeObject(forKey: "driverId")  as?  String ?? ""
        self.cnic = aDecoder.decodeObject(forKey: "cnic") as?  String ?? ""
        self.phoneNumber = aDecoder.decodeObject(forKey: "phoneNumber") as?  String ?? ""
        self.fcmToken = aDecoder.decodeObject(forKey: "fcmToken") as?  String ?? ""
        self.profileImg = aDecoder.decodeObject(forKey: "profileImg")  as?  String ?? ""
         self.address = aDecoder.decodeObject(forKey: "address") as?  String ?? ""
      
        
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name , forKey: "name")
        aCoder.encode(self.driverId, forKey: "driverId")
        aCoder.encode(self.cnic, forKey: "cnic")
        aCoder.encode(self.phoneNumber, forKey: "phoneNumber")
        aCoder.encode(self.fcmToken, forKey: "fcmToken")
        aCoder.encode(self.profileImg, forKey: "profileImg")
        aCoder.encode(self.address, forKey: "address")
    }
}
