//
//  Validations.swift
//  SimSwitch
//
//  Created by Gulfam Khan on 29/10/2019.
//  Copyright © 2019 Rapidzz. All rights reserved.
//

import Foundation


class Validations {
    
    struct ValidationResult {
        var isValid:Bool
        var text:String
        var message:String
        
        init() {
            isValid = true
            text = kBlankString
            message = kBlankString
        }
        
        init(isValid:Bool, message:String, text:String) {
            self.text = text
            self.isValid = isValid
            self.message = message
        }
    }
    
    class func nameValidation(_ name:String) -> ValidationResult {
        var result = ValidationResult()
        result.text = name
        if name.trim().count == 0 {
            result.isValid = false
            result.message = ValidationMessages.EmptyName
        }
        
        return result
    }
    
    
    class func emailValidation(_ email:String) -> ValidationResult {
        var validationResult = ValidationResult()
        validationResult.text = email
        
        let emailRegEx = EMAIL_REGULAR_EXPRESSION
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: email.trim())
        
        validationResult.isValid = result
        if email.count == 0 {
            validationResult.message = ValidationMessages.EmptyEmail
        }else if !result {
            validationResult.message = ValidationMessages.EnterValidEmail
        }
        
        return validationResult
    }
    
    class func passwordValidation(_ password:String, shouldCheckLength:Bool = true) -> ValidationResult {
        var validationResult = ValidationResult()
        validationResult.isValid = true
        validationResult.text = password
        
        if password.trim().count == kInt0 {
            validationResult.isValid = false
            validationResult.message = ValidationMessages.EmptyPassword
        }
//        else if shouldCheckLength {
//            if password.count < 0 {
//                validationResult.isValid = false
//                validationResult.message = ValidationMessages.ShortPassword
//            }
//        }
//
        return validationResult
    }
    
    class func confirmPasswordValidation(_ password:String, repeat samePassword:String) -> ValidationResult {
        var validationResult = ValidationResult()
        
        if samePassword.count == 0 {
            validationResult.isValid = false
            validationResult.message = ValidationMessages.ReTypePassword
        }else if password != samePassword {
            validationResult.isValid = false
            validationResult.message = ValidationMessages.NonMatchingPassword
        }
        
        return validationResult
    }
}
