//
//  StatusService.swift
//  HprDriver
//
//  Created by Rapidzz Macbook on 07/01/2020.
//  Copyright © 2020 Rapidzz. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class StatusService {
    
    private var dataRequest: DataRequest?
    
    private init(){}
    
    static func shared() -> StatusService{
        return StatusService()
    }
    
    private var sessionManager: SessionManager{
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 30
        return manager
    }
   
    //MARK:- Change Status API
    func changeStatus(params:Parameters?,completion: @escaping (_ error: String, _ success: Bool, _ type: ServiceResponseType?)->Void){

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
                        completion(parsedResponse.message,true, resType)
                    }else if(resType == .Expired) {
                        completion(parsedResponse.message,false, resType)
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
