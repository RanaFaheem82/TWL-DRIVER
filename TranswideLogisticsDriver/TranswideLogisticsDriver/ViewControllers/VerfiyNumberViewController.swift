//
//  VerfiyNumberViewController.swift
//  Tawrid
//
//  Created by apple on 3/9/20.
//  Copyright © 2020 Rapidzz. All rights reserved.
//

import UIKit
import Firebase

protocol VerfiyNumberViewControllerDelegate : class {
    func IsVerified(isVerified : Bool)
}

class VerfiyNumberViewController: BaseViewController{
    //MARK:- Outlets
    @IBOutlet weak var tfFourthDigit: UITextField!
    @IBOutlet weak var tfThirdDigit: UITextField!
    @IBOutlet weak var tfSecondDigit: UITextField!
    @IBOutlet weak var tfFirstDigit: UITextField!
    @IBOutlet weak var tfFitthDigit: UITextField!
    @IBOutlet weak var tfSixthDigit: UITextField!
    var phoneNumber : String!
    var verificationCode : String!
    var user : UserViewModel!
    weak var delegate : VerfiyNumberViewControllerDelegate!
    
    
    //MARK:- Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tfFirstDigit.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }
    
    
    //MARK:- actions
    @IBAction func actionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func actionResend(_ sender: Any) {
        PhoneAuthProvider.provider().verifyPhoneNumber(self.phoneNumber, uiDelegate: nil) { (verificationID, error) in
            if(error == nil){
                UserDefaultsManager.shared.clearVerificationID()
                UserDefaultsManager.shared.verificationID = verificationID
                self.showAlertView(message: PopupMessages.verification)
            }
            else{
                self.showAlertView(message: PopupMessages.SomethingWentWrong)
            }
        }
    }
    
    @IBAction func actionVerifyCode(_ sender: Any) {
        self.VerificationCode()
        let verificationID = UserDefaultsManager.shared.verificationID
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationID!,
            verificationCode: verificationCode)
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if error != nil {
                self.showAlertView(message: ValidationMessages.WrondPinCode)
            }
            else{
                Global.shared.user = self.user
                self.saveUserInfo(self.user)
                self.showAlertView(message: ValidationMessages.PhoneNumberVerified, title: LocalStrings.success, doneButtonTitle: LocalStrings.ok) { (action) in
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "KYDrawerController") as! KYDrawerController
                            self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
    
    func VerificationCode(){
        verificationCode = self.tfFirstDigit.text
        verificationCode?.append(self.tfSecondDigit.text ?? kBlankString)
        verificationCode?.append(self.tfThirdDigit.text ?? kBlankString)
        verificationCode?.append(self.tfFourthDigit.text ?? kBlankString)
        verificationCode?.append(self.tfFitthDigit.text ?? kBlankString)
        verificationCode?.append(self.tfSixthDigit.text ?? kBlankString)
        print(verificationCode!)
        
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

//MARK:- UI TEXT FEILD DELEGATE.
extension VerfiyNumberViewController : UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if(range.length == 0){
            if(textField == self.tfFirstDigit){
                textField.text = string
                self.tfSecondDigit.becomeFirstResponder()
                return true
                
            }
            else  if(textField == self.tfSecondDigit){
                textField.text = string
                self.tfThirdDigit.becomeFirstResponder()
                return true
            }
            else if(textField == self.tfThirdDigit){
                textField.text = string
                self.tfFourthDigit.becomeFirstResponder()
                return true
                
            }
            else if(textField == self.tfFourthDigit){
                textField.text = string
                self.tfFitthDigit.becomeFirstResponder()
                return true
            }
            else if(textField == self.tfFitthDigit){
                textField.text = string
                self.tfSixthDigit.becomeFirstResponder()
                return true
            }
            else if(textField == self.tfSixthDigit){
                textField.text = string
                self.tfSixthDigit.resignFirstResponder()
                return true
            }
        }
        return true
    }
}
