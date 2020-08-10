//
//  HomeViewController.swift
//  TranswideLogisticsDriver
//
//  Created by apple on 5/2/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import Alamofire
import Firebase

class HomeViewController: BaseViewController ,CLLocationManagerDelegate , GMSMapViewDelegate , AddVehicleViewControllerDelegate{
   
    
    @IBOutlet weak var lblSeprator: UILabel!
    @IBOutlet weak var btnReached: UIButton!
    @IBOutlet weak var btnChat: UIButton!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var lblAddress: UILabel!
    var locationManager = CLLocationManager()
       var currentLocation: CLLocation?
       //  var mapView: GMSMapView!
       var marker = GMSMarker()
       var placesClient: GMSPlacesClient!
       var zoomLevel: Float = 15.0
        var database : DatabaseReference!
    var isFromNotification : Bool = false
    var lat : CLLocationDegrees!
    var lng : CLLocationDegrees!
    var status : String = ""
    var isReach = false
    var isStart = false
    
    
    @IBOutlet weak var btnGoOnline: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        if(!isFromNotification){
            self.lblSeprator.isHidden = true
            self.btnChat.isHidden = true
            self.btnReached.isHidden = true
        let params : ParamsAny = ["driverId" : Global.shared.user!.driverId]
        self.getUserStatus(params: params)
        }
        
        database = Database.database().reference()
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        self.mapView.delegate = self
        placesClient = GMSPlacesClient.shared()
        if(isFromNotification){
            self.lblSeprator.isHidden = false
            self.btnChat.isHidden = false
            self.btnReached.isHidden = false
            self.btnGoOnline.isHidden = true
        }
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
          self.mainContainer?.setTitle(title: MainContainerTitles.Home)
          self.mainContainer?.setMenuButton()
        if(Global.shared.isInRide){
            self.isFromNotification = true
        }
        else{
            self.isFromNotification = false
            
        }
          
      }
    
    @IBAction func actionChat(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
        vc.otherUserId = Global.shared.requestId
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func actionReachedLocation(_ sender: Any) {
        
        if(self.isStart){
            let params : ParamsAny = ["driverId" : Global.shared.user!.driverId,"userId": Global.shared.requestId,"fare":"5000"]
            self.endRide(params: params)
        }
        else if(self.isReach){
            let params : ParamsAny = ["userId" : Global.shared.requestId]
            self.startRide(params: params)
        }
        
        else{
            let params : ParamsAny = ["userId" : Global.shared.requestId]
        self.reached(params: params)
      }
    }
    
    @IBAction func actionGoOnline(_ sender: Any) {
        if(status == "false"){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddVehicleViewController") as! AddVehicleViewController
        vc.delegate = self
        vc.isFromHome = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
        else{
            let params : ParamsAny = ["driverId" : Global.shared.user!.driverId, "isAvailable" : "false"]
            self.getUserOnline(params: params)
        }
    }
    
    func selectVehicle(vehicle: VehicleViewModel) {
        Global.shared.vehicle = vehicle
        self.navigationController?.popViewController(animated: true)
        let params : ParamsAny = ["driverId" : Global.shared.user!.driverId , "regNo" : vehicle.number , "longitude" :  self.lng! ,"latitude" : self.lat! , "isAvailable" : "true"]
               self.getUserOnline(params: params)
       }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
//MARK: LOCATION MENEGAR METHODS.
extension HomeViewController{
    
    func getAddressFromLatLong(latitude: Double, longitude : Double) {
        let url = self.getUrl(lat: latitude, lng: longitude)
        print(url)
        Alamofire.request(url).validate().responseJSON { response in
            switch response.result {
            case .success:
                
                let responseJson = response.value as! NSDictionary
                
                if let results = responseJson.object(forKey: DictKeys.results)! as? [NSDictionary] {
                    if results.count > 0 {
                        let address = results[0][DictKeys.formattedAddress] as? String
                        self.lblAddress.text = address!
                        self.showMarker(position: self.mapView.camera.target)
                    }
                }
            case .failure(_):
                self.showAlertView(message: PopupMessages.locationNotFound)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location: CLLocation = manager.location!
        self.getAddressFromLatLong(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let userLocation:CLLocation = locations[0] as CLLocation
        self.lat = userLocation.coordinate.latitude
        self.lng = userLocation.coordinate.longitude
        let camera = GMSCameraPosition.camera(withLatitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude, zoom: 15.0)
        mapView.camera = camera
        if(isFromNotification){ self.database.child("rides").child(Global.shared.requestId).setValue(["lat" : userLocation.coordinate.latitude ,"lng" : userLocation.coordinate.longitude , "status" : "accepted" , "name" : Global.shared.user!.name , "Rating" : "4.5 stars" , "vehicleName" : Global.shared.vehicle!.name , "vehicleNumber" : Global.shared.vehicle!.number ,"vehicleColor" : Global.shared.vehicle!.color , "driverId" : Global.shared.user!.driverId])
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        //self.showAlertView(message: error as! String)
    }
    
    func showMarker(position : CLLocationCoordinate2D ){
        marker.position = position
        marker.map = mapView
        marker.isDraggable = true
    }
}


extension HomeViewController{
    func getUserOnline(params : ParamsAny){
        self.startActivity()
               GCD.async(.Background){
        LoginService.shared().makeUserOnline(params: params) { (message, success, response) in
            GCD.async(.Main){
                self.stopActivity()
            if(success){
                if(self.status == "true"){
                    self.status = "false"
                    self.btnGoOnline.setTitle("GO", for: .normal)
                    self.showAlertView(message: "You are now offline")
                    
                }
                else{
                    self.status = "true"
                     self.btnGoOnline.setTitle("OFF", for: .normal)
                    self.showAlertView(message: "You are now online")
                }
                
            }
            else{
                self.showAlertView(message: "error")
            }
        }
    }
        }
    }
    func getUserStatus(params : ParamsAny){
        self.startActivity()
        GCD.async(.Background){
          LoginService.shared().getuserStatus(params: params) { (message, success,status, response) in
              GCD.async(.Main){
                                              self.stopActivity()
            if(success){
                self.status = status!
                if(status == "true"){
                    self.btnGoOnline.setTitle("OFF", for: .normal)
                    self.showAlertView(message: "You are now online")
                }
                else{
                     self.btnGoOnline.setTitle("GO", for: .normal)
                      self.showAlertView(message: "You are now offline")
                }
                
              }
              else{
                  self.showAlertView(message: "error")
              }
          }
    }
}
      }
    
    func reached(params : ParamsAny){
        self.startActivity()
                            GCD.async(.Background){
        LoginService.shared().reachLocation(params: params) { (message, success, response) in
          GCD.async(.Main){
                                   self.stopActivity()
            if(success){
                self.isReach = true
                self.btnReached.setTitle("Start Shipment", for: .normal)
            }
            else{
                print("faliure")
            }
        }
    }
        }
    }
    func startRide(params : ParamsAny){
        self.startActivity()
                     GCD.async(.Background){
        LoginService.shared().startRide(params: params) { (message, success, response) in
           GCD.async(.Main){
                          self.stopActivity()
            if(success){
                self.isReach = false
                self.isStart = true
                self.btnReached.setTitle("End Shipment", for: .normal)
            }
            else{
                print("failure")
            }
            }
                        }
        }
    }
    func endRide(params : ParamsAny){
        self.startActivity()
               GCD.async(.Background){
           LoginService.shared().endRide(params: params) { (message, success, response) in
              GCD.async(.Main){
                self.stopActivity()
            if(success){
                
                if let container = self.mainContainer{
            self.database.child("rides").child(Global.shared.requestId).removeAllObservers()
                    container.showHomeController()
                }
               }
               else{
                 print("Failure")
               }
           }
        }
    }
}
}
