//
//  FormInfo.swift
//  clothy
//
//  Created by haithem ghattas on 15/11/2022.
//

// 1
import Foundation
import FormValidator
import SwiftUI

// 2
class FormInfo: ObservableObject {
    @Published var newpass: String = ""
    @Published var comfirmpass: String = ""
    
    // 3
    lazy var form = {
        FormValidation(validationType: .immediate)
    }()
    // 4
    lazy var newpassValidation: ValidationContainer = {
        $newpass.nonEmptyValidator(form: form, errorMessage: "password should not be empty")
    }()
    
    lazy var comfirmpassValidation: ValidationContainer = {
        $comfirmpass.nonEmptyValidator(form: form, errorMessage: "password should not be empty")
    }()
   
    

        // $newpass.(form: form, errorMessage: "password should not be empty")
        
    
    
}

