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

class HomeCategoryProductsService {
     
    private var dataRequest: DataRequest?
    
    private init(){}
    
    static func shared() -> HomeCategoryProductsService{
        return HomeCategoryProductsService()
    }
    
    
    private var sessionManager: SessionManager{
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 30
        return manager
    }
    
    
    //MARK:- AllProductsCategory Service API
    func getAllCategories(params:Parameters?,completion: @escaping (_ message: String, _ success: Bool, _ list: CategoryProductListViewModel?,_ statusType: ServiceResponseType?)->Void){
        
        let completeURL = EndPoints.BASE_URL + EndPoints.allCategoryProducts
        let headers : HTTPHeaders = [DictKeys.Authorization: TokenStartPoint.Bearer + Global.shared.user!.token , DictKeys.accept : EndPoints.applicationJson]
        print("Params \(params!)")
        print("URL \(completeURL)")
        print("Heder \(headers)")
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
                        let list = CategoryProductListViewModel(list: parsedResponse.swiftyJsonData!)
                        completion(parsedResponse.message,true,list, resType)
                    }else if(resType == .Expired) {
                        completion(parsedResponse.message,false, nil, resType)
                    }else{
                        completion(parsedResponse.message,false, nil,resType)
                    }
                    
                case .failure(let error):
                    let errorMessage:String = error.localizedDescription
                    print(errorMessage)
                    completion(errorMessage, false, nil,.Failure)
                }
            })
        
    }
    //MARK:- getNearbySuppliers Service API
       func getNearbySuppliers(params:Parameters?,completion: @escaping (_ message: String, _ success: Bool, _ list: SupplierListViewModel?,_ statusType: ServiceResponseType?)->Void){
           
           let completeURL = EndPoints.BASE_URL + EndPoints.nearbySuppliers
           let headers : HTTPHeaders = [DictKeys.Authorization: TokenStartPoint.Bearer + Global.shared.user!.token , DictKeys.accept : EndPoints.applicationJson]
           print("Params \(params!)")
           print("URL \(completeURL)")
           print("Heder \(headers)")
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
                           let list = SupplierListViewModel(list: parsedResponse.swiftyJsonData!)
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
