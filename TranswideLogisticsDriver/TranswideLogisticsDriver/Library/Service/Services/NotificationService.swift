

import Foundation
import SwiftyJSON
import Alamofire

class NotificationService {
     
    private var dataRequest: DataRequest?
    
    private init(){}
    
    static func shared() -> NotificationService{
        return NotificationService()
    }
    
    
    private var sessionManager: SessionManager{
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 30
        return manager
    }
    
    
    //MARK:- All notifications Service API
    func getAllNotifications(params:Parameters?,completion: @escaping (_ message: String, _ success: Bool, _ list: NotificationListViewModel?,_ statusType: ServiceResponseType?)->Void){
        
        let completeURL = EndPoints.BASE_URL + EndPoints.completeNotification
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
                        let list = NotificationListViewModel(list: parsedResponse.swiftyJsonData!)
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
    
    //MARK:- Rating Service API
       func GiveRating(params:Parameters?,completion: @escaping (_ message: String, _ success: Bool,_ statusType: ServiceResponseType?)->Void){
           
        let completeURL = EndPoints.BASE_URL + EndPoints.ratingNotification
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
                           completion(parsedResponse.message,true, resType)
                       }else if(resType == .Expired) {
                           completion(parsedResponse.message,false, resType)
                       }else{
                           completion(parsedResponse.message,false, resType)
                       }
                   case .failure(let error):
                       let errorMessage:String = error.localizedDescription
                       print(errorMessage)
                       completion(errorMessage, false, nil)
                   }
               })
           
       }
    //MARK:- Enable and Disable Service API
    func NotificationSetting(params:Parameters?,completion: @escaping (_ message: String, _ success: Bool,_ statusType: ServiceResponseType?)->Void){
        
     let completeURL = EndPoints.BASE_URL + EndPoints.notificationSetting
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
                        completion(parsedResponse.message,true, resType)
                    }else if(resType == .Expired) {
                        completion(parsedResponse.message,false, resType)
                    }else{
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
