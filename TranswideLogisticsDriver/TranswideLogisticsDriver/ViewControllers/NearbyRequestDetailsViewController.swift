//
//  NearbyRequestDetailsViewController.swift
//  TranswideLogisticsDriver
//
//  Created by apple on 6/27/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import Firebase

class NearbyRequestDetailsViewController: BaseViewController {

    @IBOutlet weak var lblGoodsInfo: UILabel!
    @IBOutlet weak var lblUserNotes: UILabel!
    @IBOutlet weak var lblGoodWeight: UILabel!
    @IBOutlet weak var lblDestination: UILabel!
    @IBOutlet weak var lblPickup: UILabel!
    var database : DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
        // Do any additional setup after loading the view.
    }
    func configureView(){
         self.database = Database.database().reference()
        print(Global.shared.requestId)
        self.database.child("rides").child(Global.shared.requestId).observeSingleEvent(of: .value, with: { (snapshot) in
          // Get user value
          let value = snapshot.value as? NSDictionary
            self.lblPickup.text = value?["pickup"] as? String ?? ""
            self.lblDestination.text = value?["destination"] as? String ?? ""
            self.lblGoodWeight.text = value?["weight"] as? String ?? ""
            self.lblGoodsInfo.text = value?["GoodsDetails"] as? String ?? ""
            self.lblUserNotes.text = value?["notes"] as? String ?? ""
         

          // ...
          }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    @IBAction func actionAccept(_ sender: Any) {
        let params : ParamsAny = ["driverId" : Global.shared.user!.driverId , "userId" : Global.shared.requestId]
        self.rideAccept(params: params)
        
        
    }
    
    @IBAction func actionIgnore(_ sender: Any) {
        if let continer = self.mainContainer{
            continer.showHomeController()
        }
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

extension NearbyRequestDetailsViewController{
    func rideAccept(params : ParamsAny){
        self.startActivity()
        GCD.async(.Background){
        LoginService.shared().acceptRequest(params: params) { (message, success, response) in
           GCD.async(.Main){
           self.stopActivity()
            if(success){
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                vc.isFromNotification = true
                UserDefaultsManager.shared.isInRide = true
                UserDefaultsManager.shared.rideId = Global.shared.requestId
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else{
                 print("failure")
            }
        }
      }
    }
  }
}
