//
//  LoginViewController.swift
//  TranswideLogisticsDriver
//
//  Created by apple on 5/2/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: BaseViewController {

    @IBOutlet weak var txtPhon: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func actionLogin(_ sender: Any) {
        if(self.txtPhon.text != EMPTY){
            let params : ParamsAny = ["phoneNumber" : self.txtPhon.text! ,"fcmToken" : Global.shared.FCMToken!]
            self.getUserLogin(params: params)
        }
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "KYDrawerController") as! KYDrawerController
//        self.navigationController?.pushViewController(vc, animated: true)
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

//MARK:- lOGIN API

extension LoginViewController{
    func getUserLogin(params : ParamsAny){
        self.startActivity()
        GCD.async(.Background){
        LoginService.shared().getUserLogin(params: params) { (message, success, user, response) in
            GCD.async(.Main){
            self.stopActivity()
            if(success){
               
                PhoneAuthProvider.provider().verifyPhoneNumber(self.txtPhon.text!, uiDelegate: nil) { (verificationID, error) in
                               if(error == nil){
                                   UserDefaultsManager.shared.verificationID = verificationID
                                   let storyBoard = UIStoryboard(name: StoryboardNames.Main, bundle: nil)
                                   let vc = storyBoard.instantiateViewController(withIdentifier: ControllerIdentifier.VerfiyNumberViewController) as! VerfiyNumberViewController
                                   vc.phoneNumber = self.txtPhon.text
                                   vc.user = user
                                 //  vc.delegate = self
                                   self.navigationController?.pushViewController(vc, animated: true)
                               }
                               else{
                                   self.showAlertView(message: "Cannot send a verification code right now please try again later")
                               }
                           }
                
            }
            else{
                self.showAlertView(message: message)
            }
          }
        }
     }
  }
}
