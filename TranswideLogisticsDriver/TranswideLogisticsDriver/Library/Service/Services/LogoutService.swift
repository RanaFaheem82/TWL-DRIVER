//
//  LogoutService.swift
//  HprDriver
//
//  Created by Rapidzz Macbook on 07/01/2020.
//  Copyright © 2020 Rapidzz. All rights reserved.
//

import Alamofire
import Foundation
import SwiftyJSON

class LogoutService {
    
    private var dataRequest: DataRequest?
    
    private init(){}
    static func shared() -> LogoutService{
        return LogoutService()
    }
    
    private var sessionManager: SessionManager{
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 30
        return manager
    }
    
    //MARK:- Logout user API
    func getUserLogout(params:Parameters?,completion: @escaping (_ message: String, _ success: Bool ,_ statusType: ServiceResponseType?)->Void){
           
        let completeURL = EndPoints.BASE_URL + EndPoints.logout
           print("Params \(params!)")
           print("URL \(completeURL)")
        let headers : HTTPHeaders = ["" : ""]
           dataRequest = sessionManager.request(completeURL, method: .post, parameters: params, encoding: URLEncoding.default, headers: headers)
           
           dataRequest?
               .validate(statusCode: 200...500)
               .responseJSON(completionHandler: { response in
                   switch response.result {
                   case .success(let value):
                       let json = JSON(value)
                       let parsedResponse = ResponseHandler.handleResponse(json)
                        let resType = parsedResponse.serviceResponseType
                       if parsedResponse.serviceResponseType == .Success {
                           completion(parsedResponse.message,true, resType)
                       }else {
                           completion(parsedResponse.message,false, resType)
                       }
                       
                   case .failure(let error):
                       let errorMessage:String = error.localizedDescription
                       print(errorMessage)
                       completion(errorMessage, false, nil)
                   }
               })
           
       }
}
