//
//  API.swift
//  Zon Bau
//
//  Created by Gulfam Khan on 04/09/2019.
//  Copyright © 2019 AcclivousByte. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class LoginService : BaseService{
    
    //MARK:- Shared data
    private var dataRequest:DataRequest?
    
    //MARK:- Shared Instance
    private override init(){}
    static func shared() -> LoginService {
        return LoginService()
    }
    
    fileprivate var sessionManager:SessionManager {
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 30
        return manager
    }
    
   
    
  
    
    
    //MARK:- Verify Url API
    func verifyUrl(params:Parameters?,completion: @escaping (_ error: String, _ success: Bool)->Void){
        
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
                    
                    if parsedResponse.serviceResponseType == .Success {
                        let data = json[KEY_RESPONSE_DATA]
                        Global.shared.url = data["url"].stringValue
                        UserDefaultsManager.shared.configurationUrl = data["url"].stringValue
                        completion(parsedResponse.message,true)
                    }else {
                        completion(parsedResponse.message,false)
                    }
                    
                case .failure(let error):
                    let errorMessage:String = error.localizedDescription
                    print(errorMessage)
                    completion(errorMessage, false)
                }
            })
        
    }
    //MARK:- Register User API.

    func getuserRegister(params:Parameters?,dict:[String:Data]?,completion: @escaping (_ error: String, _ success: Bool, _ userInfo: UserViewModel?,_ statusType: ServiceResponseType?)->Void){

        let completeURL = EndPoints.BASE_URL + EndPoints.Register
            print("Params \(params!)")
            print("URL \(completeURL)")
        dataRequest = sessionManager.request(completeURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil)

            dataRequest?
                .validate(statusCode: 200...500)
                .responseJSON(completionHandler: { response in
                    switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                        let parsedResponse = ResponseHandler.handleResponse(json)
                        let resType = parsedResponse.serviceResponseType
                        if parsedResponse.serviceResponseType == .Success {
                            print(json)
                            let userInfo = UserViewModel(objUser: parsedResponse.swiftyJsonData!)
    //                        self.saveUserInfo(userInfo)
                            completion(parsedResponse.message,true, userInfo,resType)
                        }else {
                            completion(parsedResponse.message,false,nil,resType)
                        }

                    case .failure(let error):
                        let errorMessage:String = error.localizedDescription
                        print(errorMessage)
                        completion(errorMessage, false , nil, nil)
                    }
                })

        }
    
    //MARK:- Register User API.
       func getUserRegister(params:ParamsString, profileImage:UIImage?, completion: @escaping (_ error: String, _ success: Bool, _ userInfo: UserViewModel?,_ type: ServiceResponseType?)->Void){
           var userInfo : UserViewModel!
           let completeURL = EndPoints.BASE_URL + EndPoints.Register
        var imageDict = [String : Data]()
        let headers = [String : String]()
        if let image = profileImage{
           imageDict = [DictKeys.image:image.jpegData(compressionQuality: 0.8)!]
        }
           self.makePostAPICallWithMultipart(with: completeURL, dict: imageDict, params: params , headers: headers) { (message, success, json , type) in
               if success {
                userInfo = UserViewModel(objUser: json!)
               }
               completion(message,success,userInfo, type)
           }
       }
    func uploadImage(params:ParamsString, profileImage:UIImage?, completion: @escaping (_ error: String, _ success: Bool,_ type: ServiceResponseType? ,_ image : String)->Void){
   
        let completeURL = EndPoints.BASE_URL + EndPoints.upload
     var imageDict = [String : Data]()
     let headers = [String : String]()
     if let image = profileImage{
        imageDict = ["file":image.jpegData(compressionQuality: 0.8)!]
     }
        self.makePostAPICallWithMultipart(with: completeURL, dict: imageDict, params: params , headers: headers) { (message, success, json , type) in
            let imageUrl : String!
            if(success){
              imageUrl = json!["data"].stringValue
            }
            else{
                
                imageUrl = ""
            }
            completion(message,success, type , imageUrl)
        }
    }

    //MARK:- Login user API.
    func getUserLogin(params:Parameters?,completion: @escaping (_ error: String, _ success: Bool, _ UserInfo : UserViewModel?,_ statusType: ServiceResponseType?)->Void){
        
        let completeURL = EndPoints.BASE_URL + EndPoints.login
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
                    if parsedResponse.serviceResponseType == .Success {
                        print(json)
                        let userInfo = UserViewModel(objUser:       parsedResponse.swiftyJsonData!)
                      //  self.saveUserInfo(userInfo)
                        completion(parsedResponse.message,true, userInfo, resType)
                    }else {
                        completion(parsedResponse.message,false, nil ,resType)
                    }
                    
                case .failure(let error):
                    let errorMessage:String = error.localizedDescription
                    print(errorMessage)
                    completion(errorMessage, false,nil, nil)
                }
            })
        
    }
    func forgetPassword(params:Parameters?,completion: @escaping (_ error: String, _ success: Bool,_ statusType: ServiceResponseType?)->Void){
        
        let completeURL = EndPoints.BASE_URL + EndPoints.forgot_password
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
                    if parsedResponse.serviceResponseType == .Success {
                        completion(parsedResponse.message,true,resType)
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
    func makeUserOnline(params:Parameters?,completion: @escaping (_ error: String, _ success: Bool,_ statusType: ServiceResponseType?)->Void){
        
        let completeURL = EndPoints.BASE_URL + EndPoints.online
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
                    if parsedResponse.serviceResponseType == .Success {
                      //  self.saveUserInfo(userInfo)
                        completion(parsedResponse.message,true, resType)
                    }else {
                        completion(parsedResponse.message,false,resType)
                    }
                    
                case .failure(let error):
                    let errorMessage:String = error.localizedDescription
                    print(errorMessage)
                    completion(errorMessage, false,nil)
                }
            })
        
    }
    func getVehicle(params:Parameters?,completion: @escaping (_ error: String, _ success: Bool,_ statusType: ServiceResponseType?,_ list : VehicleListViewModel?)->Void){
        
        let completeURL = EndPoints.BASE_URL + EndPoints.vehicle
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
                    if parsedResponse.serviceResponseType == .Success {
                        let data = parsedResponse.swiftyJsonData
                        let list = VehicleListViewModel(list: data!["Data"])
                      //  self.saveUserInfo(userInfo)
                        completion(parsedResponse.message,true, resType ,list)
                    }else {
                        completion(parsedResponse.message,false,resType , nil)
                    }
                    
                case .failure(let error):
                    let errorMessage:String = error.localizedDescription
                    print(errorMessage)
                    completion(errorMessage, false,nil,nil)
                }
            })
        
    }
    func registerVehicle(params:Parameters?,completion: @escaping (_ error: String, _ success: Bool,_ statusType: ServiceResponseType?)->Void){
           
           let completeURL = EndPoints.BASE_URL + EndPoints.registerVehicle
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
                       if parsedResponse.serviceResponseType == .Success {
                           print(json)
                          
                         //  self.saveUserInfo(userInfo)
                           completion(parsedResponse.message,true, resType)
                       }else {
                           completion(parsedResponse.message,false ,resType)
                       }
                       
                   case .failure(let error):
                       let errorMessage:String = error.localizedDescription
                       print(errorMessage)
                       completion(errorMessage, false, nil)
                   }
               })
           
       }
    func registerDocument(params:Parameters?,completion: @escaping (_ error: String, _ success: Bool,_ statusType: ServiceResponseType?)->Void){
              
              let completeURL = EndPoints.BASE_URL + EndPoints.documents
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
                          if parsedResponse.serviceResponseType == .Success {
                              print(json)
                             
                            //  self.saveUserInfo(userInfo)
                              completion(parsedResponse.message,true, resType)
                          }else {
                              completion(parsedResponse.message,false ,resType)
                          }
                          
                      case .failure(let error):
                          let errorMessage:String = error.localizedDescription
                          print(errorMessage)
                          completion(errorMessage, false, nil)
                      }
                  })
              
          }
    func getuserStatus(params:Parameters?,completion: @escaping (_ error: String, _ success: Bool, _ status: String?,_ statusType: ServiceResponseType?)->Void){

        let completeURL = EndPoints.BASE_URL + EndPoints.onlineStatus
            print("Params \(params!)")
            print("URL \(completeURL)")
        dataRequest = sessionManager.request(completeURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil)

            dataRequest?
                .validate(statusCode: 200...500)
                .responseJSON(completionHandler: { response in
                    switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                        let parsedResponse = ResponseHandler.handleResponse(json)
                        let resType = parsedResponse.serviceResponseType
                        if parsedResponse.serviceResponseType == .Success {
                            print(json)
                            let data = parsedResponse.swiftyJsonData
                            let onlineStatus = data!["driverStatus"].stringValue
    //                        self.saveUserInfo(userInfo)
                            completion(parsedResponse.message,true, onlineStatus ,resType)
                        }else {
                            completion(parsedResponse.message,false,"",resType)
                        }

                    case .failure(let error):
                        let errorMessage:String = error.localizedDescription
                        print(errorMessage)
                        completion(errorMessage, false , "", nil)
                    }
                })

        }
    func acceptRequest(params:Parameters?,completion: @escaping (_ error: String, _ success: Bool, _ statusType: ServiceResponseType?)->Void){

        let completeURL = EndPoints.BASE_URL + EndPoints.accepted
            print("Params \(params!)")
            print("URL \(completeURL)")
        dataRequest = sessionManager.request(completeURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil)

            dataRequest?
                .validate(statusCode: 200...500)
                .responseJSON(completionHandler: { response in
                    switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                        let parsedResponse = ResponseHandler.handleResponse(json)
                        let resType = parsedResponse.serviceResponseType
                        if parsedResponse.serviceResponseType == .Success {
                            print(json)
                            let data = parsedResponse.swiftyJsonData
    //                        self.saveUserInfo(userInfo)
                            completion(parsedResponse.message,true,resType)
                        }else {
                            completion(parsedResponse.message,false,resType)
                        }

                    case .failure(let error):
                        let errorMessage:String = error.localizedDescription
                        print(errorMessage)
                        completion(errorMessage, false , nil)
                    }
                })

        }
    func reachLocation(params:Parameters?,completion: @escaping (_ error: String, _ success: Bool, _ statusType: ServiceResponseType?)->Void){

           let completeURL = EndPoints.BASE_URL + EndPoints.reach
               print("Params \(params!)")
               print("URL \(completeURL)")
           dataRequest = sessionManager.request(completeURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil)

               dataRequest?
                   .validate(statusCode: 200...500)
                   .responseJSON(completionHandler: { response in
                       switch response.result {
                       case .success(let value):
                           let json = JSON(value)
                           let parsedResponse = ResponseHandler.handleResponse(json)
                           let resType = parsedResponse.serviceResponseType
                           if parsedResponse.serviceResponseType == .Success {
                               print(json)
                               let data = parsedResponse.swiftyJsonData
       //                        self.saveUserInfo(userInfo)
                               completion(parsedResponse.message,true,resType)
                           }else {
                               completion(parsedResponse.message,false,resType)
                           }

                       case .failure(let error):
                           let errorMessage:String = error.localizedDescription
                           print(errorMessage)
                           completion(errorMessage, false , nil)
                       }
                   })

           }
    func startRide(params:Parameters?,completion: @escaping (_ error: String, _ success: Bool, _ statusType: ServiceResponseType?)->Void){

              let completeURL = EndPoints.BASE_URL + EndPoints.start
                  print("Params \(params!)")
                  print("URL \(completeURL)")
              dataRequest = sessionManager.request(completeURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil)

                  dataRequest?
                      .validate(statusCode: 200...500)
                      .responseJSON(completionHandler: { response in
                          switch response.result {
                          case .success(let value):
                              let json = JSON(value)
                              let parsedResponse = ResponseHandler.handleResponse(json)
                              let resType = parsedResponse.serviceResponseType
                              if parsedResponse.serviceResponseType == .Success {
                                  print(json)
                                  let data = parsedResponse.swiftyJsonData
          //                        self.saveUserInfo(userInfo)
                                  completion(parsedResponse.message,true,resType)
                              }else {
                                  completion(parsedResponse.message,false,resType)
                              }

                          case .failure(let error):
                              let errorMessage:String = error.localizedDescription
                              print(errorMessage)
                              completion(errorMessage, false , nil)
                          }
                      })

              }
    func endRide(params:Parameters?,completion: @escaping (_ error: String, _ success: Bool, _ statusType: ServiceResponseType?)->Void){

        let completeURL = EndPoints.BASE_URL + EndPoints.end
            print("Params \(params!)")
            print("URL \(completeURL)")
        dataRequest = sessionManager.request(completeURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil)

            dataRequest?
                .validate(statusCode: 200...500)
                .responseJSON(completionHandler: { response in
                    switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                        let parsedResponse = ResponseHandler.handleResponse(json)
                        let resType = parsedResponse.serviceResponseType
                        if parsedResponse.serviceResponseType == .Success {
                            print(json)
                            let data = parsedResponse.swiftyJsonData
    //                        self.saveUserInfo(userInfo)
                            completion(parsedResponse.message,true,resType)
                        }else {
                            completion(parsedResponse.message,false,resType)
                        }

                    case .failure(let error):
                        let errorMessage:String = error.localizedDescription
                        print(errorMessage)
                        completion(errorMessage, false , nil)
                    }
                })

        }
}
