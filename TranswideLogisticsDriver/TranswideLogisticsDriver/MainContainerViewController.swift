//
//  MainContainerViewController.swift
//  SimSwitch
//
//  Created by Gulfam Khan on 30/10/2019.
//  Copyright © 2019 Rapidzz. All rights reserved.
//

import UIKit
import CoreLocation

class MainContainerViewController: BaseViewController{
    
    //MARK:- IBoutlets
    @IBOutlet weak var topBarHeight: NSLayoutConstraint!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var btnNearbyHeight: NSLayoutConstraint!
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var HeaderView: UIView!
    @IBOutlet weak var btnMenu: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnNearby: UIButton!
    
    weak var delegate:TopBarDelegate?
    var baseNavigationController: BaseNavigationController?
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var latitude : CLLocationDegrees!
    var longitude : CLLocationDegrees!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupLocationManager()
       self.showHomeController()
    }
    
    func setTitle(title:String) {
        self.titleLabel.text = title
    }
    
    func setMenuButton(isBack:Bool = false)  {
        if(isBack){
            self.btnMenu.removeTarget(nil, action: nil, for: .allEvents)
            self.btnMenu.setImage(UIImage(named: AssetNames.backarrow)!, for: .normal)
            self.btnMenu.addTarget(self, action: #selector(MainContainerViewController.actionBack(_:)), for: .touchUpInside)
        }else{
            self.btnMenu.setImage(UIImage(named: AssetNames.sideLogo)!, for: .normal)
            self.btnMenu.addTarget(self, action: #selector(actionSideMenu(_:)), for: .touchUpInside)
        }
    }
    
   
    @IBAction func actionSideMenu(_ sender: Any) {
        
        if let drawerController = navigationController?.parent as? KYDrawerController {
            drawerController.setDrawerState(.opened, animated: true)
        }
        
    }
    
    //MARK:- FUNCTIONS
    func showHomeController()  {
        let storyBoard = UIStoryboard(name: StoryboardNames.Main, bundle: nil)
        var controller = BaseNavigationController()
        controller = storyBoard.instantiateViewController(withIdentifier: NevigationControllerIdentifiers.HomeVC) as! BaseNavigationController
        if let oldRef = self.baseNavigationController {
            oldRef.viewDidDisappear(true)
            oldRef.view.removeFromSuperview()
        }
        self.baseNavigationController = controller
        addChild(controller)
        controller.view.frame = self.viewContainer.bounds
        self.viewContainer.addSubview(controller.view)
        controller.didMove(toParent: self)
    }
    
    func showNearbyRequestController()  {
          let storyBoard = UIStoryboard(name: StoryboardNames.Main, bundle: nil)
          var controller = BaseNavigationController()
          controller = storyBoard.instantiateViewController(withIdentifier: "NearbyRequestVC") as! BaseNavigationController
          if let oldRef = self.baseNavigationController {
              oldRef.viewDidDisappear(true)
              oldRef.view.removeFromSuperview()
          }
          self.baseNavigationController = controller
          addChild(controller)
          controller.view.frame = self.viewContainer.bounds
          self.viewContainer.addSubview(controller.view)
          controller.didMove(toParent: self)
      }
    
    
    func showProfileController()  {
        let storyBoard = UIStoryboard(name: StoryboardNames.Main, bundle: nil)
        var controller = BaseNavigationController()
        controller = storyBoard.instantiateViewController(withIdentifier: NevigationControllerIdentifiers.ProfileVC) as! BaseNavigationController
        if let oldRef = self.baseNavigationController {
            oldRef.viewDidDisappear(true)
            oldRef.view.removeFromSuperview()
        }
        self.baseNavigationController = controller
        addChild(controller)
        controller.view.frame = self.viewContainer.bounds
        self.viewContainer.addSubview(controller.view)
        controller.didMove(toParent: self)
    }
    
    func showAddVehicleController()  {
          let storyBoard = UIStoryboard(name: StoryboardNames.Main, bundle: nil)
          var controller = BaseNavigationController()
          controller = storyBoard.instantiateViewController(withIdentifier: NevigationControllerIdentifiers.AddVehicleVC) as! BaseNavigationController
          if let oldRef = self.baseNavigationController {
              oldRef.viewDidDisappear(true)
              oldRef.view.removeFromSuperview()
          }
          self.baseNavigationController = controller
          addChild(controller)
          controller.view.frame = self.viewContainer.bounds
          self.viewContainer.addSubview(controller.view)
          controller.didMove(toParent: self)
      }
    
    func showPersonalDocumentController(){
        let storyBoard = UIStoryboard(name: StoryboardNames.Main, bundle: nil)
                var controller = BaseNavigationController()
        controller = storyBoard.instantiateViewController(withIdentifier: NevigationControllerIdentifiers.PersonalDocumentVC) as! BaseNavigationController
                if let oldRef = self.baseNavigationController {
                    oldRef.viewDidDisappear(true)
                    oldRef.view.removeFromSuperview()
                }
                self.baseNavigationController = controller
                addChild(controller)
                controller.view.frame = self.viewContainer.bounds
                self.viewContainer.addSubview(controller.view)
                controller.didMove(toParent: self)
    }
 

    
    
    
    func logoutUser()  {
        
        Global.shared.user = nil
        Global.shared.isLogedIn = false
        UserDefaultsManager.shared.clearUserData()
        
        UserDefaultsManager.shared.clearCart()
        let storyboard = UIStoryboard(name: StoryboardNames.Main, bundle: nil)
       // let controller = storyboard.instantiateViewController(withIdentifier: ControllerIdentifier.LoginViewController) as! LoginViewController
//        if let container = self.navigationController?.parent as? KYDrawerController {
//            container.navigationController?.setViewControllers([controller], animated: true)
//            container.navigationController?.popToRootViewController(animated: true)
//        }
        
    }
    @IBAction func actionEditAndSave(_ sender: UIButton){
        Global.shared.drawerController = self.navigationController?.parent as? KYDrawerController
        if(DeviceType.IS_IPAD){
            Global.shared.drawerController?.drawerWidth = 500
        }
        Global.shared.drawerController!.setDrawerState(.opened, animated: true)
    }
    
    @IBAction func actionBack(_ sender: Any) {
        delegate?.actionBack()
    }
    
    @IBAction func actionRightButton(_ sender: Any) {
        if let delegate = self.delegate {
            delegate.rightButtonAction()
        }
    }
    

}

//MARK:- CLLOCATION MANAGER DELEGATE
extension MainContainerViewController : CLLocationManagerDelegate{
    
    func setupLocationManager(){
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //  let location: CLLocation = manager.location!
        let userLocation:CLLocation = locations[0] as CLLocation
        self.latitude = userLocation.coordinate.latitude
        self.longitude = userLocation.coordinate.longitude
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
      //  self.showAlertView(message: error as! String)
    }
}






