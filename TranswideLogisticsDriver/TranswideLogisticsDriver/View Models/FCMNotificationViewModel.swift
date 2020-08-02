//
//  FCMNotificationViewModel.swift
//  Fooding
//
//  Created by Ghafar Tanveer on 18/08/2017.
//  Copyright © 2017 Ghafar Tanveer. All rights reserved.
//

import Foundation
import SwiftyJSON

class FCMNotificationViewModel {
    
    var message:String
    var bookingRef:String
    var isPlainText:Bool
    
    init() {
        self.message = ""
        self.bookingRef = ""
        self.isPlainText = false
    }
    /*
    [AnyHashable("image"): this is image, AnyHashable("google.c.a.e"): 1, AnyHashable("notification_type"): text, AnyHashable("aps"): {
        alert =     {
            body = "Faisal Here Testing";
            title = "this is title";
        };
    }, AnyHashable("gcm.message_id"): 1578658593998774, AnyHashable("message"): testing text notification]
    
    
    [AnyHashable("google.c.a.e"): 1, AnyHashable("image"): this is image, AnyHashable("booking_ref"): AP-19120359906, AnyHashable("message"): New Booking Assigned, AnyHashable("gcm.message_id"): 1578658983497400, AnyHashable("notification_type"): booking, AnyHashable("aps"): {
        alert =     {
            body = "Body Of Msg";
            title = "this is title";
        };
    }]
    */
    convenience init(notification:[AnyHashable:Any]) {
        self.init()
        
        let json = JSON(notification)
        let type = json["notification_type"].string ?? ""
        self.bookingRef = json["booking_ref"].string ?? ""
        self.message = json["message"].string ?? ""
        if(type.lowercased() == "text"){
            self.isPlainText = true
        }
       

    }
    
}
