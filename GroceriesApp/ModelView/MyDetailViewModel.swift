//
//  MyDetailViewModel.swift
//  GroceriesApp
//
//  Created by Ferid Suleymanzade on 06.06.24.
//

import SwiftUI
import CountryPicker

class MyDetailViewModel: ObservableObject
{
    static var shared: MyDetailViewModel = MyDetailViewModel()
    
    @Published var txtName: String = ""
    @Published var txtMobile: String = ""
    @Published var txtUsername: String = ""
    @Published var txtMobileCode: String = ""
    @State var isShowPicker: Bool = false
    @State var countryObj: Country? {
        didSet {
            if(countryObj != nil) {
                txtMobileCode = "+\(countryObj!.phoneCode)"
            }
        }
    }
    

    @Published var txtCurrentPassword: String = ""
    @Published var txtNewPassword: String = ""
    @Published var txtConfirmPassword: String = "Home"
    
    @Published var isCurrentPassword: Bool = false
    @Published var isNewPassword: Bool = false
    @Published var isConfirmPassword: Bool = false

    @Published var showError = false
    @Published var errorMessage = ""
    
    @Published var listArr: [AddressModel] = []
    
    init() {
        setData()
    }
    
    
    func clearAll() {
        txtName = ""
        txtMobile = ""
        txtUsername = ""
        txtCurrentPassword = ""
        txtMobileCode = ""
        txtNewPassword = ""
        txtConfirmPassword = ""
    }
    
    func setData() {
        var userObj = MainViewModel.shared.userObj
        txtName = userObj.name
        txtMobile = userObj.mobile
        txtMobileCode = userObj.mobile_code
        txtUsername = userObj.username
       
        self.countryObj = Country(phoneCode: txtMobileCode.replacingOccurrences(of: "+", with: ""), isoCode: "AZ")
       
    }
    
    //MARK: serviceCall
    
    func serviceCallUpdate() {
        
        if(txtName.isEmpty) {
            self.errorMessage = "Lütfen isminizi giriniz"
            self.showError = true
            return
        }
        
        if(txtMobile.isEmpty) {
            self.errorMessage = "Lütfen telefon numaranızı giriniz"
            self.showError = true
            return
        }
        
        if(txtUsername.isEmpty) {
            self.errorMessage = "Lütfen kullanıcı adınızı giriniz"
            self.showError = true
            return
        }
        
        
        ServiceCall.post(parameter: ["name": txtName, "mobile": txtMobile, "mobile_code": txtMobileCode, "username": txtUsername], path: Globs.SV_UPDATE_PROFILE, isToken: true) { responseObj in
            
            if let response = responseObj as? NSDictionary {
                if response.value(forKey: KKey.status) as? String ?? "" == "1" {
                    
                    MainViewModel.shared.setUserData(uDict: response.value(forKey: KKey.payload) as? NSDictionary ?? [:])
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
    
    
    func serviceCallChangePassword() {
        
        if(txtCurrentPassword.isEmpty) {
            self.errorMessage = "Lütfen mevcut şifrenizi giriniz"
            self.showError = true
            return
        }
        
        if(txtNewPassword.count < 6) {
            self.errorMessage = "Lütfen minimum 6 karakterden oluşan yeni şifrenizi giriniz"
            self.showError = true
            return
        }
        
        if(txtNewPassword != txtConfirmPassword) {
            self.errorMessage = "şifre eşleşmiyor"
            self.showError = true
            return
        }
        
        ServiceCall.post(parameter: ["current_password": txtCurrentPassword, "new_password": txtNewPassword], path: Globs.SV_CHANGE_PASSWORD, isToken: true) { responseObj in
            
            if let response = responseObj as? NSDictionary {
                if response.value(forKey: KKey.status) as? String ?? "" == "1" {
                    self.txtConfirmPassword = ""
                    self.txtNewPassword = ""
                    self.txtCurrentPassword = ""
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
