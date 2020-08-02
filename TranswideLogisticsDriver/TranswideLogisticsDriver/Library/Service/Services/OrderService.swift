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

class OrderService {
     
    private var dataRequest: DataRequest?
    
    private init(){}
    
    static func shared() -> OrderService{
        return OrderService()
    }
    
    private var sessionManager: SessionManager{
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 30
        return manager
    }
    
    
    //MARK:- Place Order Service API
    func placeOrder(params:Parameters?,completion: @escaping (_ message: String, _ success: Bool,_ statusType: ServiceResponseType?)->Void){
        
        let completeURL = EndPoints.BASE_URL + EndPoints.place_order
        let headers : HTTPHeaders = [DictKeys.Authorization: TokenStartPoint.Bearer + Global.shared.user!.token, DictKeys.accept : EndPoints.applicationJson]
        print("Params \(params!)")
        print("URL \(completeURL)")
        print("header \(headers)")
        dataRequest = sessionManager.request(completeURL, method: .post, parameters: params!, encoding: JSONEncoding.default, headers: headers)
        
        dataRequest?
            .validate(statusCode: 200...500)
            .responseJSON(completionHandler: { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let parsedResponse = ResponseHandler.handleResponse(json)
                    let resType = parsedResponse.serviceResponseType
                    if resType == .Success {
                         print(json)
                        completion(parsedResponse.message,true, resType)
                    }else if(resType == .Expired) {
                        completion(parsedResponse.message,false,resType)
                    }else{
                        completion(parsedResponse.message,false,resType)
                    }
                    
                case .failure(let error):
                    let errorMessage:String = error.localizedDescription
                    print(errorMessage)
                    completion(errorMessage, false,nil)
                }
            })
        
    }
    //MARK:- getOrderList Service API
    func getOrderList(params:Parameters?,completion: @escaping (_ message: String, _ success: Bool, _ list: OrderViewModel?,_ statusType: ServiceResponseType?)->Void){
        
        let completeURL = EndPoints.BASE_URL + EndPoints.orderList
        let headers : HTTPHeaders = [DictKeys.Authorization: TokenStartPoint.Bearer + Global.shared.user!.token, DictKeys.accept : EndPoints.applicationJson ]
        print("Params \(params!)")
        print("URL \(completeURL)")
        dataRequest = sessionManager.request(completeURL, method: .get, parameters: params, encoding: URLEncoding.default, headers: headers)
        
        dataRequest?
            .validate(statusCode: 200...500)
            .responseJSON(completionHandler: { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    print(json)
                    let parsedResponse = ResponseHandler.handleResponse(json)
                    let resType = parsedResponse.serviceResponseType
                    if resType == .Success {
                        
                        let data = parsedResponse.swiftyJsonData!
                        let list = OrderViewModel(data: data["data"])
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
    //MARK:- getSubOrderList Service API
    func getSubOrderList(params:Parameters?,completion: @escaping (_ message: String, _ success: Bool, _ list: SubOrderListViewModel?,_ statusType: ServiceResponseType?)->Void){
        
        let completeURL = EndPoints.BASE_URL + EndPoints.subOrderList
        let headers : HTTPHeaders = [DictKeys.Authorization: TokenStartPoint.Bearer + Global.shared.user!.token , DictKeys.accept : EndPoints.applicationJson]
        print("Params \(params!)")
        print("URL \(completeURL)")
        dataRequest = sessionManager.request(completeURL, method: .post, parameters: params, encoding: URLEncoding.default, headers: headers)
        
        dataRequest?
            .validate(statusCode: 200...500)
            .responseJSON(completionHandler: { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    print(json)
                    let parsedResponse = ResponseHandler.handleResponse(json)
                    let resType = parsedResponse.serviceResponseType
                    if resType == .Success {
                        
                      //  let data = parsedResponse.swiftyJsonData!
                        let list = SubOrderListViewModel(list: parsedResponse.swiftyJsonData!)
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
    //MARK:- Payment Service API
       func Payment(params:Parameters?,completion: @escaping (_ message: String, _ success: Bool,_ statusType: ServiceResponseType?,_ id: String)->Void){
           
        let completeURL = EndPoints.BASE_URL + EndPoints.createAuthCapture
           let headers : HTTPHeaders = [DictKeys.Authorization: TokenStartPoint.Bearer + Global.shared.user!.token, DictKeys.accept : EndPoints.applicationJson]
           var transactionId : String = ""
           print("Params \(params!)")
           print("URL \(completeURL)")
           print("header \(headers)")
           dataRequest = sessionManager.request(completeURL, method: .post, parameters: params!, encoding: JSONEncoding.default, headers: headers)
           
           dataRequest?
               .validate(statusCode: 200...500)
               .responseJSON(completionHandler: { response in
                   switch response.result {
                   case .success(let value):
                       let json = JSON(value)
                       let parsedResponse = ResponseHandler.handleResponse(json)
                       let resType = parsedResponse.serviceResponseType
                       if resType == .Success {
                            let data = parsedResponse.swiftyJsonData!
                        transactionId = data["data"]["transactionId"].stringValue
                            print(json)
                           completion(parsedResponse.message,true, resType,transactionId)
                       }else if(resType == .Expired) {
                           completion(parsedResponse.message,false,resType,transactionId)
                       }else{
                           completion(parsedResponse.message,false,resType,transactionId)
                       }
                       
                   case .failure(let error):
                       let errorMessage:String = error.localizedDescription
                       print(errorMessage)
                       completion(errorMessage, false,nil,"")
                   }
               })
           
       }
    
}
