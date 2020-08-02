//
//  BookingService.swift
//  HprDriver
//
//  Created by Rapidzz Macbook on 07/01/2020.
//  Copyright © 2020 Rapidzz. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class BookingService {
     
    private var dataRequest: DataRequest?
    
    private init(){}
    
    static func shared() -> BookingService{
        return BookingService()
    }
    
    private var sessionManager: SessionManager{
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 30
        return manager
    }
    
    
    //MARK:- Booking Service API
    func getBookings(params:Parameters?,completion: @escaping (_ message: String, _ success: Bool, _ list: BookingListViewModel?,_ statusType: ServiceResponseType?)->Void){
        
        let completeURL = EndPoints.BASE_URL
        print("Params \(params!)")
        print("URL \(completeURL)")
        dataRequest = sessionManager.request(completeURL, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil)
        
        dataRequest?
            .validate(statusCode: 200...500)
            .responseJSON(completionHandler: { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let parsedResponse = ResponseHandler.handleResponse(json)
                    let resType = parsedResponse.serviceResponseType
                    if resType == .Success {
                        let list = BookingListViewModel(data: parsedResponse.swiftyJsonData!)
                        completion(parsedResponse.message,true,list, resType)
                    }else if(resType == .Expired) {
                        completion(parsedResponse.message,false, nil, resType)
                    }else{
                        completion(parsedResponse.message,false, nil,resType)
                    }
                    
                case .failure(let error):
                    let errorMessage:String = error.localizedDescription
                    print(errorMessage)
                    completion(errorMessage, false, nil,nil)
                }
            })
        
    }
    
}
