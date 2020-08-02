//
//  RegisterViewModel.swift
//  Tawrid
//
//  Created by Rizwan Ali on 28/01/2020.
//  Copyright © 2020 Rapidzz. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
class RegisterViewModel {
    var image: String
    var name: String
    var email: String
    var phoneNumber: String
    var passowrd: String
    var reTypePassword: String
    
    init() {
        self.image = ""
        self.name = ""
        self.email = ""
        self.phoneNumber = ""
        self.passowrd = ""
        self.reTypePassword = ""
    }
    
    init(register: JSON) {
        self.image = register["image"].stringValue
        self.name = register["name"].stringValue
        self.email = register["email"].stringValue
        self.phoneNumber = register["phoneNumber"].stringValue
        self.passowrd = register["passowrd"].stringValue
        self.reTypePassword = register["reTypePassword"].stringValue
    }
    
}
