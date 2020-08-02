//
//  BookingViewModel.swift
//  HprDriver
//
//  Created by Rapidzz Macbook on 07/01/2020.
//  Copyright © 2020 Rapidzz. All rights reserved.
//

import Foundation
import SwiftyJSON

class BookingViewModel {
    
    var flight: String
    var bookingTerminal: String
    var bookingTerminalReturn: String
    var bookingDatestamp: String
    var noOfPeople: String
    var noOfBags: String
    var loginName: String
    var loginMobile: String
    var bookingRef: String
    var bookingFrom: String
    var bookingTo: String
    var bookingType: BookingType
    var bookingStatus: BookingStatus
    var isNewBooking: Bool
    init() {
        self.flight = ""
        self.bookingTerminal = ""
        self.bookingTerminalReturn = ""
        self.bookingDatestamp = ""
        self.noOfPeople = ""
        self.noOfBags = ""
        self.loginName = ""
        self.loginMobile = ""
        self.bookingRef = ""
        self.bookingFrom = ""
        self.bookingTo = ""
        self.bookingType = .Departure
        self.bookingStatus = .Arrived
        self.isNewBooking = false
    }
    
    init(booking: JSON) {
        self.isNewBooking = false
        self.flight = booking["flight"].string ?? ""
        self.bookingTerminal = booking["booking_terminal"].string ?? ""
        self.bookingTerminalReturn = booking["booking_terminal_return"].string ?? ""
        self.bookingDatestamp = booking["booking_quote_datestamp"].string ?? ""
        self.noOfPeople = booking["no_of_people"].string ?? "0"
        self.noOfBags = booking["no_of_bags"].string ?? "0"
        self.loginName = booking["login_name"].string ?? ""
        self.loginMobile = booking["login_mobile"].string ?? ""
        self.bookingRef = booking["booking_ref"].string ?? ""
        self.bookingFrom = booking["booking_from"].string ?? ""
        self.bookingTo = booking["booking_to"].string ?? ""
        let type = (booking["booking_type"].string ?? "").trimmingCharacters(in: .whitespaces).lowercased()
        let status = (booking["booking_status"].string ?? "").trimmingCharacters(in: .whitespaces).lowercased()
        
        if(type == BookingType.Departure.rawValue){
            self.bookingType = .Departure
        }else{
            self.bookingType = .Return
        }
        
        
        if(status == BookingStatus.Assigned.rawValue){
            self.bookingStatus = .Assigned
        }else if(status == BookingStatus.Completed.rawValue){
            self.bookingStatus = .Completed
        }else if(status == BookingStatus.POB.rawValue){
            self.bookingStatus = .POB
        }else if(status == "reject"){
            self.bookingStatus = .Rejected
        }else if(status == BookingStatus.Rejected.rawValue){
            self.bookingStatus = .Rejected
        }else{
            self.bookingStatus = .Arrived
        }
        
        if let fcm = Global.shared.fcmNotification{
            if(fcm.bookingRef.lowercased() == self.bookingRef.lowercased()){
                self.isNewBooking = true
            }
        }
    }
    
    
}
