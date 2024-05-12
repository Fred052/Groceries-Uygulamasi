//
//  MainViewModel.swift
//  GroceriesApp
//
//  Created by Ferid Suleymanzade on 25.04.24.
//

import SwiftUI

class MainViewModel: ObservableObject {
    static var shared: MainViewModel = MainViewModel()
    
    @Published var txtEmail: String = ""
    @Published var txtpassword: String = ""
    @Published var isShowPassword: Bool = false
    
    @Published var showError = false
    @Published var errorMessage = ""
    
    init() {
        #if DEBUG
        txtEmail = "test@gmail.com"
        txtpassword = "123456"
        #endif
    }
    
    //Mark: ServiceCall
    func ServiceCallLogin() {
        
        if(!txtEmail.isValidEmail) {
            self.errorMessage = "Please enter valid email address"
            self.showError = true
            return
        }
        
        if(txtpassword.isEmpty) {
            self.errorMessage = "Please enter valid password"
            self.showError = true
            return
        }
        
        
        ServiceCall.post(parameter: ["email": txtEmail, "password": txtpassword, "dervice_token":""], path: Globs.SV_LOGIN) { responseObj in
            
            if let response = responseObj as? NSDictionary {
                if response.value(forKey: KKey.status) as? String ?? "" == "1" {
                    self.errorMessage = response.value(forKey: KKey.message) as? String ?? "Success"
                    self.showError = true
                }else {
                    self.errorMessage = response.value(forKey: KKey.message) as? String ?? "Fail"
                    self.showError = true
                }
            }
        } failure: { error in
            self.errorMessage = error?.localizedDescription ?? "Fail"
            self.showError = true
        }

    }
}
