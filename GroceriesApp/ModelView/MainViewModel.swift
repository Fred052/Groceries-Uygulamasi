//
//  MainViewModel.swift
//  GroceriesApp
//
//  Created by Ferid Suleymanzade on 25.04.24.
//

import SwiftUI

class MainViewModel: ObservableObject {
    static var shared: MainViewModel = MainViewModel()
    
    @Published var txtUserName: String = ""
    @Published var txtEmail: String = ""
    @Published var txtpassword: String = ""
    @Published var isShowPassword: Bool = false
    
    @Published var showError = false
    @Published var errorMessage = ""
    @Published var isUserLogin: Bool = false
    @Published var userObj: UserModel = UserModel(dict: [:])
    
    init() {
        
        if(Utils.UDValueBool(key: Globs.userLogin)) {
            // User Login
            self.setUserData(uDict: Utils.UDValue(key: Globs.userPayload) as? NSDictionary ?? [:])
        }else {
            // User not login
        }
        #if DEBUG
        txtUserName = "user4"
        txtEmail = "test6@gmail.com"
        txtpassword = "123456"
        #endif
    }
    
    func logout() {
        Utils.UDSET(data: false, key: Globs.userLogin)
        isUserLogin = false
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

                    self.setUserData(uDict: response.value(forKey: KKey.payload) as? NSDictionary ?? [:])
                    
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
    
    func ServiceCallSignUp() {
        
        if(txtUserName.isEmpty) {
            self.errorMessage = "Please enter valid username"
            self.showError = true
            return
        }
        
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
        
        
        ServiceCall.post(parameter: ["username": txtUserName, "email": txtEmail, "password": txtpassword, "dervice_token":""], path: Globs.SV_SIGN_UP) { responseObj in
            
            if let response = responseObj as? NSDictionary {
                if response.value(forKey: KKey.status) as? String ?? "" == "1" {
                    self.setUserData(uDict: response.value(forKey: KKey.payload) as? NSDictionary ?? [:])
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
    
    func setUserData(uDict: NSDictionary) {

        Utils.UDSET(data: uDict, key: Globs.userPayload)
        Utils.UDSET(data: true, key: Globs.userLogin)
        self.userObj = UserModel(dict: uDict)
        self.isUserLogin = true
        
        self.txtUserName = ""
        self.txtEmail = ""
        self.txtpassword = ""
        self.isShowPassword = false
    }
}
