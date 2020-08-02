//
//  BookingListViewModel.swift
//  HprDriver
//
//  Created by Rapidzz Macbook on 07/01/2020.
//  Copyright © 2020 Rapidzz. All rights reserved.
//

import Foundation
import SwiftyJSON

class BookingListViewModel {
    
    var bookingList: [BookingViewModel]
    
    init() {
        self.bookingList = [BookingViewModel]()
    }
    
    init(data: JSON) {
        self.bookingList = [BookingViewModel]()
        if let list  = data["customerdata"].array{
            for item in list{
                let booking = BookingViewModel(booking: item)
                if(booking.bookingStatus != .Completed && booking.bookingStatus != .Rejected){
                    self.bookingList.append(BookingViewModel(booking: item))
                }
            }
        }
    }
    
    func addBookings(list: [BookingViewModel]) {
        for item in list{
            if(item.bookingStatus != .Completed && item.bookingStatus != .Rejected){
                self.bookingList.append(item)
            }
        }
    }
    
}
